import 'package:freezed_annotation/freezed_annotation.dart';

part 'route_summary.freezed.dart';

/// Travel time and distance for one participant's trip.
@freezed
abstract class RouteSummary with _$RouteSummary {
  const factory RouteSummary({
    required Duration duration,
    required int distanceMeters,
  }) = _RouteSummary;
}
