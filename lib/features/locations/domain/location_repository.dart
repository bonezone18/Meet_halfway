import 'package:meet_halfway/core/geo/geo_point.dart';
import 'package:meet_halfway/features/locations/domain/place_suggestion.dart';
import 'package:meet_halfway/features/locations/domain/selected_location.dart';

/// Turns free text into coordinates.
abstract interface class LocationRepository {
  /// Suggestions for [input]. [sessionToken] groups a typing session with its
  /// final resolve call for billing purposes.
  Future<List<PlaceSuggestion>> autocomplete(
    String input, {
    String? sessionToken,
    GeoPoint? bias,
  });

  /// Resolves a suggestion to a [SelectedLocation].
  Future<SelectedLocation> resolve(
    PlaceSuggestion suggestion, {
    String? sessionToken,
  });
}

/// Access to the device's own position.
abstract interface class DeviceLocationSource {
  Future<GeoPoint> currentPosition();
}
