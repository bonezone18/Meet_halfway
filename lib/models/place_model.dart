class Place {
  final String id;
  final String name;
  final String? address;
  final double latitude;
  final double longitude;
  final double? rating;
  final int? userRatingsTotal;
  final String? photoReference;
  final bool isOpen;
  final List<String> types;
  final double distanceFromMidpoint;
  final String? priceLevel;
  final String? vicinity;
  final String? icon;

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
    this.priceLevel,
    this.vicinity,
    this.icon,
  });

  factory Place.fromJson(Map<String, dynamic> json, double distanceFromMidpoint) {
    final geometry = json['geometry'];
    final location = geometry['location'];
    
    return Place(
      id: json['place_id'],
      name: json['name'],
      address: json['formatted_address'],
      latitude: location['lat'],
      longitude: location['lng'],
      rating: json['rating']?.toDouble(),
      userRatingsTotal: json['user_ratings_total'],
      photoReference: json['photos'] != null && (json['photos'] as List).isNotEmpty 
          ? json['photos'][0]['photo_reference'] 
          : null,
      isOpen: json['opening_hours'] != null ? json['opening_hours']['open_now'] ?? false : false,
      types: json['types'] != null 
          ? List<String>.from(json['types']) 
          : [],
      distanceFromMidpoint: distanceFromMidpoint,
      priceLevel: json['price_level'] != null 
          ? _getPriceLevel(json['price_level']) 
          : null,
      vicinity: json['vicinity'],
      icon: json['icon'],
    );
  }

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
