import 'package:flutter/foundation.dart';
import '../models/place_model.dart';
import '../models/location_model.dart';
import '../services/place_service.dart';

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

  List<Place> get places => _places;
  List<Place> get filteredPlaces => _filteredPlaces;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  bool get hasError => _errorMessage.isNotEmpty;
  Set<String> get selectedCategories => _selectedCategories;
  SortOption get sortOption => _sortOption;

  // Preferred categories (can easily be expanded)
  final List<String> _preferredTypes = ['cafe', 'restaurant', 'bar'];

  Set<String> get availableCategories {
    final categories = <String>{};
    for (final place in _places) {
      categories.addAll(place.types);
    }
    return categories;
  }

  // NEW: Scalable multi-query search implementation
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

  Future<List<Map<String, dynamic>>> getPlaceSuggestions(String input) {
    return _placeService.getPlaceSuggestions(input);
  }

  void toggleCategory(String category) {
    if (_selectedCategories.contains(category)) {
      _selectedCategories.remove(category);
    } else {
      _selectedCategories.add(category);
    }
    _applyFilters();
  }

  void clearCategoryFilters() {
    _selectedCategories = {};
    _applyFilters();
  }

  void setSortOption(SortOption option) {
    _sortOption = option;
    _applyFilters();
  }

  void _applyFilters() {
    _filteredPlaces = List.from(_places);

    if (_selectedCategories.isNotEmpty) {
      _filteredPlaces = _filteredPlaces.where((place) {
        return place.types.any((type) => _selectedCategories.contains(type));
      }).toList();
    }

    switch (_sortOption) {
      case SortOption.distance:
        _filteredPlaces.sort((a, b) => a.distanceFromMidpoint.compareTo(b.distanceFromMidpoint));
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
