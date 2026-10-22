import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:meet_halfway/core/geo/geo_point.dart';
import 'package:meet_halfway/features/locations/domain/location_repository.dart';
import 'package:meet_halfway/features/locations/domain/participant.dart';
import 'package:meet_halfway/features/locations/domain/selected_location.dart';
import 'package:meet_halfway/features/meetup/domain/meetup_plan.dart';
import 'package:meet_halfway/features/places/domain/places_repository.dart';
import 'package:meet_halfway/features/places/domain/venue.dart';
import 'package:meet_halfway/features/places/domain/venue_category.dart';

const newYork = GeoPoint(latitude: 40.7128, longitude: -74.0060);
const philadelphia = GeoPoint(latitude: 39.9526, longitude: -75.1652);

Participant participantAt(String id, GeoPoint point, {String? name}) =>
    Participant(
      id: id,
      name: name ?? id,
      location: SelectedLocation(label: '$id place', point: point),
    );

MeetupPlan planBetween(GeoPoint a, GeoPoint b, {required GeoPoint midpoint}) =>
    MeetupPlan(
      participants: [participantAt('a', a), participantAt('b', b)],
      midpoint: midpoint,
    );

Venue venue(
  String id, {
  required GeoPoint at,
  double? rating,
  PriceLevel? price,
  bool? openNow,
}) => Venue(
  id: id,
  name: 'Venue $id',
  location: at,
  rating: rating,
  priceLevel: price,
  openNow: openNow,
);

/// In-memory [PlacesRepository] that records every search.
class FakePlacesRepository implements PlacesRepository {
  FakePlacesRepository(this.resultsFor);

  /// Returns venues for a (category, radius) search.
  final List<Venue> Function(VenueCategory category, double radius) resultsFor;
  final searches = <({VenueCategory category, double radius})>[];

  @override
  Future<List<Venue>> searchNearby({
    required GeoPoint center,
    required double radiusMeters,
    required VenueCategory category,
    int maxResults = 20,
  }) async {
    searches.add((category: category, radius: radiusMeters));
    return resultsFor(category, radiusMeters);
  }

  @override
  Future<VenueDetails> details(String venueId) async =>
      VenueDetails(venue: venue(venueId, at: newYork));

  @override
  VenuePhoto? photo(String photoName, {int maxWidthPx = 400}) => null;
}

class FakeDeviceLocationSource implements DeviceLocationSource {
  FakeDeviceLocationSource(this.result);

  final Future<GeoPoint> Function() result;

  @override
  Future<GeoPoint> currentPosition() => result();
}

/// Dio adapter returning canned JSON and recording the last request.
class FakeHttpAdapter implements HttpClientAdapter {
  FakeHttpAdapter(this.body, {this.statusCode = 200});

  final Object body;
  final int statusCode;
  RequestOptions? lastRequest;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    lastRequest = options;
    return ResponseBody.fromString(
      jsonEncode(body),
      statusCode,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

Dio dioWith(FakeHttpAdapter adapter) => Dio()..httpClientAdapter = adapter;

/// Small helpers for building coordinate fixtures concisely.
abstract final class GeoPointPair {
  /// Two points ~500 m apart in Manhattan.
  static const close = (
    GeoPoint(latitude: 40.7580, longitude: -73.9855),
    GeoPoint(latitude: 40.7614, longitude: -73.9776),
  );

  static GeoPoint from(({double latitude, double longitude}) p) =>
      GeoPoint(latitude: p.latitude, longitude: p.longitude);
}
