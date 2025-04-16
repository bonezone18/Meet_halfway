import 'package:flutter/foundation.dart';
import '../models/place_model.dart';
import '../models/location_model.dart';
import '../services/place_service.dart';
//import '../constants/api_keys.dart';

enum SortOption {
  distance,
  rating,
  priceAsc,
  priceDesc
}

class PlaceProvider with ChangeNotifier {
  final PlaceService _placeService;

  PlaceProvider(this._placeService);

  
  List<Place> _places = [];
  List<Place> _filteredPlaces = [];
  bool _isLoading = false;
  String _errorMessage = '';
  Set<String> _selectedCategories = {};
  SortOption _sortOption = SortOption.distance;

  Future<List<Map<String, dynamic>>> getPlaceSuggestions(String input) {
    return _placeService.getPlaceSuggestions(input);
  }

  
  //PlaceProvider(this._placeService);
  
  List<Place> get places => _places;
  List<Place> get filteredPlaces => _filteredPlaces;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  bool get hasError => _errorMessage.isNotEmpty;
  Set<String> get selectedCategories => _selectedCategories;
  SortOption get sortOption => _sortOption;
  
  // Get all available categories from the places
  Set<String> get availableCategories {
    final categories = <String>{};
    for (final place in _places) {
      categories.addAll(place.types);
    }
    return categories;
  }
  
  // Search for places near the midpoint
  Future<void> searchPlaces(Location midpoint, {
    double radius = 1500,
    String? type,
    String? keyword,
    int maxResults = 10,
  }) async {
    _setLoading(true);
    _clearError();
    
    try {
      final places = await _placeService.searchNearbyPlaces(
        midpoint,
        radius: radius,
        type: type,
        keyword: keyword,
        maxResults: maxResults,
      );
      
      _places = places;
      _filteredPlaces = List.from(places);
      _selectedCategories = {};
      notifyListeners();
    } catch (e) {
      _setError('Failed to search places: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }
  
  // Toggle category filter
  void toggleCategory(String category) {
    if (_selectedCategories.contains(category)) {
      _selectedCategories.remove(category);
    } else {
      _selectedCategories.add(category);
    }
    _applyFilters();
  }
  
  // Clear all category filters
  void clearCategoryFilters() {
    _selectedCategories = {};
    _applyFilters();
  }
  
  // Set sort option
  void setSortOption(SortOption option) {
    _sortOption = option;
    _applyFilters();
  }
  
  // Apply filters and sorting
  void _applyFilters() {
    // Start with all places
    _filteredPlaces = List.from(_places);
    
    // Apply category filters if any are selected
    if (_selectedCategories.isNotEmpty) {
      _filteredPlaces = _filteredPlaces.where((place) {
        // Check if any of the place's types match any of the selected categories
        return place.types.any((type) => _selectedCategories.contains(type));
      }).toList();
    }
    
    // Apply sorting
    switch (_sortOption) {
      case SortOption.distance:
        _filteredPlaces.sort((a, b) => 
          a.distanceFromMidpoint.compareTo(b.distanceFromMidpoint));
        break;
      case SortOption.rating:
        _filteredPlaces.sort((a, b) {
          if (a.rating == null && b.rating == null) return 0;
          if (a.rating == null) return 1;
          if (b.rating == null) return -1;
          return b.rating!.compareTo(a.rating!);
        });
        break;
      case SortOption.priceAsc:
        _filteredPlaces.sort((a, b) {
          if (a.priceLevel == null && b.priceLevel == null) return 0;
          if (a.priceLevel == null) return 1;
          if (b.priceLevel == null) return -1;
          return a.priceLevel!.length.compareTo(b.priceLevel!.length);
        });
        break;
      case SortOption.priceDesc:
        _filteredPlaces.sort((a, b) {
          if (a.priceLevel == null && b.priceLevel == null) return 0;
          if (a.priceLevel == null) return 1;
          if (b.priceLevel == null) return -1;
          return b.priceLevel!.length.compareTo(a.priceLevel!.length);
        });
        break;
    }
    
    notifyListeners();
  }
  
  // Get photo URL for a place
  String? getPhotoUrl(Place place, {int maxWidth = 400}) {
    if (place.photoReference == null) return null;
    return _placeService.getPhotoUrl(place.photoReference!, maxWidth: maxWidth);
  }
  
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
  
  void _setError(String message) {
    _errorMessage = message;
    notifyListeners();
  }
  
  void _clearError() {
    _errorMessage = '';
    notifyListeners();
  }
}