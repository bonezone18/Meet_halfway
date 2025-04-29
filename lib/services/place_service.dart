import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/place_model.dart';
import '../models/location_model.dart';
import 'dart:math' as math;

/// Service for interacting with the Google Places API.
///
/// This service provides methods for searching nearby places, getting place details,
/// retrieving place photos, and handling place autocomplete suggestions.
/// It uses the Google Places API for all operations and requires a valid API key.
class PlaceService {
  
  /// Searches for places near the specified midpoint location.
  /// 
  /// This method queries the Google Places API's nearby search endpoint to find
  /// places within the specified radius of the midpoint. Results can be filtered
  /// by type and keyword, and are sorted by distance from the midpoint.
  /// 
  /// @param midpoint The central location to search around
  /// @param radius The search radius in meters (defaults to 1500)
  /// @param type Optional place type filter (e.g., "restaurant", "cafe")
  /// @param keyword Optional keyword to filter results
  /// @param maxResults Maximum number of results to return (defaults to 10)
  /// @return A list of Place objects sorted by distance from the midpoint
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
      '&key=${dotenv.env['GOOGLE_API_KEY']}'
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

  /// Gets place suggestions based on user input text.
  /// 
  /// This method uses the Google Places Autocomplete API to provide search suggestions
  /// as the user types. It returns a list of place descriptions and their IDs.
  /// 
  /// @param input The user's search text
  /// @return A list of maps containing place descriptions and IDs
  Future<List<Map<String, dynamic>>> getPlaceSuggestions(String input) async {
  if (input.trim().isEmpty) return [];
  final url = Uri.parse(
    "https://maps.googleapis.com/maps/api/place/autocomplete/json"
    "?input=$input&key=${dotenv.env["GOOGLE_API_KEY"]}"
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

  
  /// Retrieves detailed information for a specific place using its place ID.
  /// 
  /// This method queries the Google Places API Details endpoint to get comprehensive
  /// information about a place, including address, geometry, rating, photos, etc.
  /// 
  /// @param placeId The Google Places API ID of the place
  /// @param distanceFromMidpoint The pre-calculated distance from the midpoint (used for sorting/display)
  /// @return A Future that resolves to a Place object with detailed information
  Future<Place> getPlaceDetails(String placeId, double distanceFromMidpoint) async {
    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/place/details/json'
      '?place_id=$placeId'
      '&fields=name,formatted_address,geometry,rating,user_ratings_total,photos,opening_hours,types,price_level,vicinity,icon'
      '&key=${dotenv.env['GOOGLE_API_KEY']}'
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
  
  /// Constructs the URL for retrieving a place photo from the Google Places API.
  /// 
  /// @param photoReference The reference ID of the photo (obtained from place details)
  /// @param maxWidth The maximum width of the photo in pixels (defaults to 400)
  /// @return The URL string for the place photo
  String getPhotoUrl(String photoReference, {int maxWidth = 400}) {
    return 'https://maps.googleapis.com/maps/api/place/photo'
      '?maxwidth=$maxWidth'
      '&photo_reference=$photoReference'
      '&key=${dotenv.env['GOOGLE_API_KEY']}';
  }
  
  /// Calculates the distance between two locations using the Haversine formula.
  /// 
  /// This private method computes the great-circle distance between two points on a sphere
  /// given their latitudes and longitudes. It accounts for the Earth's curvature.
  /// 
  /// @param location1 The first location
  /// @param location2 The second location
  /// @return The distance between the locations in kilometers
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
  
  /// Helper method to convert degrees to radians.
  /// 
  /// @param degrees The angle in degrees
  /// @return The angle converted to radians
  double _degreesToRadians(double degrees) {
    return degrees * (Math.pi / 180.0);
  }
  
  /// Helper method to square a number.
  /// 
  /// @param value The number to square
  /// @return The square of the input value
  double _square(double value) {
    return value * value;
  }
}

// Math utility class to avoid importing dart:math
/// Utility class that provides math operations.
///
/// This class wraps the dart:math library functions to provide a cleaner interface
/// and avoid direct imports in multiple places.
class Math {
  /// Returns the sine of the specified angle in radians.
  static double sin(double x) => math.sin(x);
  
  /// Returns the cosine of the specified angle in radians.
  static double cos(double x) => math.cos(x);
  
  /// Returns the square root of the specified value.
  static double sqrt(double x) => math.sqrt(x);
  
  /// Returns the angle in radians between the positive x-axis and the point (x, y).
  static double atan2(double y, double x) => math.atan2(y, x);
  
  /// The mathematical constant π (pi).
  static const double pi = math.pi;
}