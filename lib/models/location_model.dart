class Location {
  final String? id;
  final String? name;
  final String? address;
  final double latitude;
  final double longitude;
  final bool isCurrentLocation;

  Location({
    this.id,
    this.name,
    this.address,
    required this.latitude,
    required this.longitude,
    this.isCurrentLocation = false,
  });

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

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      isCurrentLocation: json['isCurrentLocation'] ?? false,
    );
  }

  @override
  String toString() {
    return 'Location(id: $id, name: $name, address: $address, latitude: $latitude, longitude: $longitude, isCurrentLocation: $isCurrentLocation)';
  }
}
