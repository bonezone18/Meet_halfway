import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/location_model.dart';

class LocationService {
  // Geocode an address to get coordinates
  Future<Location> geocodeAddress(String address) async {
    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/geocode/json?address=$address&key=$googleApiKey'
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['status'] == 'OK') {
        final results = data['results'] as List;
        if (results.isNotEmpty) {
          final location = results.first;
          final geometry = location['geometry'];
          final coordinates = geometry['location'];

          return Location(
            address: location['formatted_address'],
            latitude: coordinates['lat'],
            longitude: coordinates['lng'],
          );
        }
      }

      throw Exception('Failed to geocode address: ${data['status']}');
    } else {
      throw Exception('Failed to geocode address: ${response.statusCode}');
    }
  }

  // Get the current device location
  Future<Location> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied.');
    }

    final position = await Geolocator.getCurrentPosition();
    return reverseGeocode(position.latitude, position.longitude);
  }

  // Reverse geocode coordinates to get an address
  Future<Location> reverseGeocode(double latitude, double longitude) async {
    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$googleApiKey'
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['status'] == 'OK') {
        final results = data['results'] as List;
        if (results.isNotEmpty) {
          final location = results.first;
          return Location(
            address: location['formatted_address'],
            latitude: latitude,
            longitude: longitude,
            isCurrentLocation: true,
          );
        }
      }

      return Location(
        address: 'Current Location',
        latitude: latitude,
        longitude: longitude,
        isCurrentLocation: true,
      );
    } else {
      throw Exception('Failed to reverse geocode: ${response.statusCode}');
    }
  }

  // Get place suggestions (handled by place_service.dart now)
  Future<List<Map<String, dynamic>>> getPlaceSuggestions(String input) async {
    throw UnimplementedError(
      'Use PlaceService.getPlaceSuggestions instead of LocationService for autocomplete.'
    );
  }

  // ✅ Corrected: Get place details using the right API
  Future<Location> getPlaceDetails(String placeId) async {
    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/place/details/json'
      '?place_id=$placeId'
      '&fields=formatted_address,geometry'
      '&key=$googleApiKey'
    );

    final response = await http.get(url);
    print('GET URL: $url');
    print('API response body: ${response.body}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['status'] == 'OK') {
        final result = data['result'];
        final geometry = result['geometry'];
        final location = geometry['location'];

        return Location(
          address: result['formatted_address'],
          latitude: location['lat'],
          longitude: location['lng'],
        );
      }

      throw Exception('Failed to get place details: ${data['status']}');
    } else {
      throw Exception('Failed to get place details: ${response.statusCode}');
    }
  }
}
