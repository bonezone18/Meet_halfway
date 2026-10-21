import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meet_halfway/core/error/failure.dart';
import 'package:meet_halfway/features/locations/application/participants_controller.dart';
import 'package:meet_halfway/features/meetup/domain/meetup_plan.dart';
import 'package:meet_halfway/features/meetup/domain/midpoint_strategy.dart';

final midpointStrategyProvider = Provider<MidpointStrategy>(
  (ref) => const GeographicMidpointStrategy(),
);

/// The current plan, recomputed whenever participants or strategy change.
final meetupPlanProvider = FutureProvider<MeetupPlan>((ref) async {
  final participants = ref.watch(participantsProvider);
  if (participants.any((p) => p.location == null)) {
    throw const ValidationFailure('Add a starting point for everyone first.');
  }
  final strategy = ref.watch(midpointStrategyProvider);
  final midpoint = await strategy.midpointOf([
    for (final p in participants) p.location!.point,
  ]);
  return MeetupPlan(participants: participants, midpoint: midpoint);
});
