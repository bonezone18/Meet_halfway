import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meet_halfway/features/locations/data/geolocator_location_source.dart';
import 'package:meet_halfway/features/locations/domain/participant.dart';
import 'package:meet_halfway/features/locations/domain/selected_location.dart';

/// Holds everyone who is meeting up and their chosen starting points.
///
/// v1 shows two participants; [add]/[remove] exist for group mode.
class ParticipantsController extends Notifier<List<Participant>> {
  static const minParticipants = 2;

  var _nextId = 0;

  @override
  List<Participant> build() => [_create('You'), _create('Friend')];

  Participant _create(String name) =>
      Participant(id: 'p${_nextId++}', name: name);

  void setLocation(String id, SelectedLocation location) =>
      _update(id, (p) => p.copyWith(location: location));

  void clearLocation(String id) =>
      _update(id, (p) => p.copyWith(location: null));

  /// Uses the device position as [id]'s starting point.
  ///
  /// Throws a `Failure` if permission is denied or the position is unknown.
  Future<void> useCurrentLocation(String id) async {
    final source = ref.read(deviceLocationSourceProvider);
    final point = await source.currentPosition();
    if (!ref.mounted) return;
    setLocation(
      id,
      SelectedLocation(
        label: 'Current location',
        point: point,
        source: LocationSource.device,
      ),
    );
  }

  /// Swaps the locations of the first two participants.
  void swapFirstTwo() {
    if (state.length < 2) return;
    final [a, b, ...rest] = state;
    state = [
      a.copyWith(location: b.location),
      b.copyWith(location: a.location),
      ...rest,
    ];
  }

  void add(String name) => state = [...state, _create(name)];

  void remove(String id) {
    if (state.length <= minParticipants) return;
    state = [
      for (final p in state)
        if (p.id != id) p,
    ];
  }

  void _update(String id, Participant Function(Participant) change) {
    state = [
      for (final p in state)
        if (p.id == id) change(p) else p,
    ];
  }
}

final participantsProvider =
    NotifierProvider<ParticipantsController, List<Participant>>(
      ParticipantsController.new,
    );

/// True once every participant has a starting point.
final allLocationsSetProvider = Provider<bool>(
  (ref) => ref.watch(participantsProvider).every((p) => p.location != null),
);
