import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/location_service.dart';
import '../providers/location_provider.dart';
import '../providers/midpoint_provider.dart';
import '../screens/results_screen.dart';
import '../widgets/location_input_widget.dart';

/// The main screen of the application where users input locations.
///
/// This screen allows users to:
/// - Input their own location
/// - Input their friend's location
/// - Calculate the midpoint between these locations
/// - Navigate to the results screen to see meeting point suggestions
class HomeScreen extends StatelessWidget {
  /// Service for location-related operations
  final LocationService locationService;

  /// Creates a new HomeScreen instance.
  ///
  /// @param key Widget key for identification
  /// @param locationService Required service for location operations
  const HomeScreen({super.key, required this.locationService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meeting Point Finder')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LocationInputWidget(
            isLocationA: true,
            placeholder: 'Your location',
            locationService: locationService,
          ),
          LocationInputWidget(
            isLocationA: false,
            placeholder: "Friend's location",
            locationService: locationService,
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              onPressed: () async {
                final locationProvider = Provider.of<LocationProvider>(context, listen: false);
                final midpointProvider = Provider.of<MidpointProvider>(context, listen: false);

                final locA = locationProvider.locationA;
                final locB = locationProvider.locationB;

                if (locA != null && locB != null) {
                  // Safely defer state changes until after build is complete
                  WidgetsBinding.instance.addPostFrameCallback((_) async {
                    // Calculate and store the midpoint using provider
                    await midpointProvider.calculateMidpoint(locA, locB);

                    // Navigate to the results screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ResultsScreen(),
                      ),
                    );
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please set both locations.')),
                );
                }
              },
              child: const Text('Meet Halfway'),
            ),
          ),
        ],
      ),
    );
  }
}
