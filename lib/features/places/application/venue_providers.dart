import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:meet_halfway/features/meetup/application/meetup_providers.dart';
import 'package:meet_halfway/features/places/application/venue_search_service.dart';
import 'package:meet_halfway/features/places/data/google_places_repository.dart';
import 'package:meet_halfway/features/places/domain/ranked_venue.dart';
import 'package:meet_halfway/features/places/domain/venue.dart';
import 'package:meet_halfway/features/places/domain/venue_category.dart';
import 'package:meet_halfway/features/places/domain/venue_filter.dart';

final venueSearchServiceProvider = Provider<VenueSearchService>(
  (ref) => VenueSearchService(ref.watch(placesRepositoryProvider)),
);

class VenueFilterController extends Notifier<VenueFilter> {
  @override
  VenueFilter build() => const VenueFilter();

  /// Toggles [category]. The last selected category can't be removed.
  void toggleCategory(VenueCategory category) {
    final current = state.categories;
    if (current.contains(category)) {
      if (current.length == 1) return;
      state = state.copyWith(categories: {...current}..remove(category));
    } else {
      state = state.copyWith(categories: {...current, category});
    }
  }

  void setSort(SortOption sort) => state = state.copyWith(sort: sort);

  void setOpenNowOnly({required bool value}) =>
      state = state.copyWith(openNowOnly: value);

  void reset() => state = const VenueFilter();
}

final venueFilterProvider =
    NotifierProvider<VenueFilterController, VenueFilter>(
      VenueFilterController.new,
    );

/// Raw venues around the midpoint. Only refetches when the plan or the
/// selected categories change.
final nearbyVenuesProvider = FutureProvider<List<Venue>>((ref) async {
  final plan = await ref.watch(meetupPlanProvider.future);
  final categories = ref.watch(venueFilterProvider.select((f) => f.categories));
  return await ref.watch(venueSearchServiceProvider).search(plan, categories);
});

/// Venues ranked and sorted for display. Sorting/filtering is synchronous so
/// changing it never shows a loading state.
final visibleVenuesProvider = Provider<AsyncValue<List<RankedVenue>>>((ref) {
  final plan = ref.watch(meetupPlanProvider).value;
  final filter = ref.watch(venueFilterProvider);
  final venues = ref.watch(nearbyVenuesProvider);
  if (plan == null) {
    return venues.hasError
        ? AsyncError(venues.error!, venues.stackTrace!)
        : const AsyncLoading();
  }
  return venues.whenData((list) => rankVenues(list, plan, filter));
});

final FutureProviderFamily<VenueDetails, String> venueDetailsProvider =
    FutureProvider.autoDispose.family<VenueDetails, String>(
      (ref, venueId) => ref.watch(placesRepositoryProvider).details(venueId),
    );

/// Photo helper so widgets don't depend on the repository directly.
final ProviderFamily<VenuePhoto?, String> venuePhotoProvider =
    Provider.family<VenuePhoto?, String>(
      (ref, photoName) => ref.watch(placesRepositoryProvider).photo(photoName),
    );
