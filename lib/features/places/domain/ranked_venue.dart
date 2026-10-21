import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meet_halfway/core/geo/geo_math.dart';
import 'package:meet_halfway/features/meetup/domain/fairness.dart';
import 'package:meet_halfway/features/meetup/domain/meetup_plan.dart';
import 'package:meet_halfway/features/places/domain/venue.dart';
import 'package:meet_halfway/features/places/domain/venue_filter.dart';

part 'ranked_venue.freezed.dart';

/// A [Venue] with distances computed relative to a [MeetupPlan].
@freezed
abstract class RankedVenue with _$RankedVenue {
  const factory RankedVenue({
    required Venue venue,

    /// Straight-line distance from each participant, in plan order.
    required List<double> distancesMeters,
    required double distanceFromMidpointMeters,
    required Fairness fairness,
  }) = _RankedVenue;

  factory RankedVenue.fromPlan(Venue venue, MeetupPlan plan) {
    final distances = plan.distancesTo(venue.location);
    return RankedVenue(
      venue: venue,
      distancesMeters: distances,
      distanceFromMidpointMeters: GeoMath.distanceMeters(
        plan.midpoint,
        venue.location,
      ),
      fairness: Fairness.of(distances),
    );
  }

  const RankedVenue._();

  double get spreadMeters => Fairness.spread(distancesMeters);
}

/// Ranks, filters and sorts [venues] for display.
List<RankedVenue> rankVenues(
  List<Venue> venues,
  MeetupPlan plan,
  VenueFilter filter,
) {
  final ranked = [
    for (final v in venues)
      if (!filter.openNowOnly || v.openNow == true)
        if ((v.rating ?? 0) >= filter.minRating) RankedVenue.fromPlan(v, plan),
  ];
  final comparator = switch (filter.sort) {
    SortOption.fairness => (
      RankedVenue a,
      RankedVenue b,
    ) => a.spreadMeters.compareTo(b.spreadMeters),
    SortOption.distance => (
      RankedVenue a,
      RankedVenue b,
    ) => a.distanceFromMidpointMeters.compareTo(b.distanceFromMidpointMeters),
    SortOption.rating => (
      RankedVenue a,
      RankedVenue b,
    ) => (b.venue.rating ?? 0).compareTo(a.venue.rating ?? 0),
    SortOption.priceLowToHigh =>
      (RankedVenue a, RankedVenue b) =>
          // Unknown prices sort last.
          (a.venue.priceLevel?.rank ?? 99).compareTo(
            b.venue.priceLevel?.rank ?? 99,
          ),
  };
  // Stable sort with distance from the midpoint as the tie-breaker.
  return ranked.sorted((a, b) {
    final primary = comparator(a, b);
    return primary != 0
        ? primary
        : a.distanceFromMidpointMeters.compareTo(b.distanceFromMidpointMeters);
  });
}
