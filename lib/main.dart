import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // <-- New import

import 'package:provider/provider.dart';

import 'screens/home_screen.dart';
import 'providers/location_provider.dart';
import 'providers/midpoint_provider.dart';
import 'providers/place_provider.dart';
import 'providers/directions_provider.dart';
import 'services/location_service.dart';
import 'services/place_service.dart';
import 'services/directions_service.dart';

Future<void> main() async {
  // Ensure all bindings are initialized and load .env
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env"); // <-- Load .env before runApp

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locationService = LocationService();
    final directionsService = DirectionsService(dotenv.env['GOOGLE_MAPS_API_KEY']!); // <-- Read from .env
    final placeService = PlaceService();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocationProvider()),
        ChangeNotifierProvider(create: (_) => MidpointProvider()),
        ChangeNotifierProvider(create: (_) => PlaceProvider(placeService)),
        ChangeNotifierProvider(create: (_) => DirectionsProvider(directionsService)),
      ],
      child: MaterialApp(
        title: 'Meeting Point Finder',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Roboto',
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeScreen(locationService: locationService),
      ),
    );
  }
}
