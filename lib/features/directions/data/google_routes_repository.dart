import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meet_halfway/core/geo/geo_point.dart';
import 'package:meet_halfway/core/network/dio_client.dart';
import 'package:meet_halfway/features/directions/domain/directions_repository.dart';
import 'package:meet_halfway/features/directions/domain/route_summary.dart';
import 'package:meet_halfway/features/directions/domain/travel_mode.dart';

/// [DirectionsRepository] backed by the Routes API.
/// https://developers.google.com/maps/documentation/routes/compute_route_directions
class GoogleRoutesRepository implements DirectionsRepository {
  GoogleRoutesRepository(this._dio);

  final Dio _dio;

  @override
  Future<RouteSummary?> route({
    required GeoPoint origin,
    required GeoPoint destination,
    required TravelMode mode,
  }) async {
    final response = await guardRequest(
      () => _dio.post<Map<String, dynamic>>(
        'https://routes.googleapis.com/directions/v2:computeRoutes',
        data: {
          'origin': _waypoint(origin),
          'destination': _waypoint(destination),
          'travelMode': mode.routesApiValue,
          if (mode == TravelMode.drive) 'routingPreference': 'TRAFFIC_AWARE',
        },
        options: Options(
          headers: {
            'X-Goog-FieldMask': 'routes.duration,routes.distanceMeters',
          },
        ),
      ),
    );
    return parseRoute(response.data);
  }

  static Map<String, dynamic> _waypoint(GeoPoint p) => {
    'location': {
      'latLng': {'latitude': p.latitude, 'longitude': p.longitude},
    },
  };

  /// Exposed for testing. Durations come back as strings like `"1234s"`.
  static RouteSummary? parseRoute(Map<String, dynamic>? data) {
    final routes = data?['routes'] as List<dynamic>?;
    if (routes == null || routes.isEmpty) return null;
    final route = routes.first as Map<String, dynamic>;
    final seconds = double.tryParse(
      (route['duration'] as String? ?? '0s').replaceAll('s', ''),
    );
    return RouteSummary(
      duration: Duration(seconds: (seconds ?? 0).round()),
      distanceMeters: (route['distanceMeters'] as num?)?.toInt() ?? 0,
    );
  }
}

final directionsRepositoryProvider = Provider<DirectionsRepository>(
  (ref) => GoogleRoutesRepository(ref.watch(dioProvider)),
);
