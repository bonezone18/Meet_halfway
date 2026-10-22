import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meet_halfway/core/config/app_config.dart';
import 'package:meet_halfway/core/error/failure.dart';
import 'package:meet_halfway/core/geo/geo_point.dart';
import 'package:meet_halfway/core/network/dio_client.dart';
import 'package:meet_halfway/features/places/data/place_dto.dart';
import 'package:meet_halfway/features/places/domain/places_repository.dart';
import 'package:meet_halfway/features/places/domain/venue.dart';
import 'package:meet_halfway/features/places/domain/venue_category.dart';

/// [PlacesRepository] backed by Places API (New).
class GooglePlacesRepository implements PlacesRepository {
  GooglePlacesRepository(this._dio, this._apiKey);

  final Dio _dio;
  final String _apiKey;

  static const _baseUrl = 'https://places.googleapis.com/v1';

  /// Requesting only what we display keeps responses small and billing in the
  /// cheapest SKU possible.
  static const List<String> _venueFields = [
    'id',
    'displayName',
    'formattedAddress',
    'shortFormattedAddress',
    'location',
    'types',
    'primaryTypeDisplayName',
    'rating',
    'userRatingCount',
    'priceLevel',
    'currentOpeningHours.openNow',
    'photos',
    'googleMapsUri',
  ];

  static const List<String> _detailFields = [
    ..._venueFields,
    'currentOpeningHours',
    'regularOpeningHours',
    'nationalPhoneNumber',
    'websiteUri',
    'editorialSummary',
  ];

  @override
  Future<List<Venue>> searchNearby({
    required GeoPoint center,
    required double radiusMeters,
    required VenueCategory category,
    int maxResults = 20,
  }) async {
    final response = await guardRequest(
      () => _dio.post<Map<String, dynamic>>(
        '$_baseUrl/places:searchNearby',
        data: {
          'includedTypes': [category.apiType],
          'maxResultCount': maxResults,
          'rankPreference': 'DISTANCE',
          'locationRestriction': {
            'circle': {
              'center': {
                'latitude': center.latitude,
                'longitude': center.longitude,
              },
              'radius': radiusMeters,
            },
          },
        },
        options: Options(
          headers: {
            'X-Goog-FieldMask': _venueFields.map((f) => 'places.$f').join(','),
          },
        ),
      ),
    );
    return parseSearchResponse(response.data);
  }

  @override
  Future<VenueDetails> details(String venueId) async {
    final response = await guardRequest(
      () => _dio.get<Map<String, dynamic>>(
        '$_baseUrl/places/$venueId',
        options: Options(
          headers: {'X-Goog-FieldMask': _detailFields.join(',')},
        ),
      ),
    );
    final details = PlaceDto.fromJson(response.data ?? const {}).toDetails();
    if (details == null) throw const NotFoundFailure('Venue not found.');
    return details;
  }

  /// The key stays in the query string for web, where image requests can't
  /// carry custom headers (the browser's Referer satisfies web-restricted
  /// keys). Native platforms also send the client's headers, which include
  /// the app identity that Android/iOS-restricted keys require.
  @override
  VenuePhoto? photo(String photoName, {int maxWidthPx = 400}) => VenuePhoto(
    url: Uri.https('places.googleapis.com', '/v1/$photoName/media', {
      'maxWidthPx': '$maxWidthPx',
      'key': _apiKey,
    }).toString(),
    headers: {
      for (final MapEntry(:key, :value) in _dio.options.headers.entries)
        if (value is String) key: value,
    },
  );

  /// Exposed for testing against recorded API responses.
  static List<Venue> parseSearchResponse(Map<String, dynamic>? data) {
    final places = (data?['places'] as List<dynamic>?) ?? const [];
    return [
      for (final json in places.cast<Map<String, dynamic>>())
        ?PlaceDto.fromJson(json).toVenue(),
    ];
  }
}

final placesRepositoryProvider = Provider<PlacesRepository>(
  (ref) => GooglePlacesRepository(
    ref.watch(dioProvider),
    ref.watch(appConfigProvider).googleMapsApiKey,
  ),
);
