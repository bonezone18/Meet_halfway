import 'package:flutter/foundation.dart';
import '../models/place_model.dart';
import '../models/location_model.dart';
import '../services/place_service.dart';

/// Defines the available options for sorting the list of places.
enum SortOption {
  /// Sort by distance from the midpoint (ascending)
  distance,
  /// Sort by rating (descending)
  rating,
  /// Sort by price level (ascending)
  priceAsc,
  /// Sort by price level (descending)
  priceDesc
}

/// Manages the state for searching, filtering, and sorting places.
///
/// This provider interacts with the [PlaceService] to fetch places near the midpoint.
/// It maintains the list of fetched places, handles loading states, errors,
/// category filtering, and sorting based on user selections.
class PlaceProvider with ChangeNotifier {
  /// Service for place-related operations
  final PlaceService _placeService;

  /// Creates a new PlaceProvider instance.
  ///
  /// Requires a [PlaceService] instance for interacting with the API.
  PlaceProvider(this._placeService);

  /// The complete list of places fetched from the API
  List<Place> _places = [];
  
  /// The list of places after applying filters and sorting
  List<Place> _filteredPlaces = [];
  
  /// Whether a place search is currently in progress
  bool _isLoading = false;
  
  /// Current error message, if any
  String _errorMessage = '';
  
  /// Set of currently selected category filters
  Set<String> _selectedCategories = {};
  
  /// Currently selected sorting option
  SortOption _sortOption = SortOption.distance;

  /// Getter for the complete list of places
  List<Place> get places => _places;
  
  /// Getter for the filtered and sorted list of places
  List<Place> get filteredPlaces => _filteredPlaces;
  
  /// Whether a place search is currently in progress
  bool get isLoading => _isLoading;
  
  /// Current error message, if any
  String get errorMessage => _errorMessage;
  
  /// Whether there is an active error
  bool get hasError => _errorMessage.isNotEmpty;
  
  /// Set of currently selected category filters
  Set<String> get selectedCategories => _selectedCategories;
  
  /// Currently selected sorting option
  SortOption get sortOption => _sortOption;

  /// List of preferred place types to search for initially (e.g., cafe, restaurant, bar).
  /// This list can be expanded to include more types.
  final List<String> _preferredTypes = ["cafe", "restaurant", "bar"];

  /// Gets a set of all unique place types available in the current list of fetched places.
  /// This is used to populate the category filter options.
  Set<String> get availableCategories {
    final categories = <String>{};
    for (final place in _places) {
      categories.addAll(place.types);
    }
    return categories;
  }

  /// Searches for places near the specified midpoint location.
  ///
  /// This method performs multiple searches for different place types (cafe, restaurant, bar)
  /// and combines the results. It handles deduplication, loading states, and error handling.
  ///
  /// @param midpoint The central location to search around
  /// @param radius The search radius in meters (defaults to 1500)
  /// @param maxResultsPerType Maximum number of results to return per place type (defaults to 10)
  /// @return A Future that completes when the search is done
  Future<void> searchPlaces(Location midpoint, {
    double radius = 1500,
    int maxResultsPerType = 10,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      List<Place> combinedResults = [];

      for (final type in _preferredTypes) {
        final places = await _placeService.searchNearbyPlaces(
          midpoint,
          radius: radius,
          type: type,
          maxResults: maxResultsPerType,
        );
        combinedResults.addAll(places);
      }

      // Deduplicate by Place ID
      final uniquePlaces = {
        for (var place in combinedResults) place.placeId: place
      }.values.toList();

      _places = uniquePlaces;
      _applyFilters();
    } catch (e) {
      _setError('Failed to search places: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  /// Gets place suggestions based on user input text.
  /// 
  /// This method is a wrapper around [PlaceService.getPlaceSuggestions].
  /// It's used for the autocomplete functionality in location search fields.
  /// 
  /// @param input The user's search text
  /// @return A Future that resolves to a list of place suggestions
  Future<List<Map<String, dynamic>>> getPlaceSuggestions(String input) {
    return _placeService.getPlaceSuggestions(input);
  }

  /// Toggles a category filter on or off.
  /// 
  /// If the category is already selected, it will be removed from the filters.
  /// If not, it will be added. The filtered places list is updated automatically.
  /// 
  /// @param category The category to toggle
  void toggleCategory(String category) {
    if (_selectedCategories.contains(category)) {
      _selectedCategories.remove(category);
    } else {
      _selectedCategories.add(category);
    }
    _applyFilters();
  }

  /// Clears all category filters.
  /// 
  /// This removes all selected categories and updates the filtered places list.
  void clearCategoryFilters() {
    _selectedCategories = {};
    _applyFilters();
  }

  /// Sets the sort option and reapplies filters.
  /// 
  /// @param option The new sort option to use
  void setSortOption(SortOption option) {
    _sortOption = option;
    _applyFilters();
  }

  /// Applies the current category filters and sort option to the list of places.
  ///
  /// This private method updates the [_filteredPlaces] list based on the selected
  /// categories and sort option. It should be called whenever filters or sort options change.
  void _applyFilters() {
    _filteredPlaces = List.from(_places);

    // Apply category filters
    if (_selectedCategories.isNotEmpty) {
      _filteredPlaces = _filteredPlaces.where((place) {
        return place.types.any((type) => _selectedCategories.contains(type));
      }).toList();
    }

    // Apply sorting
    switch (_sortOption) {
      case SortOption.distance:
        _filteredPlaces.sort((a, b) => a.distanceFromMidpoint.compareTo(b.distanceFromMidpoint));
        break;
      case SortOption.rating:
        _filteredPlaces.sort((a, b) {
          // Handle null ratings: places with null ratings go to the end
          if (a.rating == null && b.rating == null) return 0;
          if (a.rating == null) return 1;
          if (b.rating == null) return -1;
          return b.rating!.compareTo(a.rating!); // Descending order
        });
        break;
      case SortOption.priceAsc:
        _filteredPlaces.sort((a, b) {
          // Handle null price levels: places with null price levels go to the end
          if (a.priceLevel == null && b.priceLevel == null) return 0;
          if (a.priceLevel == null) return 1;
          if (b.priceLevel == null) return -1;
          return a.priceLevel!.length.compareTo(b.priceLevel!.length); // Ascending order
        });
        break;
      case SortOption.priceDesc:
        _filteredPlaces.sort((a, b) {
          // Handle null price levels: places with null price levels go to the end
          if (a.priceLevel == null && b.priceLevel == null) return 0;
          if (a.priceLevel == null) return 1;
          if (b.priceLevel == null) return -1;
          return b.priceLevel!.length.compareTo(a.priceLevel!.length); // Descending order
        });
        break;
    }

    notifyListeners();
  }

   /// Gets the URL for a place photo.
  ///
  /// This method constructs the photo URL using the [PlaceService.getPhotoUrl] method.
  /// Returns null if the place has no photo reference.
  ///
  /// @param place The place for which to get the photo URL
  /// @param maxWidth The maximum width of the photo in pixels (defaults to 400)
  /// @return The photo URL string, or null if no photo is available
  String? getPhotoUrl(Place place, {int maxWidth = 400}) {
    if (place.photoReference == null) return null;
    return _placeService.getPhotoUrl(place.photoReference!, maxWidth: maxWidth);
  }

  /// Sets the loading state and notifies listeners.
  /// 
  /// @param loading The new loading state
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  /// Sets an error message and notifies listeners.
  /// 
  /// @param message The error message to set
  void _setError(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  /// Clears any error message and notifies listeners.
  void _clearError() {
    _errorMessage = '';
    notifyListeners();
  }
}
