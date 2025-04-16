import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/location_provider.dart';
import '../providers/midpoint_provider.dart';
import '../services/location_service.dart';
import '../widgets/location_input_widget.dart';
import 'results_screen.dart';

class HomeScreen extends StatelessWidget {
  final LocationService locationService;

  const HomeScreen({
    Key? key,
    required this.locationService,
  });

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meeting Point Finder'),
        backgroundColor: const Color(0xFF4285F4), // Google Maps Blue
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF4285F4), Color(0xFFFFFFFF)],
            stops: [0.0, 0.3],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Location A input (top)
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: LocationInputWidget(
                isLocationA: true,
                placeholder: 'Your Location',
                locationService: locationService,
              ),
            ),
            
            // Meet Halfway button (middle)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32.0),
              child: ElevatedButton(
                onPressed: locationProvider.canCalculateMidpoint
    ? () {
        Future.microtask(() async {
          final midpointProvider = Provider.of<MidpointProvider>(context, listen: false);

          await midpointProvider.calculateMidpoint(
            locationProvider.locationA!,
            locationProvider.locationB!,
          );

          if (!context.mounted) return;

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ResultsScreen()),
          );
        });
      }
    : null,
 // Disabled if locations aren't set
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF34A853), // Google Maps Green
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 48.0,
                    vertical: 16.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  elevation: 5,
                ),
                child: const Text(
                  'MEET HALFWAY',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            
            // Location B input (bottom)
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: LocationInputWidget(
                isLocationA: false,
                placeholder: 'Friend\'s Location',
                locationService: locationService,
              ),
            ),
            
            // Error message display
            if (locationProvider.hasError)
              Container(
                margin: const EdgeInsets.all(16.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  locationProvider.errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
              
            // Loading indicators
            if (locationProvider.isLoadingA || locationProvider.isLoadingB)
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
