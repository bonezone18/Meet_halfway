/// Represents a geographic location with coordinates and optional metadata.
///
/// This model is used throughout the application to represent user locations,
/// midpoints, and places. It contains geographic coordinates (latitude/longitude)
/// and optional metadata such as name, address, and a flag for current location.
class Location {
  /// Optional unique identifier for the location
  final String? id;
  
  /// Optional descriptive name of the location (e.g., "Home", "Work", "Midpoint")
  final String? name;
  
  /// Optional formatted address of the location
  final String? address;
  
  /// Latitude coordinate in decimal degrees
  final double latitude;
  
  /// Longitude coordinate in decimal degrees
  final double longitude;
  
  /// Flag indicating whether this location represents the user's current position
  final bool isCurrentLocation;

  /// Creates a new Location instance.
  ///
  /// The [latitude] and [longitude] parameters are required, while others are optional.
  /// [isCurrentLocation] defaults to false if not specified.
  ///
  /// @param id Optional unique identifier
  /// @param name Optional descriptive name
  /// @param address Optional formatted address
  /// @param latitude Required latitude coordinate in decimal degrees
  /// @param longitude Required longitude coordinate in decimal degrees
  /// @param isCurrentLocation Whether this is the user's current location (defaults to false)
  Location({
    this.id,
    this.name,
    this.address,
    required this.latitude,
    required this.longitude,
    this.isCurrentLocation = false,
  });

  /// Creates a copy of this Location with the given fields replaced with new values.
  ///
  /// This method is useful for updating a location while preserving immutability.
  /// Only the fields that are provided will be changed in the new instance.
  ///
  /// @param id New id (or null to keep the current value)
  /// @param name New name (or null to keep the current value)
  /// @param address New address (or null to keep the current value)
  /// @param latitude New latitude (or null to keep the current value)
  /// @param longitude New longitude (or null to keep the current value)
  /// @param isCurrentLocation New isCurrentLocation flag (or null to keep the current value)
  /// @return A new Location instance with the updated values
  Location copyWith({
    String? id,
    String? name,
    String? address,
    double? latitude,
    double? longitude,
    bool? isCurrentLocation,
  }) {
    return Location(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      isCurrentLocation: isCurrentLocation ?? this.isCurrentLocation,
    );
  }

  /// Converts this Location instance into a JSON map.
  ///
  /// @return A map containing the key-value pairs representing the location data.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'isCurrentLocation': isCurrentLocation,
    };
  }

  /// Creates a Location instance from a JSON map.
  ///
  /// This factory constructor is used for deserializing location data.
  /// It expects the map to contain keys like 'latitude', 'longitude', and optionally
  /// 'id', 'name', 'address', and 'isCurrentLocation'.
  ///
  /// @param json A map containing the location data
  /// @return A new Location instance created from the JSON data
  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json["id"],
      name: json["name"],
      address: json["address"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      isCurrentLocation: json["isCurrentLocation"] ?? false,
    );
  }

  /// Returns a string representation of this Location instance.
  ///
  /// This is useful for debugging and logging purposes.
  ///
  /// @return A string representation of the location
  @override
  String toString() {
    return 'Location(id: $id, name: $name, address: $address, latitude: $latitude, longitude: $longitude, isCurrentLocation: $isCurrentLocation)';
  }
}
