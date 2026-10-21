import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meet_halfway/features/locations/application/participants_controller.dart';
import 'package:meet_halfway/features/locations/data/google_location_repository.dart';
import 'package:meet_halfway/features/locations/domain/location_repository.dart';
import 'package:meet_halfway/features/locations/domain/place_suggestion.dart';
import 'package:meet_halfway/features/locations/domain/selected_location.dart';
import 'package:meet_halfway/features/meetup/presentation/home_screen.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/fakes.dart';

class _MockLocationRepository extends Mock implements LocationRepository;

void main() {
  late _MockLocationRepository repository;
  late ProviderContainer container;

  setUpAll(() {
    registerFallbackValue(const PlaceSuggestion(placeId: '', primaryText: ''));
  });

  setUp(() {
    repository = _MockLocationRepository();
    container = ProviderContainer.test(
      overrides: [locationRepositoryProvider.overrideWithValue(repository)],
    );
  });

  Future<void> pumpHome(WidgetTester tester) => tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: const MaterialApp(home: HomeScreen()),
    ),
  );

  bool meetButtonEnabled(WidgetTester tester) =>
      tester.widget<MeetButton>(find.byType(MeetButton)).enabled;

  testWidgets('Meet Halfway is enabled only once both locations are set', (
    tester,
  ) async {
    await pumpHome(tester);
    expect(find.text('You'), findsOneWidget);
    expect(find.text('Friend'), findsOneWidget);
    expect(meetButtonEnabled(tester), isFalse);

    final [a, b] = container.read(participantsProvider);
    container.read(participantsProvider.notifier)
      ..setLocation(a.id, const SelectedLocation(label: 'NY', point: newYork))
      ..setLocation(
        b.id,
        const SelectedLocation(label: 'Philly', point: philadelphia),
      );
    await tester.pump();

    expect(meetButtonEnabled(tester), isTrue);
    expect(find.text('NY'), findsOneWidget);
    expect(find.text('Philly'), findsOneWidget);
  });

  testWidgets('typing shows suggestions and selecting one sets the location', (
    tester,
  ) async {
    const suggestion = PlaceSuggestion(
      placeId: 'cp',
      primaryText: 'Central Park',
      secondaryText: 'New York, NY',
    );
    when(
      () => repository.autocomplete(
        any(),
        sessionToken: any(named: 'sessionToken'),
        bias: any(named: 'bias'),
      ),
    ).thenAnswer((_) async => [suggestion]);
    when(
      () => repository.resolve(any(), sessionToken: any(named: 'sessionToken')),
    ).thenAnswer(
      (_) async => const SelectedLocation(
        label: 'Central Park, New York, NY',
        point: newYork,
      ),
    );

    await pumpHome(tester);
    await tester.enterText(find.byType(TextField).first, 'central');
    await tester.pump(const Duration(milliseconds: 350));
    await tester.pump();

    expect(find.text('Central Park'), findsOneWidget);
    await tester.tap(find.text('Central Park'));
    await tester.pumpAndSettle();

    final first = container.read(participantsProvider).first;
    expect(first.location?.label, 'Central Park, New York, NY');
    verify(
      () => repository.autocomplete(
        'central',
        sessionToken: any(named: 'sessionToken'),
        bias: any(named: 'bias'),
      ),
    ).called(1);
  });
}
