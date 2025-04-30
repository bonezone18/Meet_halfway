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
  const HomeScreen({super.key, required this.locationService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meeting Point Finder')),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      LocationInputWidget(
                        isLocationA: true,
                        placeholder: 'Your location',
                        locationService: locationService,
                      ),
                      const SizedBox(height: 32),

                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            final locationProvider = Provider.of<LocationProvider>(context, listen: false);
                            final midpointProvider = Provider.of<MidpointProvider>(context, listen: false);

                            final locA = locationProvider.locationA;
                            final locB = locationProvider.locationB;

                            if (locA != null && locB != null) {
                              await midpointProvider.calculateMidpoint(locA, locB);
                              if (context.mounted) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => const ResultsScreen()),
                                );
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Please set both locations.')),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(60),
                            backgroundColor: Theme.of(context).primaryColor,
                            elevation: 8,
                          ),
                          child: const Icon(Icons.location_searching, size: 48, color: Colors.white),
                        ),
                      ),

                      const SizedBox(height: 32),

                      LocationInputWidget(
                        isLocationA: false,
                        placeholder: "Friend's location",
                        locationService: locationService,
                      ),

                      const SizedBox(height: 40), // additional padding for autocomplete
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}