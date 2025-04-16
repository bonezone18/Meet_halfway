import 'package:flutter/foundation.dart';
import '../models/location_model.dart';
import '../services/location_service.dart';
//import '../constants/api_keys.dart';

class LocationProvider with ChangeNotifier {
  final LocationService _locationService = LocationService();



  
  Location? _locationA;
  Location? _locationB;
  bool _isLoadingA = false;
  bool _isLoadingB = false;
  String _errorMessage = '';

  
  //LocationProvider(this._locationService);
  
  Location? get locationA => _locationA;
  Location? get locationB => _locationB;
  bool get isLoadingA => _isLoadingA;
  bool get isLoadingB => _isLoadingB;
  String get errorMessage => _errorMessage;
  bool get hasError => _errorMessage.isNotEmpty;
  bool get canCalculateMidpoint => _locationA != null && _locationB != null;
  
  void setLocationA(Location location) {
  _locationA = location;
  notifyListeners();
}

void setLocationB(Location location) {
  _locationB = location;
  notifyListeners();
}

  void debugLogLocations() {
  print('Location A: ${_locationA?.address}');
  print('Location B: ${_locationB?.address}');
}

  
  
  
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
  
  void clearLocations() {
    _locationA = null;
    _locationB = null;
    _clearError();
    notifyListeners();
  }
  
  void _setLoadingA(bool loading) {
    _isLoadingA = loading;
    notifyListeners();
  }
  
  void _setLoadingB(bool loading) {
    _isLoadingB = loading;
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
