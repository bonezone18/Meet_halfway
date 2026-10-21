import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meet_halfway/core/error/failure.dart';
import 'package:meet_halfway/core/geo/geo_math.dart';
import 'package:meet_halfway/features/meetup/application/meetup_providers.dart';
import 'package:meet_halfway/features/places/application/venue_providers.dart';
import 'package:meet_halfway/features/places/domain/venue.dart';
import 'package:meet_halfway/features/places/presentation/results_screen.dart';

import '../../helpers/fakes.dart';

void main() {
  final midpoint = GeoMath.centroid([newYork, philadelphia]);
  final plan = planBetween(newYork, philadelphia, midpoint: midpoint);

  Future<void> pumpPanel(
    WidgetTester tester,
    Future<List<Venue>> Function() venues,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          meetupPlanProvider.overrideWith((ref) async => plan),
          nearbyVenuesProvider.overrideWith((ref) => venues()),
        ],
        retry: retryTransientFailures,
        child: MaterialApp(
          home: Scaffold(body: VenueResultsPanel(plan: plan)),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('lists venues with each participant distance', (tester) async {
    await pumpPanel(
      tester,
      () async => [
        venue('1', at: midpoint, rating: 4.5),
        venue('2', at: midpoint),
      ],
    );
    expect(find.text('Venue 1'), findsOneWidget);
    expect(find.text('Venue 2'), findsOneWidget);
    expect(find.textContaining(RegExp(r'^a [\d.]+ mi$')), findsNWidgets(2));
    expect(find.text('Balanced'), findsNWidgets(2));
  });

  testWidgets('shows an empty state', (tester) async {
    await pumpPanel(tester, () async => []);
    expect(find.textContaining('No matching places'), findsOneWidget);
  });

  testWidgets('shows errors with a retry button', (tester) async {
    await pumpPanel(
      tester,
      () async => throw const ApiFailure('Quota exceeded.'),
    );
    expect(find.text('Quota exceeded.'), findsOneWidget);
    expect(find.text('Try again'), findsOneWidget);
  });
}
