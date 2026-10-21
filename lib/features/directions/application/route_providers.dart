import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:meet_halfway/core/geo/geo_point.dart';
import 'package:meet_halfway/features/directions/data/google_routes_repository.dart';
import 'package:meet_halfway/features/directions/domain/route_summary.dart';
import 'package:meet_halfway/features/directions/domain/travel_mode.dart';

class TravelModeController extends Notifier<TravelMode> {
  @override
  TravelMode build() => TravelMode.drive;

  void select(TravelMode mode) => state = mode;
}

final travelModeProvider = NotifierProvider<TravelModeController, TravelMode>(
  TravelModeController.new,
);

typedef RouteRequest = ({
  GeoPoint origin,
  GeoPoint destination,
  TravelMode mode,
});

/// Cached per (origin, destination, mode) while in use.
final FutureProviderFamily<RouteSummary?, RouteRequest> routeSummaryProvider =
    FutureProvider.autoDispose.family<RouteSummary?, RouteRequest>(
      (ref, request) => ref
          .watch(directionsRepositoryProvider)
          .route(
            origin: request.origin,
            destination: request.destination,
            mode: request.mode,
          ),
    );
