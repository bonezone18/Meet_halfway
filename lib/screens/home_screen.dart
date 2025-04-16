import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/location_service.dart';
import '../providers/location_provider.dart';
import '../providers/midpoint_provider.dart';
import '../screens/results_screen.dart';
import '../widgets/location_input_widget.dart';

class HomeScreen extends StatelessWidget {
  final LocationService locationService;

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
