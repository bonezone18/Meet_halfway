import 'dart:async'; // Import Timer
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import '../providers/location_provider.dart';
import '../services/location_service.dart';
import '../providers/place_provider.dart';
import '../models/location_model.dart'; // Import Location model

/// A widget for inputting a location, with autocomplete suggestions and a 'use current location' button.
///
/// This widget integrates with [LocationProvider] and [PlaceProvider] to manage state
/// and fetch suggestions. It uses [flutter_typeahead] for the autocomplete functionality.
/// Includes debouncing for suggestion fetching to optimize API calls.
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
        final suggestions = await Provider.of<PlaceProvider>(context, listen: false).getPlaceSuggestions(pattern);
        if (!completer.isCompleted) {
          completer.complete(suggestions);
        }
      } catch (e) {
        if (!completer.isCompleted) {
          completer.complete([{'description': 'Error fetching suggestions', 'place_id': ''}]);
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
      final expectedText = currentLocation.address ?? (currentLocation.isCurrentLocation ? 'Current Location (${currentLocation.latitude.toStringAsFixed(4)}, ${currentLocation.longitude.toStringAsFixed(4)})' : '');
      if (_controller.text != expectedText) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            _controller.text = expectedText;
            _controller.selection = TextSelection.fromPosition(TextPosition(offset: _controller.text.length));
          }
        });
      }
    } else {
      if (_controller.text.isNotEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            _controller.clear();
          }
        });
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            widget.isLocationA ? 'Your Location' : 'Friend\'s Location',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
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
                      style: Theme.of(context).textTheme.bodyLarge,
                      decoration: InputDecoration(
                        hintText: widget.placeholder,
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 0),
                        prefixIcon: Icon(
                          widget.isLocationA ? Icons.location_on : Icons.person_pin_circle,
                          color: widget.isLocationA
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      onSubmitted: (value) async {
                        final trimmed = value.trim();
                        if (trimmed.isEmpty) return;

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Geocoding address...'), duration: Duration(seconds: 1)),
                        );

                        try {
                          final location = await widget.locationService.geocodeAddress(trimmed);
                          if (widget.isLocationA) {
                            locationProvider.setLocationA(location);
                          } else {
                            locationProvider.setLocationB(location);
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error geocoding address: ${e.toString()}')),
                          );
                        }
                      },
                      onChanged: (value) {
                        if (value.isEmpty) {
                          if (widget.isLocationA) {
                            if (locationProvider.locationA != null) {
                              locationProvider.setLocationA(Location(latitude: 0, longitude: 0));
                            }
                          } else {
                            if (locationProvider.locationB != null) {
                              locationProvider.setLocationB(Location(latitude: 0, longitude: 0));
                            }
                          }
                        }
                      },
                    ),
                    suggestionsCallback: _getDebouncedSuggestions,
                    itemBuilder: (context, suggestion) {
                      if (suggestion['place_id'] == '') {
                        return ListTile(
                          title: Text(suggestion['description'], style: TextStyle(color: Theme.of(context).colorScheme.error)),
                          dense: true,
                        );
                      }
                      return ListTile(
                        title: Text(suggestion['description'] ?? 'Unknown suggestion'),
                        dense: true,
                      );
                    },
                    onSuggestionSelected: (suggestion) async {
                      if (suggestion['place_id'] == '') return;

                      _controller.text = suggestion['description'] ?? '';
                      final placeId = suggestion['place_id'];
                      if (placeId == null || placeId.isEmpty) return;

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Fetching location details...'), duration: Duration(seconds: 1)),
                      );

                      try {
                        final location = await widget.locationService.getPlaceDetails(placeId);
                        if (widget.isLocationA) {
                          locationProvider.setLocationA(location);
                        } else {
                          locationProvider.setLocationB(location);
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error fetching details: ${e.toString()}')),
                        );
                      }
                    },
                    suggestionsBoxDecoration: SuggestionsBoxDecoration(
                      elevation: 4.0,
                      borderRadius: BorderRadius.circular(8.0),
                      constraints: const BoxConstraints(maxHeight: 250),
                    ),
                    hideOnLoading: false,
                    loadingBuilder: (context) => const Center(child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(strokeWidth: 2.0),
                    )),
                    noItemsFoundBuilder: (context) => const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text('No suggestions found.', textAlign: TextAlign.center),
                    ),
                    errorBuilder: (context, error) => Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text('Error: $error', style: TextStyle(color: Theme.of(context).colorScheme.error)),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.my_location, color: Theme.of(context).colorScheme.primary),
                  tooltip: 'Use Current Location',
                  onPressed: () async {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Getting current location...'), duration: Duration(seconds: 1)),
                    );
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
