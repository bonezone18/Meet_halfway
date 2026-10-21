import 'package:meet_halfway/core/geo/geo_math.dart';
import 'package:meet_halfway/core/geo/geo_point.dart';

/// Decides where "halfway" is.
///
/// Extension point: a travel-time strategy (e.g. iteratively minimising the
/// max drive time via the Routes API) can implement this and be swapped in by
/// overriding `midpointStrategyProvider`.
abstract interface class MidpointStrategy {
  String get label;

  Future<GeoPoint> midpointOf(List<GeoPoint> origins);
}

/// The spherical centroid of all origins ("as the crow flies").
class GeographicMidpointStrategy implements MidpointStrategy {
  const GeographicMidpointStrategy();

  @override
  String get label => 'Geographic midpoint';

  @override
  Future<GeoPoint> midpointOf(List<GeoPoint> origins) async =>
      GeoMath.centroid(origins);
}
