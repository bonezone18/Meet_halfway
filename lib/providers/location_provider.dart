import 'package:flutter/foundation.dart';
import '../models/location_model.dart';
import '../services/location_service.dart';

/// Manages the state for user-selected locations in the application.
///
/// This provider handles the two primary locations (A and B) that users input,
/// along with loading states and error handling. It provides methods for setting
/// locations manually, using the current device location, and clearing selections.
class LocationProvider with ChangeNotifier {
  /// Service for location-related operations
  final LocationService _locationService = LocationService();
  
  /// First location (typically the user's starting point)
  Location? _locationA;
  
  /// Second location (typically the friend's or destination point)
  Location? _locationB;
  
  /// Loading state for location A
  bool _isLoadingA = false;
  
  /// Loading state for location B
  bool _isLoadingB = false;
  
  /// Current error message, if any
  String _errorMessage = '';
  
  /// Getter for location A
  Location? get locationA => _locationA;
  
  /// Getter for location B
  Location? get locationB => _locationB;
  
  /// Whether location A is currently being loaded
  bool get isLoadingA => _isLoadingA;
  
  /// Whether location B is currently being loaded
  bool get isLoadingB => _isLoadingB;
  
  /// Current error message, if any
  String get errorMessage => _errorMessage;
  
  /// Whether there is an active error
  bool get hasError => _errorMessage.isNotEmpty;
  
  /// Whether both locations are set and a midpoint can be calculated
  bool get canCalculateMidpoint => _locationA != null && _locationB != null;
  
  /// Sets location A to the provided location and notifies listeners.
  /// 
  /// @param location The location to set as location A
  void setLocationA(Location location) {
    _locationA = location;
    notifyListeners();
  }

  /// Sets location B to the provided location and notifies listeners.
  /// 
  /// @param location The location to set as location B
  void setLocationB(Location location) {
    _locationB = location;
    notifyListeners();
  }

  /// Logs the current locations to the console for debugging purposes.
  void debugLogLocations() {
    print('Location A: ${_locationA?.address}');
    print('Location B: ${_locationB?.address}');
  }

  /// Uses the device's current location for location A.
  /// 
  /// This method handles the loading state and error handling automatically.
  /// It will set the loading flag, attempt to get the current location,
  /// and update the state accordingly.
  /// 
  /// @return A Future that completes when the operation is done
  Future<void> useCurrentLocationForA() async {
    _setLoadingA(true);
    _clearError();
    
    try {
      final location = await _locationService.getCurrentLocation();
      _locationA = location;
      notifyListeners();
    } catch (e) {
      _setError('Failed to get current location: ${e.toString()}');
    } finally {
      _setLoadingA(false);
    }
  }
  
  /// Uses the device's current location for location B.
  /// 
  /// This method handles the loading state and error handling automatically.
  /// It will set the loading flag, attempt to get the current location,
  /// and update the state accordingly.
  /// 
  /// @return A Future that completes when the operation is done
  Future<void> useCurrentLocationForB() async {
    _setLoadingB(true);
    _clearError();
    
    try {
      final location = await _locationService.getCurrentLocation();
      _locationB = location;
      notifyListeners();
    } catch (e) {
      _setError('Failed to get current location: ${e.toString()}');
    } finally {
      _setLoadingB(false);
    }
  }
  
  /// Clears both locations and any error messages.
  /// 
  /// This method resets the provider to its initial state.
  void clearLocations() {
    _locationA = null;
    _locationB = null;
    _clearError();
    notifyListeners();
  }
  
  /// Sets the loading state for location A and notifies listeners.
  /// 
  /// @param loading The new loading state
  void _setLoadingA(bool loading) {
    _isLoadingA = loading;
    notifyListeners();
  }
  
  /// Sets the loading state for location B and notifies listeners.
  /// 
  /// @param loading The new loading state
  void _setLoadingB(bool loading) {
    _isLoadingB = loading;
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
