import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import '../providers/location_provider.dart';
import '../services/location_service.dart';
import '../providers/place_provider.dart';

/// A widget for inputting a location, with autocomplete suggestions and a 'use current location' button.
///
/// This widget integrates with [LocationProvider] and [PlaceProvider] to manage state
/// and fetch suggestions. It uses [flutter_typeahead] for the autocomplete functionality.
class LocationInputWidget extends StatefulWidget {
  /// Whether this input field is for Location A (true) or Location B (false).
  final bool isLocationA;
  
  /// Placeholder text displayed in the input field.
  final String placeholder;
  
  /// Service for location-related operations (geocoding, place details).
  final LocationService locationService;

  /// Creates a new LocationInputWidget instance.
  ///
  /// @param key Widget key for identification
  /// @param isLocationA Whether this input is for Location A or B
  /// @param placeholder Placeholder text for the input field
  /// @param locationService Required service for location operations
  const LocationInputWidget({
    super.key,
    required this.isLocationA,
    required this.placeholder,
    required this.locationService,
  });

  @override
  State<LocationInputWidget> createState() => _LocationInputWidgetState();
}

/// The state class for the LocationInputWidget.
///
/// Manages the text controller and handles interactions with location providers.
class _LocationInputWidgetState extends State<LocationInputWidget> {
  /// Controller for the text input field
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);

    final currentLocation = widget.isLocationA
        ? locationProvider.locationA
        : locationProvider.locationB;

    if (currentLocation != null &&
        currentLocation.isCurrentLocation &&
        _controller.text.isEmpty) {
      _controller.text = currentLocation.address ?? 'Current Location';
    }

    if (currentLocation != null &&
        !currentLocation.isCurrentLocation &&
        _controller.text != currentLocation.address) {
      _controller.text = currentLocation.address ?? '';
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            widget.isLocationA ? 'Your Location' : 'Friend\'s Location',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 6),
          Material(
            elevation: 6,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TypeAheadField<Map<String, dynamic>>(
                      textFieldConfiguration: TextFieldConfiguration(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: widget.placeholder,
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(16.0),
                          prefixIcon: Icon(
                            widget.isLocationA
                                ? Icons.location_on
                                : Icons.person_pin_circle,
                            color:
                                widget.isLocationA ? Colors.blue : Colors.red,
                          ),
                        ),
                      ),
                      suggestionsCallback: (pattern) async {
                        return await Provider.of<PlaceProvider>(context, listen: false)
                            .getPlaceSuggestions(pattern);
                      },
                      itemBuilder: (context, suggestion) {
                        return ListTile(
                          title: Text(suggestion['description']),
                        );
                      },
                      onSuggestionSelected: (suggestion) async {
                        _controller.text = suggestion['description'];
                        try {
                          final placeId = suggestion['place_id'];
                          final location = await widget.locationService.getPlaceDetails(placeId);
                          if (widget.isLocationA) {
                            locationProvider.setLocationA(location);
                          } else {
                            locationProvider.setLocationB(location);
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error: ${e.toString()}')),
                          );
                        }
                      },
                      suggestionsBoxDecoration: const SuggestionsBoxDecoration(
                        elevation: 4.0,
                        constraints: BoxConstraints(maxHeight: 300),
                      ),
                      suggestionsBoxVerticalOffset: 12.0,
                      hideOnLoading: false,
                      hideOnEmpty: false,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.my_location),
                    onPressed: () async {
                      try {
                        if (widget.isLocationA) {
                          await locationProvider.useCurrentLocationForA();
                        } else {
                          await locationProvider.useCurrentLocationForB();
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: ${e.toString()}')),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
