import 'package:flutter/foundation.dart';
import '../models/place_model.dart';
import '../models/location_model.dart';
import '../services/place_service.dart';

/// Defines the available options for sorting the list of places.
enum SortOption {
  distance,
  rating,
  priceAsc,
  priceDesc,
}

/// Manages the state for searching, filtering, and sorting places.
class PlaceProvider with ChangeNotifier {
  final PlaceService _placeService;

  PlaceProvider(this._placeService);

  List<Place> _places = [];
  List<Place> _filteredPlaces = [];
  bool _isLoading = false;
  String _errorMessage = '';
  Set<String> _selectedCategories = {'cafe', 'restaurant', 'bar'};
  SortOption _sortOption = SortOption.distance;

  List<Place> get places => _places;
  List<Place> get filteredPlaces => _filteredPlaces;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  Set<String> get selectedCategories => _selectedCategories;
  SortOption get sortOption => _sortOption;

  void toggleCategory(String category) {
    if (_selectedCategories.contains(category)) {
      _selectedCategories.remove(category);
    } else {
      _selectedCategories.add(category);
    }
    _applyFilters();
  }

  void clearCategoryFilters() {
    _selectedCategories.clear();
    _applyFilters();
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  void _applyFilters() {
    List<Place> updated = [..._places];

    if (_selectedCategories.isNotEmpty) {
      updated = updated.where((place) {
        return place.types.any((type) => _selectedCategories.contains(type));
      }).toList();
    }

    switch (_sortOption) {
      case SortOption.distance:
        updated.sort((a, b) => a.distanceFromMidpoint.compareTo(b.distanceFromMidpoint));
        break;
      case SortOption.rating:
        updated.sort((b, a) => (a.rating ?? 0).compareTo(b.rating ?? 0));
        break;
      case SortOption.priceAsc:
        updated.sort((a, b) => (a.priceLevel ?? '').compareTo(b.priceLevel ?? ''));
        break;
      case SortOption.priceDesc:
        updated.sort((b, a) => (a.priceLevel ?? '').compareTo(b.priceLevel ?? ''));
        break;
    }

    _filteredPlaces = updated;
    notifyListeners();
  }

  Future<void> searchPlaces(Location midpoint, {double radius = 3000}) async {
    _setLoading(true);
    _setError('');

    final List<Place> allResults = [];

    try {
      for (final category in _selectedCategories) {
        final results = await _placeService.searchNearbyPlaces(
          midpoint,
          radius: radius,
          type: category,
        );
        allResults.addAll(results);
      }

      final uniquePlaces = {
        for (var place in allResults) place.placeId: place
      }.values.toList();

      _places = uniquePlaces;
      _applyFilters();
    } catch (e) {
      _setError('Failed to load places: $e');
    } finally {
      _setLoading(false);
    }
  }

  void setSortOption(SortOption? option) {
    if (option != null) {
      _sortOption = option;
      _applyFilters();
    }
  }

  Future<List<Map<String, dynamic>>> getPlaceSuggestions(String input) {
    return _placeService.getPlaceSuggestions(input);
  }

  String? getPhotoUrl(Place place, {int maxWidth = 400}) {
    if (place.photoReference == null) return null;
    return _placeService.getPhotoUrl(place.photoReference!, maxWidth: maxWidth);
  }
}
