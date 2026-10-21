/// Kinds of venue the user can search for, mapped to Places API (New) types.
/// https://developers.google.com/maps/documentation/places/web-service/place-types
enum VenueCategory {
  restaurant('Restaurants', 'restaurant'),
  cafe('Cafes', 'cafe'),
  bar('Bars', 'bar'),
  park('Parks', 'park'),
  shoppingMall('Shopping', 'shopping_mall'),
  movieTheater('Movies', 'movie_theater'),
  museum('Museums', 'museum'),
  library('Libraries', 'library'),
  artGallery('Art galleries', 'art_gallery'),
  touristAttraction('Attractions', 'tourist_attraction');

  const VenueCategory(this.label, this.apiType);

  final String label;
  final String apiType;

  static const Set<VenueCategory> defaults = {
    VenueCategory.cafe,
    VenueCategory.restaurant,
    VenueCategory.bar,
  };
}
