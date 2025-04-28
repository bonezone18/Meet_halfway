import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/place_model.dart';
import '../models/location_model.dart';
import 'dart:math' as math;


class PlaceService {
  
//final String _googleApiKey;

//PlaceService(this._googleApiKey);

  // Search for places near the midpoint
  Future<List<Place>> searchNearbyPlaces(
    Location midpoint, 
    {
      double radius = 1500, // Default 1.5km radius
      String? type,
      String? keyword,
      int maxResults = 10,
    }
  ) async {
    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/place/nearbysearch/json'
      '?location=${midpoint.latitude},${midpoint.longitude}'
      '&radius=$radius'
      '${type != null ? '&type=$type' : ''}'
      '${keyword != null ? '&keyword=$keyword' : ''}'
      '&key=$googleApiKey'
    );
    
    final response = await http.get(url);
    print('GET URL: $url');
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
    print('API response body: ${response.body}');
      
      if (data['status'] == 'OK') {
        final results = data['results'] as List;
        
        // Convert results to Place objects and calculate distance
        final places = results.map((placeJson) {
          // Calculate distance from midpoint
          final lat = placeJson['geometry']['location']['lat'];
          final lng = placeJson['geometry']['location']['lng'];
          final placeLocation = Location(latitude: lat, longitude: lng);
          
          // Calculate distance in kilometers
          final distanceFromMidpoint = _calculateDistance(midpoint, placeLocation);
          
          return Place.fromJson(placeJson, distanceFromMidpoint);
        }).toList();
        
        // Sort by distance from midpoint
        places.sort((a, b) => a.distanceFromMidpoint.compareTo(b.distanceFromMidpoint));
        
        // Limit results
        if (places.length > maxResults) {
          return places.sublist(0, maxResults);
        }
        
        return places;
      }
      
      throw Exception('Failed to find places: ${data['status']}');
    } else {
      throw Exception('Failed to find places: ${response.statusCode}');
    }
  }

  Future<List<Map<String, dynamic>>> getPlaceSuggestions(String input) async {
  if (input.trim().isEmpty) return [];
  final url = Uri.parse(
    'https://maps.googleapis.com/maps/api/place/autocomplete/json'
    '?input=$input&key=$googleApiKey'
  );

  final response = await http.get(url);
    print('GET URL: $url');

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    print('API response body: ${response.body}');

    if (data['status'] == 'OK') {
      return (data['predictions'] as List)
          .map((item) => {
                'description': item['description'],
                'place_id': item['place_id'],
              })
          .toList();
    } else {
      throw Exception("Failed to get place suggestions: ${data['status']}");
    }
  } else {
    throw Exception("Failed to fetch place suggestions from API");
  }
}

  
  // Get place details
  Future<Place> getPlaceDetails(String placeId, double distanceFromMidpoint) async {
    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/place/details/json'
      '?place_id=$placeId'
      '&fields=name,formatted_address,geometry,rating,user_ratings_total,photos,opening_hours,types,price_level,vicinity,icon'
      '&key=$googleApiKey'
    );
    
    print('GET URL: $url');
    final response = await http.get(url);
    print('API response body: ${response.body}');
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      
      if (data['status'] == 'OK') {
        final result = data['result'];
        return Place.fromJson(result, distanceFromMidpoint);
      }
      
      throw Exception('Failed to get place details: ${data['status']}');
    } else {
      throw Exception('Failed to get place details: ${response.statusCode}');
    }
  }
  
  // Get place photo
  String getPhotoUrl(String photoReference, {int maxWidth = 400}) {
    return 'https://maps.googleapis.com/maps/api/place/photo'
      '?maxwidth=$maxWidth'
      '&photo_reference=$photoReference'
      '&key=$googleApiKey';
  }
  
  // Calculate distance between two locations using Haversine formula
  double _calculateDistance(Location location1, Location location2) {
    const earthRadius = 6371.0; // Earth's radius in kilometers
    
    // Convert to radians
    final lat1 = _degreesToRadians(location1.latitude);
    final lon1 = _degreesToRadians(location1.longitude);
    final lat2 = _degreesToRadians(location2.latitude);
    final lon2 = _degreesToRadians(location2.longitude);
    
    // Haversine formula
    final dLat = lat2 - lat1;
    final dLon = lon2 - lon1;
    
    final a = _square(Math.sin(dLat / 2)) + 
              Math.cos(lat1) * Math.cos(lat2) * 
              _square(Math.sin(dLon / 2));
              
    final c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    final distance = earthRadius * c;
    
    return distance;
  }
  
  // Helper method to convert degrees to radians
  double _degreesToRadians(double degrees) {
    return degrees * (Math.pi / 180.0);
  }
  
  // Helper method to square a number
  double _square(double value) {
    return value * value;
  }
}

// Math utility class to avoid importing dart:math
class Math {
  static double sin(double x) => math.sin(x);
  static double cos(double x) => math.cos(x);
  static double sqrt(double x) => math.sqrt(x);
  static double atan2(double y, double x) => math.atan2(y, x);
  static const double pi = math.pi;
}