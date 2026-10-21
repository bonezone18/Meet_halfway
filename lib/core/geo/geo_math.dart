import 'dart:math' as math;

import 'package:meet_halfway/core/geo/geo_point.dart';

/// Spherical geometry helpers. All distances are in meters.
abstract final class GeoMath {
  static const double earthRadiusMeters = 6371008.8;

  /// Great-circle distance between [a] and [b] (haversine formula).
  static double distanceMeters(GeoPoint a, GeoPoint b) {
    final lat1 = _rad(a.latitude);
    final lat2 = _rad(b.latitude);
    final dLat = lat2 - lat1;
    final dLon = _rad(b.longitude - a.longitude);
    final h =
        math.pow(math.sin(dLat / 2), 2) +
        math.cos(lat1) * math.cos(lat2) * math.pow(math.sin(dLon / 2), 2);
    return 2 * earthRadiusMeters * math.asin(math.min(1, math.sqrt(h)));
  }

  /// Weighted spherical centroid of [points].
  ///
  /// Points are converted to 3D unit vectors, averaged, and projected back to
  /// the sphere. This is correct across the antimeridian and for long
  /// north-south spans, unlike averaging latitudes/longitudes directly. For two
  /// points with equal weights this is the great-circle midpoint.
  ///
  /// [weights] defaults to equal weights. A larger weight pulls the result
  /// toward that point.
  static GeoPoint centroid(List<GeoPoint> points, {List<double>? weights}) {
    if (points.isEmpty) {
      throw ArgumentError.value(points, 'points', 'must not be empty');
    }
    if (weights != null && weights.length != points.length) {
      throw ArgumentError.value(weights, 'weights', 'length mismatch');
    }
    var x = 0.0;
    var y = 0.0;
    var z = 0.0;
    var total = 0.0;
    for (var i = 0; i < points.length; i++) {
      final w = weights?[i] ?? 1.0;
      final lat = _rad(points[i].latitude);
      final lon = _rad(points[i].longitude);
      x += w * math.cos(lat) * math.cos(lon);
      y += w * math.cos(lat) * math.sin(lon);
      z += w * math.sin(lat);
      total += w;
    }
    if (total <= 0) {
      throw ArgumentError.value(weights, 'weights', 'must sum to > 0');
    }
    x /= total;
    y /= total;
    z /= total;
    // Antipodal inputs have no defined midpoint; fall back to the first point.
    if (x.abs() < 1e-12 && y.abs() < 1e-12 && z.abs() < 1e-12) {
      return points.first;
    }
    return GeoPoint(
      latitude: _deg(math.atan2(z, math.sqrt(x * x + y * y))),
      longitude: _deg(math.atan2(y, x)),
    );
  }

  /// Smallest lat/lng box containing all [points] (for fitting a map camera).
  static ({GeoPoint southwest, GeoPoint northeast}) bounds(
    Iterable<GeoPoint> points,
  ) {
    if (points.isEmpty) {
      throw ArgumentError.value(points, 'points', 'must not be empty');
    }
    var minLat = double.infinity;
    var maxLat = double.negativeInfinity;
    var minLng = double.infinity;
    var maxLng = double.negativeInfinity;
    for (final p in points) {
      minLat = math.min(minLat, p.latitude);
      maxLat = math.max(maxLat, p.latitude);
      minLng = math.min(minLng, p.longitude);
      maxLng = math.max(maxLng, p.longitude);
    }
    return (
      southwest: GeoPoint(latitude: minLat, longitude: minLng),
      northeast: GeoPoint(latitude: maxLat, longitude: maxLng),
    );
  }

  static double _rad(double deg) => deg * math.pi / 180;
  static double _deg(double rad) => rad * 180 / math.pi;
}
