import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meet_halfway/core/error/failure.dart';
import 'package:meet_halfway/features/locations/application/participants_controller.dart';
import 'package:meet_halfway/features/locations/data/geolocator_location_source.dart';
import 'package:meet_halfway/features/locations/domain/selected_location.dart';

import '../../helpers/fakes.dart';

void main() {
  ProviderContainer containerWith(FakeDeviceLocationSource source) =>
      ProviderContainer.test(
        overrides: [deviceLocationSourceProvider.overrideWithValue(source)],
      );

  test('starts with two participants and no locations', () {
    final container = ProviderContainer.test();
    final participants = container.read(participantsProvider);
    expect(participants.map((p) => p.name), ['You', 'Friend']);
    expect(container.read(allLocationsSetProvider), isFalse);
  });

  test('setLocation, swap and clear', () {
    final container = ProviderContainer.test();
    final controller = container.read(participantsProvider.notifier);
    final [a, b] = container.read(participantsProvider);
    const ny = SelectedLocation(label: 'NY', point: newYork);
    const philly = SelectedLocation(label: 'Philly', point: philadelphia);

    controller
      ..setLocation(a.id, ny)
      ..setLocation(b.id, philly);
    expect(container.read(allLocationsSetProvider), isTrue);

    controller.swapFirstTwo();
    expect(container.read(participantsProvider).map((p) => p.location), [
      philly,
      ny,
    ]);

    controller.clearLocation(a.id);
    expect(container.read(participantsProvider).first.location, isNull);
    expect(container.read(allLocationsSetProvider), isFalse);
  });

  test('never drops below two participants', () {
    final container = ProviderContainer.test();
    final controller = container.read(participantsProvider.notifier)
      ..add('Sam');
    final ids = container.read(participantsProvider).map((p) => p.id);
    expect(ids, hasLength(3));
    ids.toList().forEach(controller.remove);
    expect(container.read(participantsProvider), hasLength(2));
  });

  test('useCurrentLocation stores the device position', () async {
    final container = containerWith(
      FakeDeviceLocationSource(() async => newYork),
    );
    final id = container.read(participantsProvider).first.id;
    await container.read(participantsProvider.notifier).useCurrentLocation(id);
    final location = container.read(participantsProvider).first.location!;
    expect(location.point, newYork);
    expect(location.source, LocationSource.device);
  });

  test('useCurrentLocation propagates permission failures', () async {
    final container = containerWith(
      FakeDeviceLocationSource(
        () async => throw const PermissionFailure('denied'),
      ),
    );
    final id = container.read(participantsProvider).first.id;
    await expectLater(
      container.read(participantsProvider.notifier).useCurrentLocation(id),
      throwsA(isA<PermissionFailure>()),
    );
    expect(container.read(participantsProvider).first.location, isNull);
  });
}
