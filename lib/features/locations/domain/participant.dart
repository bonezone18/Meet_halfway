import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meet_halfway/features/locations/domain/selected_location.dart';

part 'participant.freezed.dart';

/// Someone who is meeting up. The app models a list of participants so group
/// mode (3+ people) only needs UI work.
@freezed
abstract class Participant with _$Participant {
  const factory Participant({
    required String id,
    required String name,
    SelectedLocation? location,
  }) = _Participant;
}
