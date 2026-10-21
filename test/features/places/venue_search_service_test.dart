import 'package:flutter_test/flutter_test.dart';
import 'package:meet_halfway/core/geo/geo_math.dart';
import 'package:meet_halfway/features/meetup/domain/meetup_plan.dart';
import 'package:meet_halfway/features/places/application/venue_search_service.dart';
import 'package:meet_halfway/features/places/domain/venue_category.dart';

import '../../helpers/fakes.dart';

void main() {
  final midpoint = GeoMath.centroid([newYork, philadelphia]);
  final plan = planBetween(newYork, philadelphia, midpoint: midpoint);

  test('searches every category in parallel and de-duplicates', () async {
    final repo = FakePlacesRepository(
      (category, _) => [
        venue('shared', at: midpoint),
        venue(category.apiType, at: midpoint),
      ],
    );
    final venues = await VenueSearchService(repo)
        .search(plan, {VenueCategory.cafe, VenueCategory.bar});
    expect(venues.map((v) => v.id), unorderedEquals(['shared', 'cafe', 'bar']));
    expect(repo.searches, hasLength(2));
    expect(repo.searches.map((s) => s.radius).toSet(), {
      plan.searchRadiusMeters,
    });
  });

  test('widens the radius until something is found', () async {
    final repo = FakePlacesRepository(
      (_, radius) => radius >= MeetupPlan.maxSearchRadiusMeters
          ? [venue('far', at: philadelphia)]
          : [],
    );
    final venues = await VenueSearchService(repo)
        .search(plan, {VenueCategory.park});
    expect(venues.single.id, 'far');
    expect(repo.searches.last.radius, MeetupPlan.maxSearchRadiusMeters);
  });

  test('returns empty when nothing exists even at max radius', () async {
    final repo = FakePlacesRepository((_, _) => []);
    final venues = await VenueSearchService(repo)
        .search(plan, {VenueCategory.museum});
    expect(venues, isEmpty);
    expect(
      repo.searches.length,
      VenueSearchService.radiiFor(plan.searchRadiusMeters).length,
    );
  });

  test('radiiFor grows geometrically and ends at the API cap', () {
    final radii = VenueSearchService.radiiFor(3000);
    expect(radii.first, 3000);
    expect(radii.last, MeetupPlan.maxSearchRadiusMeters);
    for (var i = 1; i < radii.length; i++) {
      expect(radii[i], greaterThan(radii[i - 1]));
    }
  });
}
