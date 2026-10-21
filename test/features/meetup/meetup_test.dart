import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meet_halfway/core/error/failure.dart';
import 'package:meet_halfway/core/geo/geo_math.dart';
import 'package:meet_halfway/features/locations/application/participants_controller.dart';
import 'package:meet_halfway/features/locations/domain/selected_location.dart';
import 'package:meet_halfway/features/meetup/application/meetup_providers.dart';
import 'package:meet_halfway/features/meetup/domain/fairness.dart';
import 'package:meet_halfway/features/meetup/domain/meetup_plan.dart';

import '../../helpers/fakes.dart';

void main() {
  group('Fairness.of', () {
    test('is balanced for equal or nearly equal trips', () {
      expect(Fairness.of([5000, 5000]), Fairness.balanced);
      expect(Fairness.of([10000, 9000]), Fairness.balanced);
      // Small absolute gaps are balanced even if the ratio is large.
      expect(Fairness.of([300, 900]), Fairness.balanced);
    });

    test('grades larger gaps', () {
      expect(Fairness.of([10000, 7000]), Fairness.moderate);
      expect(Fairness.of([10000, 2000]), Fairness.unbalanced);
    });

    test('a single participant is always balanced', () {
      expect(Fairness.of([1234]), Fairness.balanced);
    });
  });

  group('MeetupPlan.searchRadiusMeters', () {
    test('is clamped to the minimum for nearby participants', () {
      const nearby = GeoPointPair.close;
      final plan = planBetween(nearby.$1, nearby.$2, midpoint: nearby.$1);
      expect(plan.searchRadiusMeters, MeetupPlan.minSearchRadiusMeters);
    });

    test('scales with separation and caps at the API maximum', () {
      final plan = planBetween(newYork, philadelphia, midpoint: newYork);
      final separation = GeoMath.distanceMeters(newYork, philadelphia);
      expect(plan.searchRadiusMeters, closeTo(separation / 4, 1));

      const losAngeles = (latitude: 34.05, longitude: -118.24);
      final far = planBetween(
        newYork,
        GeoPointPair.from(losAngeles),
        midpoint: newYork,
      );
      expect(far.searchRadiusMeters, MeetupPlan.maxSearchRadiusMeters);
    });
  });

  group('meetupPlanProvider', () {
    test('fails with a ValidationFailure until everyone has a location', () {
      final container = ProviderContainer.test(retry: retryTransientFailures);
      expect(
        container.read(meetupPlanProvider.future),
        throwsA(isA<ValidationFailure>()),
      );
    });

    test('computes the midpoint once both locations are set', () async {
      final container = ProviderContainer.test(retry: retryTransientFailures);
      final controller = container.read(participantsProvider.notifier);
      final [a, b] = container.read(participantsProvider);
      controller
        ..setLocation(a.id, const SelectedLocation(label: 'NY', point: newYork))
        ..setLocation(
          b.id,
          const SelectedLocation(label: 'Philly', point: philadelphia),
        );

      final plan = await container.read(meetupPlanProvider.future);
      expect(plan.midpoint, GeoMath.centroid([newYork, philadelphia]));
      expect(plan.participants.map((p) => p.location!.label), ['NY', 'Philly']);
    });
  });
}
