// midpoint_provider.dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/location_model.dart';
import '../services/midpoint_calculator.dart';

/// Manages the state for the calculated midpoint between two locations.
///
/// This provider handles the midpoint calculation, loading states, and error handling.
/// It provides methods for calculating both geographic and weighted midpoints,
/// as well as calculating distances between locations.
class MidpointProvider with ChangeNotifier {
  Location? _midpoint;
  Location? _locationA;
  Location? _locationB;
  bool _isLoading = false;
  String _errorMessage = '';

  /// The calculated midpoint location
  Location? get midpoint => _midpoint;

  /// The two user-provided input locations
  Location? get locationA => _locationA;
  Location? get locationB => _locationB;

  /// Whether a calculation is currently in progress
  bool get isLoading => _isLoading;

  /// Current error message, if any
  String get errorMessage => _errorMessage;

  /// Whether there is an active error
  bool get hasError => _errorMessage.isNotEmpty;

  /// The distance from location A to the midpoint (in miles)
  double get distanceFromA =>
      (_midpoint != null && _locationA != null) ? _locationA!.distanceTo(_midpoint!) * 0.621371 : 0;

  /// The distance from location B to the midpoint (in miles)
  double get distanceFromB =>
      (_midpoint != null && _locationB != null) ? _locationB!.distanceTo(_midpoint!) * 0.621371 : 0;

  /// The absolute difference in distance between A and B to midpoint (in miles)
  double get midpointFairnessDelta =>
      (distanceFromA - distanceFromB).abs();

  /// A textual label indicating how fair the midpoint is
  String get midpointFairnessLabel {
    if (_locationA == null || _locationB == null || _midpoint == null) {
      return 'Unknown';
    }
    final delta = midpointFairnessDelta;
    if (delta < 1.0) return 'Perfectly Fair';
    if (delta < 3.0) return 'Moderately Fair';
    return 'Unbalanced';
  }

  /// Returns a styled card widget summarizing the trip fairness and distances.
  Widget buildTripSummaryCard() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Trip Summary',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.person_pin_circle, color: Colors.blue),
                const SizedBox(width: 8),
                Text('From You: ${distanceFromA.toStringAsFixed(1)} mi'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.person_pin_circle_outlined, color: Colors.green),
                const SizedBox(width: 8),
                Text('From Friend: ${distanceFromB.toStringAsFixed(1)} mi'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.balance, color: _getFairnessColor(), size: 20),
                const SizedBox(width: 8),
                Text('Fairness: $midpointFairnessLabel',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: _getFairnessColor(),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Internal color helper based on fairness delta
  Color _getFairnessColor() {
    if (midpointFairnessDelta < 1.0) return Colors.green;
    if (midpointFairnessDelta < 3.0) return Colors.orange;
    return Colors.red;
  }

  /// Calculates the geographic midpoint between two locations.
  Future<void> calculateMidpoint(Location a, Location b) async {
    _setLoading(true);
    _clearError();

    try {
      await Future.delayed(const Duration(milliseconds: 500));
      _midpoint = MidpointCalculator.calculateGeographicMidpoint(a, b);
      _locationA = a;
      _locationB = b;
      notifyListeners();
    } catch (e) {
      _setError('Failed to calculate midpoint: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  /// Calculates a weighted midpoint between two locations.
  Future<void> calculateWeightedMidpoint(Location a, Location b, double weightA, double weightB) async {
    _setLoading(true);
    _clearError();
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      _midpoint = MidpointCalculator.calculateWeightedMidpoint(a, b, weightA, weightB);
      _locationA = a;
      _locationB = b;
      notifyListeners();
    } catch (e) {
      _setError('Failed to calculate weighted midpoint: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  /// Calculates the distance between two locations in kilometers.
  double calculateDistance(Location a, Location b) {
    return MidpointCalculator.calculateDistance(a, b);
  }

  /// Sets the midpoint directly to the provided location.
  void setMidpoint(Location midpoint) {
    _midpoint = midpoint;
    _clearError();
    notifyListeners();
  }

  /// Clears all location and midpoint data.
  void clearMidpoint() {
    _midpoint = null;
    _locationA = null;
    _locationB = null;
    _clearError();
    notifyListeners();
  }

  /// Sets the loading state and notifies listeners.
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// Sets an error message and notifies listeners.
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
