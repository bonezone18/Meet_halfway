/// How a participant gets to the venue.
enum TravelMode {
  drive('Drive', 'DRIVE', 'driving'),
  transit('Transit', 'TRANSIT', 'transit'),
  walk('Walk', 'WALK', 'walking'),
  bicycle('Bike', 'BICYCLE', 'bicycling');

  const TravelMode(this.label, this.routesApiValue, this.mapsUrlValue);

  final String label;

  /// Value for the Routes API `travelMode` field.
  final String routesApiValue;

  /// Value for the Google Maps URL `travelmode` parameter.
  final String mapsUrlValue;
}
