import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meet_halfway/core/geo/geo_math.dart';
import 'package:meet_halfway/features/places/application/venue_providers.dart';
import 'package:meet_halfway/features/places/domain/ranked_venue.dart';
import 'package:meet_halfway/features/places/domain/venue.dart';
import 'package:meet_halfway/features/places/domain/venue_category.dart';
import 'package:meet_halfway/features/places/domain/venue_filter.dart';

import '../../helpers/fakes.dart';

void main() {
  final midpoint = GeoMath.centroid([newYork, philadelphia]);
  final plan = planBetween(newYork, philadelphia, midpoint: midpoint);

  // "middle" is at the midpoint; "nearNy" is much closer to New York.
  final middle = venue(
    'middle',
    at: midpoint,
    rating: 4,
    price: PriceLevel.expensive,
    openNow: false,
  );
  final nearNy = venue(
    'nearNy',
    at: GeoMath.centroid([newYork, midpoint], weights: [3, 1]),
    rating: 4.8,
    price: PriceLevel.inexpensive,
    openNow: true,
  );
  final venues = [nearNy, middle];

  List<String> ids(VenueFilter filter) =>
      rankVenues(venues, plan, filter).map((r) => r.venue.id).toList();

  test('fairness sort puts the most even split first', () {
    expect(ids(const VenueFilter()), ['middle', 'nearNy']);
    final ranked = rankVenues(venues, plan, const VenueFilter());
    expect(ranked.first.distancesMeters, hasLength(2));
  });

  test('other sorts', () {
    expect(ids(const VenueFilter(sort: SortOption.rating)), [
      'nearNy',
      'middle',
    ]);
    expect(ids(const VenueFilter(sort: SortOption.priceLowToHigh)), [
      'nearNy',
      'middle',
    ]);
    expect(ids(const VenueFilter(sort: SortOption.distance)), [
      'middle',
      'nearNy',
    ]);
  });

  test('open-now and minimum rating filters', () {
    expect(ids(const VenueFilter(openNowOnly: true)), ['nearNy']);
    expect(ids(const VenueFilter(minRating: 4.5)), ['nearNy']);
  });

  group('VenueFilterController', () {
    test('toggles categories but never removes the last one', () {
      final container = ProviderContainer.test();
      final controller = container.read(venueFilterProvider.notifier);
      expect(
        container.read(venueFilterProvider).categories,
        VenueCategory.defaults,
      );

      controller
        ..toggleCategory(VenueCategory.park)
        ..toggleCategory(VenueCategory.cafe)
        ..toggleCategory(VenueCategory.restaurant)
        ..toggleCategory(VenueCategory.bar);
      expect(container.read(venueFilterProvider).categories, {
        VenueCategory.park,
      });

      controller.toggleCategory(VenueCategory.park);
      expect(container.read(venueFilterProvider).categories, {
        VenueCategory.park,
      });
    });
  });
}
