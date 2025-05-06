import 'package:flutter/foundation.dart';
import '../models/place_model.dart';
import '../models/location_model.dart';
import '../services/place_service.dart';
import '../services/midpoint_calculator.dart';

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

  /// Applies category filters and sorting to the full places list.
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

  /// Searches for places around the midpoint with a dynamic radius based on the distance between locationA and locationB.
  Future<void> searchPlaces(
    Location midpoint,
    Location locationA,
    Location locationB,
  ) async {
    _setLoading(true);
    _setError('');

    // Calculate half the distance between A and B (in km), then convert to meters and clamp to 3km–50km
    final distanceKm = MidpointCalculator.calculateDistance(locationA, locationB);
    double radius = (distanceKm / 2 * 1000).clamp(3000.0, 50000.0);

    final List<Place> allResults = [];

    try {
      // Launch all category searches in parallel to reduce latency
      final futures = _selectedCategories.map((category) {
        return _placeService.searchNearbyPlaces(
          midpoint,
          radius: radius,
          type: category,
        );
      }).toList();

      final resultsList = await Future.wait(futures);
      for (var results in resultsList) {
        allResults.addAll(results);
      }

      // If no results, escalate the search radius
      if (allResults.isEmpty) {
        allResults.addAll(await _escalateRadiusSearch(midpoint));
      }

      // Remove duplicates by placeId
      final uniquePlaces = {
        for (var place in allResults) place.placeId: place
      }.values.toList();

      if (uniquePlaces.isEmpty) {
        _setError('No places found within ${(radius / 1000).round()} km of midpoint.');
        _places = [];
      } else {
        _places = uniquePlaces;
        _applyFilters();
      }
    } catch (e) {
      _setError('Failed to load places: $e');
    } finally {
      _setLoading(false);
    }
  }

  /// Escalates the search radius in steps if initial searches return no results.
  ///
  /// This will first try 50km, then 100km (clamped to API max of 50km),
  /// before an optional reverse-geocode fallback.
  Future<List<Place>> _escalateRadiusSearch(Location midpoint) async {
    final List<Place> fallbackResults = [];

    for (final double newRadius in [50000.0, 100000.0]) {
      final clampedRadius = newRadius.clamp(0.0, 50000.0);
      for (final category in _selectedCategories) {
        final res = await _placeService.searchNearbyPlaces(
          midpoint,
          radius: clampedRadius,
          type: category,
        );
        fallbackResults.addAll(res);
      }
      if (fallbackResults.isNotEmpty) return fallbackResults;
    }

    // TODO: Final fallback: reverse-geocode midpoint to nearest locality and search around that point
    return fallbackResults;
  }

  /// Sets the sorting option and reapplies filters.
  void setSortOption(SortOption? option) {
    if (option != null) {
      _sortOption = option;
      _applyFilters();
    }
  }

  /// Retrieves place autocomplete suggestions.
  Future<List<Map<String, dynamic>>> getPlaceSuggestions(String input) {
    return _placeService.getPlaceSuggestions(input);
  }

  /// Constructs a photo URL for a given Place object.
  String? getPhotoUrl(Place place, {int maxWidth = 400}) {
    if (place.photoReference == null) return null;
    return _placeService.getPhotoUrl(place.photoReference!, maxWidth: maxWidth);
  }

  /// Resets the selected categories back to the defaults.
  void resetCategoryFilters() {
    _selectedCategories = {'cafe', 'restaurant', 'bar'};
    _applyFilters();
  }
}