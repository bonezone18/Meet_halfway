import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meet_halfway/features/places/domain/venue_category.dart';

part 'venue_filter.freezed.dart';

enum SortOption {
  fairness('Fairest'),
  distance('Closest to midpoint'),
  rating('Top rated'),
  priceLowToHigh(r'Price: $ → $$$$');

  const SortOption(this.label);

  final String label;
}

/// What the user wants to see. [categories] affects which venues are fetched;
/// everything else is applied client-side without a new request.
@freezed
abstract class VenueFilter with _$VenueFilter {
  const factory VenueFilter({
    @Default(VenueCategory.defaults) Set<VenueCategory> categories,
    @Default(SortOption.fairness) SortOption sort,
    @Default(false) bool openNowOnly,
    @Default(0) double minRating,
  }) = _VenueFilter;
}
