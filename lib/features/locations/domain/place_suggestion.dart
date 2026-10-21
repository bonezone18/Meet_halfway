import 'package:freezed_annotation/freezed_annotation.dart';

part 'place_suggestion.freezed.dart';

/// One autocomplete prediction. Must be resolved to coordinates before use.
@freezed
abstract class PlaceSuggestion with _$PlaceSuggestion {
  const factory PlaceSuggestion({
    required String placeId,
    required String primaryText,
    @Default('') String secondaryText,
  }) = _PlaceSuggestion;

  const PlaceSuggestion._();

  String get fullText =>
      secondaryText.isEmpty ? primaryText : '$primaryText, $secondaryText';
}
