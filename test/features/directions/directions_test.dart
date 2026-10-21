import 'package:flutter_test/flutter_test.dart';
import 'package:meet_halfway/features/directions/data/google_routes_repository.dart';
import 'package:meet_halfway/features/directions/data/map_launcher.dart';
import 'package:meet_halfway/features/directions/domain/route_summary.dart';
import 'package:meet_halfway/features/directions/domain/travel_mode.dart';

import '../../helpers/fakes.dart';

void main() {
  group('GoogleRoutesRepository', () {
    test('parses duration strings and distance', () {
      expect(
        GoogleRoutesRepository.parseRoute({
          'routes': [
            {'duration': '1834s', 'distanceMeters': 42000},
          ],
        }),
        const RouteSummary(
          duration: Duration(seconds: 1834),
          distanceMeters: 42000,
        ),
      );
    });

    test('no routes means null (e.g. no transit)', () {
      expect(GoogleRoutesRepository.parseRoute({}), isNull);
      expect(GoogleRoutesRepository.parseRoute({'routes': <Object>[]}), isNull);
    });

    test('only driving requests traffic-aware routing', () async {
      final adapter = FakeHttpAdapter({'routes': <Object>[]});
      final repo = GoogleRoutesRepository(dioWith(adapter));

      await repo.route(
        origin: newYork,
        destination: philadelphia,
        mode: TravelMode.drive,
      );
      var body = adapter.lastRequest!.data as Map<String, dynamic>;
      expect(body['travelMode'], 'DRIVE');
      expect(body['routingPreference'], 'TRAFFIC_AWARE');

      await repo.route(
        origin: newYork,
        destination: philadelphia,
        mode: TravelMode.walk,
      );
      body = adapter.lastRequest!.data as Map<String, dynamic>;
      expect(body['travelMode'], 'WALK');
      expect(body.containsKey('routingPreference'), isFalse);
    });
  });

  group('MapLauncher', () {
    test('Google Maps URL includes origin, destination and mode', () {
      final uri = MapLauncher.googleMapsDirections(
        origin: newYork,
        destination: philadelphia,
        destinationPlaceId: 'pid',
        mode: TravelMode.transit,
      );
      expect(uri.host, 'www.google.com');
      expect(uri.queryParameters, {
        'api': '1',
        'origin': '40.7128,-74.006',
        'destination': '39.9526,-75.1652',
        'destination_place_id': 'pid',
        'travelmode': 'transit',
      });
    });

    test('Apple Maps URL uses dirflg', () {
      final uri = MapLauncher.appleMapsDirections(
        destination: philadelphia,
        mode: TravelMode.walk,
      );
      expect(uri.host, 'maps.apple.com');
      expect(uri.queryParameters['dirflg'], 'w');
      expect(uri.queryParameters.containsKey('saddr'), isFalse);
    });
  });
}
