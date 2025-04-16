import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'providers/location_provider.dart';
import 'providers/midpoint_provider.dart';
import 'providers/place_provider.dart';
import 'providers/directions_provider.dart';
import 'services/location_service.dart';
import 'services/place_service.dart';
import 'services/directions_service.dart';
import 'constants/api_keys.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locationService = LocationService();
    final directionsService = DirectionsService(googleApiKey);
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
