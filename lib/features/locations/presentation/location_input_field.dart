import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meet_halfway/core/error/failure.dart';
import 'package:meet_halfway/features/locations/application/participants_controller.dart';
import 'package:meet_halfway/features/locations/data/google_location_repository.dart';
import 'package:meet_halfway/features/locations/domain/participant.dart';
import 'package:meet_halfway/features/locations/domain/place_suggestion.dart';
import 'package:meet_halfway/features/locations/domain/selected_location.dart';

/// Address field with Places autocomplete and a "use my location" button.
class LocationInputField extends ConsumerStatefulWidget {
  const LocationInputField({
    required this.participant,
    required this.color,
    super.key,
  });

  final Participant participant;
  final Color color;

  @override
  ConsumerState<LocationInputField> createState() => _LocationInputFieldState();
}

class _LocationInputFieldState extends ConsumerState<LocationInputField> {
  static const _debounce = Duration(milliseconds: 300);

  late final TextEditingController _text = TextEditingController(
    text: widget.participant.location?.label ?? '',
  );
  final FocusNode _focus = FocusNode();
  Timer? _debounceTimer;
  String? _sessionToken;
  int _requestId = 0;

  List<PlaceSuggestion> _suggestions = const [];
  String? _error;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    _focus.addListener(() => setState(() {}));
  }

  @override
  void didUpdateWidget(LocationInputField oldWidget) {
    super.didUpdateWidget(oldWidget);
    final location = widget.participant.location;
    // Sync text when the location changes from outside (swap, GPS).
    if (location != oldWidget.participant.location &&
        location != null &&
        _text.text != location.label) {
      _text.text = location.label;
    }
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _text.dispose();
    _focus.dispose();
    super.dispose();
  }

  ParticipantsController get _participants =>
      ref.read(participantsProvider.notifier);

  void _onChanged(String value) {
    if (widget.participant.location != null) {
      _participants.clearLocation(widget.participant.id);
    }
    _sessionToken ??= _newSessionToken();
    _debounceTimer?.cancel();
    if (value.trim().isEmpty) {
      setState(() => _suggestions = const []);
      return;
    }
    _debounceTimer = Timer(_debounce, () => _search(value));
  }

  Future<void> _search(String value) async {
    final requestId = ++_requestId;
    setState(() => _busy = true);
    try {
      final results = await ref
          .read(locationRepositoryProvider)
          .autocomplete(value, sessionToken: _sessionToken);
      if (!mounted || requestId != _requestId) return;
      setState(() {
        _suggestions = results;
        _error = null;
      });
    } on Failure catch (f) {
      if (!mounted || requestId != _requestId) return;
      setState(() => _error = f.message);
    } finally {
      if (mounted && requestId == _requestId) setState(() => _busy = false);
    }
  }

  Future<void> _select(PlaceSuggestion suggestion) async {
    _debounceTimer?.cancel();
    final requestId = ++_requestId;
    setState(() {
      _busy = true;
      _suggestions = const [];
      _text.text = suggestion.fullText;
    });
    _focus.unfocus();
    try {
      final location = await ref
          .read(locationRepositoryProvider)
          .resolve(suggestion, sessionToken: _sessionToken);
      _participants.setLocation(widget.participant.id, location);
      _sessionToken = null; // A resolve ends the billing session.
      if (mounted) setState(() => _error = null);
    } on Failure catch (f) {
      if (mounted) setState(() => _error = f.message);
    } finally {
      if (mounted && requestId == _requestId) setState(() => _busy = false);
    }
  }

  Future<void> _useCurrentLocation() async {
    _debounceTimer?.cancel();
    ++_requestId;
    setState(() {
      _busy = true;
      _suggestions = const [];
    });
    _focus.unfocus();
    try {
      await _participants.useCurrentLocation(widget.participant.id);
      if (mounted) setState(() => _error = null);
    } on Failure catch (f) {
      if (mounted) setState(() => _error = f.message);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _clear() {
    _debounceTimer?.cancel();
    ++_requestId;
    _text.clear();
    _participants.clearLocation(widget.participant.id);
    setState(() {
      _suggestions = const [];
      _error = null;
      _busy = false;
    });
  }

  static String _newSessionToken() {
    final random = Random.secure();
    return List.generate(
      16,
      (_) => random.nextInt(256).toRadixString(16).padLeft(2, '0'),
    ).join();
  }

  @override
  Widget build(BuildContext context) {
    final location = widget.participant.location;
    final showSuggestions = _focus.hasFocus && _suggestions.isNotEmpty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _text,
          focusNode: _focus,
          onChanged: _onChanged,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            labelText: widget.participant.name,
            hintText: 'Search an address or place',
            errorText: _error,
            errorMaxLines: 3,
            prefixIcon: Icon(
              location?.source == LocationSource.device
                  ? Icons.my_location
                  : Icons.place,
              color: widget.color,
            ),
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_busy)
                  const Padding(
                    padding: EdgeInsets.all(12),
                    child: SizedBox.square(
                      dimension: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  )
                else if (_text.text.isNotEmpty)
                  IconButton(
                    tooltip: 'Clear',
                    icon: const Icon(Icons.close),
                    onPressed: _clear,
                  ),
                IconButton(
                  tooltip: 'Use my current location',
                  icon: const Icon(Icons.gps_fixed),
                  onPressed: _busy ? null : _useCurrentLocation,
                ),
              ],
            ),
          ),
        ),
        if (showSuggestions)
          Card(
            margin: const EdgeInsets.only(top: 4),
            child: Column(
              children: [
                for (final s in _suggestions)
                  ListTile(
                    dense: true,
                    leading: const Icon(Icons.location_on_outlined),
                    title: Text(s.primaryText),
                    subtitle: s.secondaryText.isEmpty
                        ? null
                        : Text(s.secondaryText),
                    onTap: () => _select(s),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}
