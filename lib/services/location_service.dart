import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/location_model.dart';

/// Service for handling location-related operations.
///
/// This service provides methods for:
/// - Geocoding addresses to coordinates using the Google Geocoding API
/// - Getting the current device location using the Geolocator package
/// - Reverse geocoding coordinates to addresses using the Google Geocoding API
/// - Retrieving place details (address and geometry) using the Google Places API
class LocationService {
  /// Geocodes a human-readable address into geographic coordinates (latitude/longitude).
  ///
  /// Uses the Google Geocoding API to convert an address string into a Location object.
  ///
  /// @param address The address string to geocode
  /// @return A Future that resolves to a Location object with coordinates and formatted address
  /// 
  /// 
  
Future<Location> geocodeAddress(String address) async {
  final apiKey = dotenv.env['GOOGLE_MAPS_API_KEY'];
  if (apiKey == null || apiKey.isEmpty) {
    throw Exception('Google Maps API key is missing from .env');
  }

  final url = Uri.parse(
    'https://maps.googleapis.com/maps/api/geocode/json?address=$address&key=$apiKey'
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

  /// Gets the current device location and converts it to a Location object.
  ///
  /// This method:
  /// 1. Checks if location services are enabled
  /// 2. Requests location permissions if needed
  /// 3. Gets the current position using Geolocator
  /// 4. Reverse geocodes the coordinates to get an address
  ///
  /// @return A Future that resolves to a Location object with the current position
  /// @throws Exception if location services are disabled or permissions are denied
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

  /// Converts geographic coordinates to a human-readable address.
  ///
  /// Uses the Google Geocoding API to perform reverse geocoding, converting
  /// latitude and longitude into a formatted address.
  ///
  /// @param latitude The latitude coordinate
  /// @param longitude The longitude coordinate
  /// @return A Future that resolves to a Location object with the coordinates and address
  Future<Location> reverseGeocode(double latitude, double longitude) async {
    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=${dotenv.env['GOOGLE_MAPS_API_KEY']}'
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

  /// Legacy method that is no longer implemented.
  ///
  /// This method is deprecated and will throw an UnimplementedError.
  /// Use PlaceService.getPlaceSuggestions instead for place autocomplete functionality.
  ///
  /// @param input The search text
  /// @throws UnimplementedError Always throws this error
  Future<List<Map<String, dynamic>>> getPlaceSuggestions(String input) async {
    throw UnimplementedError(
      'Use PlaceService.getPlaceSuggestions instead of LocationService for autocomplete.'
    );
  }

  /// Retrieves detailed information for a place using its place ID.
  /// 
  /// This method uses the Google Places API Details endpoint to get address and
  /// geometry information for a specific place.
  /// 
  /// @param placeId The Google Places API ID of the place
  /// @return A Future that resolves to a Location object with the place details
  Future<Location> getPlaceDetails(String placeId) async {
    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/place/details/json'
      '?place_id=$placeId'
      '&fields=formatted_address,geometry'
      '&key=${dotenv.env['GOOGLE_MAPS_API_KEY']}'
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
