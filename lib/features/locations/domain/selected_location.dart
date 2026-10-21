import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meet_halfway/core/geo/geo_point.dart';

part 'selected_location.freezed.dart';

enum LocationSource { search, device }

/// A resolved starting point chosen by a participant.
@freezed
abstract class SelectedLocation with _$SelectedLocation {
  const factory SelectedLocation({
    required String label,
    required GeoPoint point,
    @Default(LocationSource.search) LocationSource source,
    String? placeId,
  }) = _SelectedLocation;
}
