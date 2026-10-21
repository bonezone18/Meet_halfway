import 'dart:math' as math;

import 'package:meet_halfway/features/meetup/domain/meetup_plan.dart';
import 'package:meet_halfway/features/places/domain/places_repository.dart';
import 'package:meet_halfway/features/places/domain/venue.dart';
import 'package:meet_halfway/features/places/domain/venue_category.dart';

/// Finds venues around a plan's midpoint.
///
/// Searches each category in parallel (so one popular category doesn't crowd
/// out the others), de-duplicates, and widens the radius when the area around
/// the midpoint is empty (e.g. the midpoint lands in a forest or a lake).
class VenueSearchService {
  const VenueSearchService(this._repository);

  final PlacesRepository _repository;

  static const radiusGrowthFactor = 2.5;

  Future<List<Venue>> search(
    MeetupPlan plan,
    Set<VenueCategory> categories,
  ) async {
    if (categories.isEmpty) return const [];
    for (final radius in radiiFor(plan.searchRadiusMeters)) {
      final results = await Future.wait([
        for (final category in categories)
          _repository.searchNearby(
            center: plan.midpoint,
            radiusMeters: radius,
            category: category,
          ),
      ]);
      final unique = <String, Venue>{
        for (final venue in results.expand((r) => r)) venue.id: venue,
      };
      if (unique.isNotEmpty) return unique.values.toList();
    }
    return const [];
  }

  /// The initial radius followed by progressively wider ones, capped at the
  /// API maximum.
  static List<double> radiiFor(double initial) {
    final radii = <double>[initial];
    while (radii.last < MeetupPlan.maxSearchRadiusMeters) {
      radii.add(
        math.min(
          radii.last * radiusGrowthFactor,
          MeetupPlan.maxSearchRadiusMeters,
        ),
      );
    }
    return radii;
  }
}
