import 'package:flutter/foundation.dart';
import '../models/location_model.dart';
import '../services/midpoint_calculator.dart';

class MidpointProvider with ChangeNotifier {
  Location? _midpoint;
  bool _isLoading = false;
  String _errorMessage = '';
  
  Location? get midpoint => _midpoint;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  bool get hasError => _errorMessage.isNotEmpty;
  
  // Calculate the geographic midpoint between two locations
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
  
  // Calculate a weighted midpoint based on travel time or other factors
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
  
  // Calculate distance between two locations
  double calculateDistance(Location locationA, Location locationB) {
    return MidpointCalculator.calculateDistance(locationA, locationB);
  }

  void setMidpoint(Location midpoint) {
  _midpoint = midpoint;
  _clearError();
  notifyListeners();
  }

  void clearMidpoint() {
    _midpoint = null;
    _clearError();
    notifyListeners();
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
