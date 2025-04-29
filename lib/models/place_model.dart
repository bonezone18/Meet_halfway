/// Represents a place or venue with detailed information.
///
/// This model is used to represent places returned from the Google Places API,
/// including restaurants, cafes, parks, and other points of interest.
/// It contains geographic coordinates, business information, and metadata
/// about the place's distance from the calculated midpoint.
class Place {
  /// Unique identifier for the place
  final String id;
  
  /// Name of the place (e.g., "Starbucks", "Central Park")
  final String name;
  
  /// Optional formatted address of the place
  final String? address;
  
  /// Latitude coordinate in decimal degrees
  final double latitude;
  
  /// Longitude coordinate in decimal degrees
  final double longitude;
  
  /// Optional rating of the place (typically 1.0 to 5.0)
  final double? rating;
  
  /// Optional count of user ratings
  final int? userRatingsTotal;
  
  /// Optional reference ID for the place's photo in Google Places API
  final String? photoReference;
  
  /// Whether the place is currently open
  final bool isOpen;
  
  /// List of category types for the place (e.g., ["restaurant", "food"])
  final List<String> types;
  
  /// Distance from the calculated midpoint in kilometers
  final double distanceFromMidpoint;
  
  /// Optional price level indicator (e.g., "$", "$$", "$$$")
  final String? priceLevel;
  
  /// Optional vicinity description (typically a short address)
  final String? vicinity;
  
  /// Optional URL for the place's icon
  final String? icon;
  
  /// Google Places API place ID
  final String placeId;


  /// Creates a new Place instance.
  ///
  /// Several parameters are required to properly identify and locate the place:
  /// [id], [name], [latitude], [longitude], [types], [distanceFromMidpoint], and [placeId].
  /// Other parameters are optional and provide additional details about the place.
  ///
  /// @param id Unique identifier for the place
  /// @param name Name of the place
  /// @param address Optional formatted address
  /// @param latitude Latitude coordinate in decimal degrees
  /// @param longitude Longitude coordinate in decimal degrees
  /// @param rating Optional rating (typically 1.0 to 5.0)
  /// @param userRatingsTotal Optional count of user ratings
  /// @param photoReference Optional reference ID for the place's photo
  /// @param isOpen Whether the place is currently open (defaults to false)
  /// @param types List of category types for the place
  /// @param distanceFromMidpoint Distance from the calculated midpoint in kilometers
  /// @param placeId Google Places API place ID
  /// @param priceLevel Optional price level indicator
  /// @param vicinity Optional vicinity description
  /// @param icon Optional URL for the place's icon
  Place({
    required this.id,
    required this.name,
    this.address,
    required this.latitude,
    required this.longitude,
    this.rating,
    this.userRatingsTotal,
    this.photoReference,
    this.isOpen = false,
    required this.types,
    required this.distanceFromMidpoint,
    required this.placeId,
    this.priceLevel,
    this.vicinity,
    this.icon,
  });

  /// Creates a Place instance from a JSON map returned by the Google Places API.
  ///
  /// This factory constructor parses the JSON data, extracts relevant fields,
  /// and calculates the distance from the provided midpoint.
  /// It handles potential missing fields and converts data types as needed.
  ///
  /// @param json A map containing the place data from the Google Places API
  /// @param distanceFromMidpoint The calculated distance from the midpoint in kilometers
  /// @return A new Place instance created from the JSON data
  factory Place.fromJson(Map<String, dynamic> json, double distanceFromMidpoint) {
    final geometry = json["geometry"];
    final location = geometry["location"];
    
    return Place(
      id: json["place_id"],
      name: json["name"],
      address: json["formatted_address"],
      latitude: location["lat"],
      longitude: location["lng"],
      rating: json["rating"]?.toDouble(),
      userRatingsTotal: json["user_ratings_total"],
      photoReference: json["photos"] != null && (json["photos"] as List).isNotEmpty 
          ? json["photos"][0]["photo_reference"] 
          : null,
      isOpen: json["opening_hours"] != null ? json["opening_hours"]["open_now"] ?? false : false,
      types: json["types"] != null 
          ? List<String>.from(json["types"]) 
          : [],
      distanceFromMidpoint: distanceFromMidpoint,
      placeId: json["place_id"] ?? "",
      priceLevel: json["price_level"] != null 
          ? _getPriceLevel(json["price_level"]) 
          : null,
      vicinity: json["vicinity"],
      icon: json["icon"],
    );
  }

  /// Converts a numeric price level to a human-readable string representation.
  /// 
  /// @param level The numeric price level (0-4)
  /// @return A string representation of the price level ('Free', '$', '$$', etc.)
  static String _getPriceLevel(dynamic level) {
    switch(level) {
      case 0: return 'Free';
      case 1: return '\$';
      case 2: return '\$\$';
      case 3: return '\$\$\$';
      case 4: return '\$\$\$\$';
      default: return '\$';
    }
  }


  /// Converts this Place instance into a JSON map.
  ///
  /// This method is useful for serializing place data for storage or transmission.
  ///
  /// @return A map containing the key-value pairs representing the place data
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'rating': rating,
      'userRatingsTotal': userRatingsTotal,
      'photoReference': photoReference,
      'isOpen': isOpen,
      'types': types,
      'distanceFromMidpoint': distanceFromMidpoint,
      'priceLevel': priceLevel,
      'vicinity': vicinity,
      'icon': icon,
    };
  }
}
