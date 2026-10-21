import 'package:flutter_test/flutter_test.dart';
import 'package:meet_halfway/core/error/failure.dart';
import 'package:meet_halfway/core/geo/geo_point.dart';
import 'package:meet_halfway/features/locations/data/google_location_repository.dart';
import 'package:meet_halfway/features/locations/domain/place_suggestion.dart';

import '../../helpers/fakes.dart';

void main() {
  test('parses autocomplete suggestions and skips query predictions', () {
    final suggestions = GoogleLocationRepository.parseAutocomplete({
      'suggestions': [
        {
          'placePrediction': {
            'placeId': 'abc',
            'text': {'text': 'Central Park, New York, NY, USA'},
            'structuredFormat': {
              'mainText': {'text': 'Central Park'},
              'secondaryText': {'text': 'New York, NY, USA'},
            },
          },
        },
        {
          'queryPrediction': {
            'text': {'text': 'central park cafes'},
          },
        },
      ],
    });
    expect(suggestions, [
      const PlaceSuggestion(
        placeId: 'abc',
        primaryText: 'Central Park',
        secondaryText: 'New York, NY, USA',
      ),
    ]);
  });

  test('empty input makes no request', () async {
    final adapter = FakeHttpAdapter(const <String, Object>{});
    final repo = GoogleLocationRepository(dioWith(adapter));
    expect(await repo.autocomplete('   '), isEmpty);
    expect(adapter.lastRequest, isNull);
  });

  test(
    'resolve requests a minimal field mask and returns coordinates',
    () async {
      final adapter = FakeHttpAdapter({
        'id': 'abc',
        'location': {'latitude': 40.78, 'longitude': -73.96},
      });
      final repo = GoogleLocationRepository(dioWith(adapter));
      final location = await repo.resolve(
        const PlaceSuggestion(placeId: 'abc', primaryText: 'Central Park'),
      );
      expect(
        location.point,
        const GeoPoint(latitude: 40.78, longitude: -73.96),
      );
      expect(location.label, 'Central Park');
      expect(
        adapter.lastRequest!.headers['X-Goog-FieldMask'],
        'id,formattedAddress,location',
      );
    },
  );

  test('API errors become ApiFailure with Google message', () async {
    final adapter = FakeHttpAdapter({
      'error': {'message': 'API key not valid.', 'status': 'INVALID_ARGUMENT'},
    }, statusCode: 400);
    final repo = GoogleLocationRepository(dioWith(adapter));
    await expectLater(
      repo.autocomplete('pizza'),
      throwsA(
        isA<ApiFailure>().having(
          (f) => f.message,
          'message',
          'API key not valid.',
        ),
      ),
    );
  });
}
