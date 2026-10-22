import 'package:flutter_test/flutter_test.dart';
import 'package:meet_halfway/core/geo/geo_point.dart';
import 'package:meet_halfway/features/places/data/google_places_repository.dart';
import 'package:meet_halfway/features/places/domain/venue.dart';
import 'package:meet_halfway/features/places/domain/venue_category.dart';

import '../../helpers/fakes.dart';

const Map<String, List<Map<String, Object>>> _searchResponse = {
  'places': [
    {
      'id': 'cafe-1',
      'displayName': {'text': 'Bean There', 'languageCode': 'en'},
      'formattedAddress': '1 Main St, Trenton, NJ 08608, USA',
      'shortFormattedAddress': '1 Main St, Trenton',
      'location': {'latitude': 40.22, 'longitude': -74.76},
      'types': ['cafe', 'food', 'point_of_interest'],
      'primaryTypeDisplayName': {'text': 'Coffee Shop'},
      'rating': 4.6,
      'userRatingCount': 212,
      'priceLevel': 'PRICE_LEVEL_INEXPENSIVE',
      'currentOpeningHours': {'openNow': true},
      'photos': [
        {'name': 'places/cafe-1/photos/p1', 'widthPx': 800},
      ],
      'googleMapsUri': 'https://maps.google.com/?cid=1',
    },
    // Missing location: should be skipped rather than crash.
    {
      'id': 'broken',
      'displayName': {'text': 'Nowhere'},
    },
  ],
};

void main() {
  test('parses venues and skips incomplete places', () {
    final venues = GooglePlacesRepository.parseSearchResponse(_searchResponse);
    expect(venues, hasLength(1));
    final v = venues.single;
    expect(v.name, 'Bean There');
    expect(v.address, '1 Main St, Trenton');
    expect(v.location, const GeoPoint(latitude: 40.22, longitude: -74.76));
    expect(v.priceLevel, PriceLevel.inexpensive);
    expect(v.openNow, isTrue);
    expect(v.photoName, 'places/cafe-1/photos/p1');
    expect(v.primaryTypeLabel, 'Coffee Shop');
  });

  test('empty responses parse to an empty list', () {
    expect(GooglePlacesRepository.parseSearchResponse({}), isEmpty);
  });

  test('searchNearby sends type, radius and a places.* field mask', () async {
    final adapter = FakeHttpAdapter(_searchResponse);
    final repo = GooglePlacesRepository(dioWith(adapter), 'key');
    await repo.searchNearby(
      center: newYork,
      radiusMeters: 5000,
      category: VenueCategory.cafe,
    );
    final request = adapter.lastRequest!;
    final body = request.data as Map<String, dynamic>;
    expect(body['includedTypes'], ['cafe']);
    expect(
      (body['locationRestriction'] as Map)['circle'],
      containsPair('radius', 5000.0),
    );
    final mask = request.headers['X-Goog-FieldMask'] as String;
    expect(mask.split(',').every((f) => f.startsWith('places.')), isTrue);
  });

  test('details maps phone, website and hours', () async {
    final adapter = FakeHttpAdapter({
      ...(_searchResponse['places']!.first),
      'nationalPhoneNumber': '(609) 555-0100',
      'websiteUri': 'https://bean.example',
      'regularOpeningHours': {
        'weekdayDescriptions': ['Monday: 7:00 AM – 5:00 PM'],
      },
    });
    final repo = GooglePlacesRepository(dioWith(adapter), 'key');
    final details = await repo.details('cafe-1');
    expect(details.phoneNumber, '(609) 555-0100');
    expect(details.websiteUri, 'https://bean.example');
    expect(details.weeklyHours, ['Monday: 7:00 AM – 5:00 PM']);
  });

  test('photo targets the media endpoint with the client headers', () {
    final dio = dioWith(FakeHttpAdapter({}))
      ..options.headers.addAll({
        'X-Goog-Api-Key': 'k',
        'X-Android-Package': 'com.pkg',
        'X-Android-Cert': 'F00',
      });
    final photo = GooglePlacesRepository(
      dio,
      'k',
    ).photo('places/x/photos/y', maxWidthPx: 200)!;
    final url = Uri.parse(photo.url);
    expect(url.host, 'places.googleapis.com');
    expect(url.path, '/v1/places/x/photos/y/media');
    expect(url.queryParameters['maxWidthPx'], '200');
    expect(photo.headers, containsPair('X-Android-Package', 'com.pkg'));
    expect(photo.headers, containsPair('X-Android-Cert', 'F00'));
    expect(photo.headers, containsPair('X-Goog-Api-Key', 'k'));
  });
}
