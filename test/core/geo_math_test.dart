import 'package:flutter_test/flutter_test.dart';
import 'package:meet_halfway/core/geo/geo_math.dart';
import 'package:meet_halfway/core/geo/geo_point.dart';

import '../helpers/fakes.dart';

void main() {
  group('distanceMeters', () {
    test('New York to Philadelphia is ~130 km', () {
      final d = GeoMath.distanceMeters(newYork, philadelphia);
      expect(d, closeTo(129600, 1500));
    });

    test('is zero for identical points and symmetric', () {
      expect(GeoMath.distanceMeters(newYork, newYork), 0);
      expect(
        GeoMath.distanceMeters(newYork, philadelphia),
        closeTo(GeoMath.distanceMeters(philadelphia, newYork), 1e-6),
      );
    });
  });

  group('centroid', () {
    test('two-point midpoint is equidistant from both', () {
      final mid = GeoMath.centroid([newYork, philadelphia]);
      expect(
        GeoMath.distanceMeters(newYork, mid),
        closeTo(GeoMath.distanceMeters(philadelphia, mid), 1),
      );
    });

    test('handles long north-south spans', () {
      const seattle = GeoPoint(latitude: 47.6062, longitude: -122.3321);
      const sanDiego = GeoPoint(latitude: 32.7157, longitude: -117.1611);
      final mid = GeoMath.centroid([seattle, sanDiego]);
      expect(mid.latitude, inInclusiveRange(39.5, 40.5));
      expect(
        GeoMath.distanceMeters(seattle, mid),
        closeTo(GeoMath.distanceMeters(sanDiego, mid), 1),
      );
    });

    test('crosses the antimeridian instead of going the long way', () {
      const fiji = GeoPoint(latitude: -17, longitude: 179);
      const samoa = GeoPoint(latitude: -13, longitude: -171);
      final mid = GeoMath.centroid([fiji, samoa]);
      expect(mid.longitude.abs(), greaterThan(170));
    });

    test('weights pull the midpoint toward the heavier point', () {
      final mid = GeoMath.centroid([newYork, philadelphia], weights: [3, 1]);
      expect(
        GeoMath.distanceMeters(newYork, mid),
        lessThan(GeoMath.distanceMeters(philadelphia, mid)),
      );
    });

    test('supports more than two points', () {
      const boston = GeoPoint(latitude: 42.3601, longitude: -71.0589);
      final mid = GeoMath.centroid([newYork, philadelphia, boston]);
      expect(mid.latitude, inInclusiveRange(39.9, 42.4));
      expect(mid.longitude, inInclusiveRange(-75.2, -71));
    });

    test('rejects empty input and mismatched weights', () {
      expect(() => GeoMath.centroid([]), throwsArgumentError);
      expect(
        () => GeoMath.centroid([newYork], weights: [1, 2]),
        throwsArgumentError,
      );
    });
  });

  test('bounds contains all points', () {
    final b = GeoMath.bounds([newYork, philadelphia]);
    expect(b.southwest, const GeoPoint(latitude: 39.9526, longitude: -75.1652));
    expect(b.northeast, const GeoPoint(latitude: 40.7128, longitude: -74.0060));
  });
}
