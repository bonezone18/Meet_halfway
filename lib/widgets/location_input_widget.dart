// lib/widgets/location_input_widget.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import '../providers/location_provider.dart';
import '../services/location_service.dart';
import '../providers/place_provider.dart';
import '../models/location_model.dart';

/// A widget for inputting a location, with autocomplete suggestions and a 'use current location' button.
class LocationInputWidget extends StatefulWidget {
  final bool isLocationA;
  final String placeholder;
  final LocationService locationService;

  const LocationInputWidget({
    super.key,
    required this.isLocationA,
    required this.placeholder,
    required this.locationService,
  });

  @override
  State<LocationInputWidget> createState() => _LocationInputWidgetState();
}

class _LocationInputWidgetState extends State<LocationInputWidget> {
  final TextEditingController _controller = TextEditingController();
  Timer? _debounceTimer;
  final int _debounceDuration = 500;

  @override
  void dispose() {
    _controller.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  Future<List<Map<String, dynamic>>> _getDebouncedSuggestions(String pattern) async {
    final completer = Completer<List<Map<String, dynamic>>>();
    _debounceTimer?.cancel();

    _debounceTimer = Timer(Duration(milliseconds: _debounceDuration), () async {
      if (pattern.trim().isEmpty) {
        completer.complete([]);
        return;
      }
      try {
        final suggestions = await Provider.of<PlaceProvider>(context, listen: false)
            .getPlaceSuggestions(pattern);
        if (!completer.isCompleted) completer.complete(suggestions);
      } catch (e) {
        if (!completer.isCompleted) {
          completer.complete([
            {'description': 'Error fetching suggestions', 'place_id': ''}
          ]);
        }
      }
    });

    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);
    final currentLocation = widget.isLocationA
        ? locationProvider.locationA
        : locationProvider.locationB;

    if (currentLocation != null) {
      final expected = currentLocation.address ??
          (currentLocation.isCurrentLocation ? 'Current Location' : '');
      if (_controller.text != expected) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) return;
          _controller.text = expected;
          _controller.selection = TextSelection.fromPosition(
            TextPosition(offset: _controller.text.length),
          );
        });
      }
    } else if (_controller.text.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        _controller.clear();
      });
    }

    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final secondaryColor = theme.colorScheme.secondary;
    final errorColor = theme.colorScheme.error;

    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            widget.isLocationA ? 'Your Location' : 'Friend\'s Location',
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Expanded(
                  child: TypeAheadField<Map<String, dynamic>>(
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: _controller,
                      style: theme.textTheme.bodyLarge,
                      decoration: InputDecoration(
                        hintText: widget.placeholder,
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
                        prefixIcon: Icon(
                          widget.isLocationA ? Icons.location_on : Icons.person_pin_circle,
                          color: widget.isLocationA ? primaryColor : secondaryColor,
                        ),
                      ),
                      onSubmitted: (value) async {
                        final trimmed = value.trim();
                        if (trimmed.isEmpty) return;
                        try {
                          final loc = await widget.locationService.geocodeAddress(trimmed);
                          if (widget.isLocationA) {
                            locationProvider.setLocationA(loc);
                          } else {
                            locationProvider.setLocationB(loc);
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error geocoding address: $e')),
                          );
                        }
                      },
                    ),
                    suggestionsCallback: _getDebouncedSuggestions,
                    itemBuilder: (context, suggestion) {
                      final desc = suggestion['description'] as String? ?? '';
                      return ListTile(title: Text(desc), dense: true);
                    },
                    onSuggestionSelected: (s) async {
                      final placeId = s['place_id'] as String?;
                      if (placeId == null || placeId.isEmpty) return;
                      _controller.text = s['description'] as String? ?? '';
                      try {
                        final loc = await widget.locationService.getPlaceDetails(placeId);
                        if (widget.isLocationA) {
                          locationProvider.setLocationA(loc);
                        } else {
                          locationProvider.setLocationB(loc);
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error fetching details: $e')),
                        );
                      }
                    },
                    suggestionsBoxVerticalOffset: keyboardHeight > 0 ? -keyboardHeight : 12.0,
                    suggestionsBoxDecoration: SuggestionsBoxDecoration(
                      elevation: 4.0,
                      borderRadius: BorderRadius.circular(8.0),
                      constraints: const BoxConstraints(maxHeight: 250),
                    ),
                    hideOnLoading: false,
                    loadingBuilder: (context) => const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(strokeWidth: 2.0),
                      ),
                    ),
                    noItemsFoundBuilder: (context) => const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text('No suggestions found.', textAlign: TextAlign.center),
                    ),
                    errorBuilder: (context, error) => Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text('Error: $error', style: TextStyle(color: errorColor)),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.my_location, color: primaryColor),
                  tooltip: 'Use Current Location',
                  onPressed: () async {
                    if (widget.isLocationA) {
                      await locationProvider.useCurrentLocationForA();
                    } else {
                      await locationProvider.useCurrentLocationForB();
                    }
                    if (locationProvider.hasError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: ${locationProvider.errorMessage}')),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
