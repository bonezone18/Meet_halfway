import 'package:meet_halfway/core/geo/geo_point.dart';
import 'package:meet_halfway/features/directions/domain/route_summary.dart';
import 'package:meet_halfway/features/directions/domain/travel_mode.dart';

abstract interface class DirectionsRepository {
  /// The best route from [origin] to [destination], or null if none exists
  /// for [mode] (e.g. no transit service).
  Future<RouteSummary?> route({
    required GeoPoint origin,
    required GeoPoint destination,
    required TravelMode mode,
  });
}
