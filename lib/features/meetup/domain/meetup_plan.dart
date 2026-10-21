import 'dart:math' as math;

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meet_halfway/core/geo/geo_math.dart';
import 'package:meet_halfway/core/geo/geo_point.dart';
import 'package:meet_halfway/features/locations/domain/participant.dart';
import 'package:meet_halfway/features/meetup/domain/fairness.dart';

part 'meetup_plan.freezed.dart';

/// Everyone's starting point plus the computed midpoint.
@freezed
abstract class MeetupPlan with _$MeetupPlan {
  const factory MeetupPlan({
    /// Participants, all of which have a location.
    required List<Participant> participants,
    required GeoPoint midpoint,
  }) = _MeetupPlan;

  const MeetupPlan._();

  static const double minSearchRadiusMeters = 3000;

  /// Places API (New) caps nearby-search radius at 50 km.
  static const double maxSearchRadiusMeters = 50000;

  List<GeoPoint> get origins => [
    for (final p in participants) p.location!.point,
  ];

  /// Straight-line distance from each participant to [destination].
  List<double> distancesTo(GeoPoint destination) => [
    for (final o in origins) GeoMath.distanceMeters(o, destination),
  ];

  Fairness fairnessOf(GeoPoint destination) =>
      Fairness.of(distancesTo(destination));

  /// Search radius scales with how far apart people are: a quarter of the
  /// widest separation, clamped to [minSearchRadiusMeters] and
  /// [maxSearchRadiusMeters]. Keeps venues near the middle for long trips
  /// without returning nothing for neighbours.
  double get searchRadiusMeters {
    var widest = 0.0;
    final points = origins;
    for (var i = 0; i < points.length; i++) {
      for (var j = i + 1; j < points.length; j++) {
        widest = math.max(widest, GeoMath.distanceMeters(points[i], points[j]));
      }
    }
    return (widest / 4).clamp(minSearchRadiusMeters, maxSearchRadiusMeters);
  }
}
