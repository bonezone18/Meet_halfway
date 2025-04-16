import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import '../providers/location_provider.dart';
import '../services/location_service.dart';
import '../providers/place_provider.dart';

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
