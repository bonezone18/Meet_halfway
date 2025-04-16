import 'package:flutter/foundation.dart';
import '../models/location_model.dart';
import '../services/directions_service.dart';

class DirectionsProvider with ChangeNotifier {
  final DirectionsService _directionsService;
  
  Map<String, dynamic>? _directionsDataA;
  Map<String, dynamic>? _directionsDataB;
  bool _isLoadingA = false;
  bool _isLoadingB = false;
  String _errorMessage = '';
  
  DirectionsProvider(this._directionsService);
  
  Map<String, dynamic>? get directionsDataA => _directionsDataA;
  Map<String, dynamic>? get directionsDataB => _directionsDataB;
  bool get isLoadingA => _isLoadingA;
  bool get isLoadingB => _isLoadingB;
  String get errorMessage => _errorMessage;
  bool get hasError => _errorMessage.isNotEmpty;
  bool get hasDirectionsA => _directionsDataA != null;
  bool get hasDirectionsB => _directionsDataB != null;
  
  // Get directions from location A to meeting place
  Future<void> getDirectionsFromA(
    Location locationA,
    Location destination,
    {String mode = 'driving'}
  ) async {
    _setLoadingA(true);
    _clearError();
    
    try {
      final directionsData = await _directionsService.getTravelTime(
        locationA,
        destination,
        mode: mode,
      );
      
      _directionsDataA = directionsData;
      notifyListeners();
    } catch (e) {
      _setError('Failed to get directions from location A: ${e.toString()}');
    } finally {
      _setLoadingA(false);
    }
  }
  
  // Get directions from location B to meeting place
  Future<void> getDirectionsFromB(
    Location locationB,
    Location destination,
    {String mode = 'driving'}
  ) async {
    _setLoadingB(true);
    _clearError();
    
    try {
      final directionsData = await _directionsService.getTravelTime(
        locationB,
        destination,
        mode: mode,
      );
      
      _directionsDataB = directionsData;
      notifyListeners();
    } catch (e) {
      _setError('Failed to get directions from location B: ${e.toString()}');
    } finally {
      _setLoadingB(false);
    }
  }
  
  // Get Google Maps URL for directions from location A
  String getDirectionsUrlFromA(
    Location locationA,
    Location destination,
    {String mode = 'driving'}
  ) {
    return _directionsService.getDirectionsUrl(
      locationA,
      destination,
      mode: mode,
    );
  }
  
  // Get Google Maps URL for directions from location B
  String getDirectionsUrlFromB(
    Location locationB,
    Location destination,
    {String mode = 'driving'}
  ) {
    return _directionsService.getDirectionsUrl(
      locationB,
      destination,
      mode: mode,
    );
  }
  
  // Get static map image URL
  String getStaticMapUrl(
    Location locationA,
    Location locationB,
    Location meetingPlace,
    {int width = 600, int height = 300}
  ) {
    return _directionsService.getStaticMapUrl(
      locationA,
      locationB,
      meetingPlace,
      width: width,
      height: height,
    );
  }
  
  void clearDirections() {
    _directionsDataA = null;
    _directionsDataB = null;
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
