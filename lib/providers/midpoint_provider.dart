import 'package:flutter/foundation.dart';
import '../models/location_model.dart';
import '../services/midpoint_calculator.dart';

/// Manages the state for the calculated midpoint between two locations.
///
/// This provider handles the midpoint calculation, loading states, and error handling.
/// It provides methods for calculating both geographic and weighted midpoints,
/// as well as calculating distances between locations.
class MidpointProvider with ChangeNotifier {
  /// The calculated midpoint location
  Location? _midpoint;
  
  /// Whether a calculation is currently in progress
  bool _isLoading = false;
  
  /// Current error message, if any
  String _errorMessage = '';
  
  /// Getter for the calculated midpoint
  Location? get midpoint => _midpoint;
  
  /// Whether a calculation is currently in progress
  bool get isLoading => _isLoading;
  
  /// Current error message, if any
  String get errorMessage => _errorMessage;
  
  /// Whether there is an active error
  bool get hasError => _errorMessage.isNotEmpty;
  
  /// Calculates the geographic midpoint between two locations.
  ///
  /// This method uses [MidpointCalculator.calculateGeographicMidpoint] to perform the calculation.
  /// It handles the loading state and error handling automatically.
  ///
  /// @param locationA The first location
  /// @param locationB The second location
  /// @return A Future that completes when the calculation is done
  Future<void> calculateMidpoint(Location locationA, Location locationB) async {
    _setLoading(true);
    _clearError();
    
    try {
      // Use a small delay to simulate calculation time
      await Future.delayed(const Duration(milliseconds: 500));
      
      // Calculate the midpoint
      final midpoint = MidpointCalculator.calculateGeographicMidpoint(
        locationA, 
        locationB
      );
      
      _midpoint = midpoint;
      notifyListeners();
    } catch (e) {
      _setError('Failed to calculate midpoint: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }
  
  /// Calculates a weighted midpoint between two locations based on specified weights.
  ///
  /// This method uses [MidpointCalculator.calculateWeightedMidpoint] to perform the calculation.
  /// The weights can represent factors like travel time, cost, or preference.
  /// It handles the loading state and error handling automatically.
  ///
  /// @param locationA The first location
  /// @param locationB The second location
  /// @param weightA The weight associated with the first location
  /// @param weightB The weight associated with the second location
  /// @return A Future that completes when the calculation is done
  Future<void> calculateWeightedMidpoint(
    Location locationA, 
    Location locationB,
    double weightA,
    double weightB
  ) async {
    _setLoading(true);
    _clearError();
    
    try {
      // Use a small delay to simulate calculation time
      await Future.delayed(const Duration(milliseconds: 500));
      
      // Calculate the weighted midpoint
      final midpoint = MidpointCalculator.calculateWeightedMidpoint(
        locationA, 
        locationB,
        weightA,
        weightB
      );
      
      _midpoint = midpoint;
      notifyListeners();
    } catch (e) {
      _setError('Failed to calculate weighted midpoint: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }
  
  /// Calculates the distance between two locations in kilometers.
  ///
  /// This method is a wrapper around [MidpointCalculator.calculateDistance].
  ///
  /// @param locationA The first location
  /// @param locationB The second location
  /// @return The distance between the two locations in kilometers
  double calculateDistance(Location locationA, Location locationB) {
    return MidpointCalculator.calculateDistance(locationA, locationB);
  }

  /// Sets the midpoint directly to the provided location.
  ///
  /// This method allows manually setting the midpoint without calculation.
  /// It also clears any error messages and notifies listeners.
  ///
  /// @param midpoint The location to set as the midpoint
  void setMidpoint(Location midpoint) {
  _midpoint = midpoint;
  _clearError();
  notifyListeners();
  }

  /// Clears the calculated midpoint and any error messages.
  ///
  /// This method resets the midpoint state and notifies listeners.
  void clearMidpoint() {
    _midpoint = null;
    _clearError();
    notifyListeners();
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
