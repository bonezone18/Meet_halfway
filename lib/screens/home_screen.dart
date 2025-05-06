// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // for SystemSound & HapticFeedback
import 'package:provider/provider.dart';

import '../services/location_service.dart';
import '../providers/location_provider.dart';
import '../providers/midpoint_provider.dart';
import '../providers/place_provider.dart';
import '../screens/results_screen.dart';
import '../widgets/location_input_widget.dart';

/// The main screen of the application where users input locations.
class HomeScreen extends StatelessWidget {
  /// Service for location-related operations
  final LocationService locationService;

  /// Creates a new HomeScreen instance.
  const HomeScreen({super.key, required this.locationService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Meeting Point Finder'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  16.0,
                  0.0,
                  16.0,
                  MediaQuery.of(context).viewInsets.bottom + 40,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // YOUR LOCATION
                        LocationInputWidget(
                          isLocationA: true,
                          placeholder: 'Your location',
                          locationService: locationService,
                        ),
                        const SizedBox(height: 32),

                        // CIRCULAR "Meet!" BUTTON
                        Center(
                          child: RawMaterialButton(
                            onPressed: () async {
                              SystemSound.play(SystemSoundType.click);
                              HapticFeedback.lightImpact();

                              final locProv = context.read<LocationProvider>();
                              final midProv = context.read<MidpointProvider>();
                              final placeProv = context.read<PlaceProvider>();
                              final locA = locProv.locationA;
                              final locB = locProv.locationB;

                              if (locA != null && locB != null) {
                                placeProv.resetCategoryFilters();
                                await midProv.calculateMidpoint(locA, locB);
                                if (context.mounted) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const ResultsScreen(),
                                    ),
                                  );
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Please set both locations.'),
                                  ),
                                );
                              }
                            },
                            elevation: 10,
                            fillColor: const Color(0xFF2ECC71), // Emerald
                            shape: const CircleBorder(),
                            constraints: const BoxConstraints.tightFor(
                              width: 120,
                              height: 120,
                            ),
                            child: const Text(
                              'Meet!',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 32),

                        // FRIEND'S LOCATION
                        LocationInputWidget(
                          isLocationA: false,
                          placeholder: "Friend's location",
                          locationService: locationService,
                        ),

                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
