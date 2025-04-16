import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/location_model.dart';


class DirectionsService {
  final String _googleApiKey;

  DirectionsService(this._googleApiKey);
  
  // Get directions between two locations
  Future<Map<String, dynamic>> getDirections(
    Location origin,
    Location destination,
    {String mode = 'driving'} // driving, walking, bicycling, transit
  ) async {
    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/directions/json'
      '?origin=${origin.latitude},${origin.longitude}'
      '&destination=${destination.latitude},${destination.longitude}'
      '&mode=$mode'
      '&key=${_googleApiKey}'
    );
    
    
    final response = await http.get(url);
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      
      if (data['status'] == 'OK') {
        return data;
      }
      
      throw Exception('Failed to get directions: ${data['status']}');
    } else {
      throw Exception('Failed to get directions: ${response.statusCode}');
    }
  }
  
  // Get travel time between two locations
  Future<Map<String, dynamic>> getTravelTime(
    Location origin,
    Location destination,
    {String mode = 'driving'}
  ) async {
    final directionsData = await getDirections(origin, destination, mode: mode);
    
    if (directionsData['routes'].isEmpty) {
      throw Exception('No routes found');
    }
    
    final route = directionsData['routes'][0];
    final leg = route['legs'][0];
    
    return {
      'distance': leg['distance'],
      'duration': leg['duration'],
      'start_address': leg['start_address'],
      'end_address': leg['end_address'],
      'steps': leg['steps'],
    };
  }
  
  // Get Google Maps URL for directions
  String getDirectionsUrl(
    Location origin,
    Location destination,
    {String mode = 'driving'}
  ) {
    return 'https://www.google.com/maps/dir/?api=1'
      '&origin=${origin.latitude},${origin.longitude}'
      '&destination=${destination.latitude},${destination.longitude}'
      '&travelmode=$mode';
  }
  
  // Get static map image URL for a route
  String getStaticMapUrl(
    Location origin,
    Location destination,
    Location midpoint,
    {int width = 600, int height = 300}
  ) {
    return 'https://maps.googleapis.com/maps/api/staticmap'
      '?size=${width}x$height'
      '&markers=color:red|label:A|${origin.latitude},${origin.longitude}'
      '&markers=color:green|label:M|${midpoint.latitude},${midpoint.longitude}'
      '&markers=color:blue|label:B|${destination.latitude},${destination.longitude}'
      '&path=color:0x0000ff|weight:5|${origin.latitude},${origin.longitude}|${midpoint.latitude},${midpoint.longitude}|${destination.latitude},${destination.longitude}'
      '&key=${_googleApiKey}';
  }
}
