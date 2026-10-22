import 'package:meet_halfway/core/geo/geo_point.dart';
import 'package:meet_halfway/features/places/domain/venue.dart';
import 'package:meet_halfway/features/places/domain/venue_category.dart';

/// Source of venues. Google Places today; other providers (Yelp, a curated
/// list, a local cache) can implement this too.
abstract interface class PlacesRepository {
  Future<List<Venue>> searchNearby({
    required GeoPoint center,
    required double radiusMeters,
    required VenueCategory category,
    int maxResults = 20,
  });

  Future<VenueDetails> details(String venueId);

  /// How to load the venue's photo, or null if unavailable.
  VenuePhoto? photo(String photoName, {int maxWidthPx = 400});
}
