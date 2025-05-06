import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  print('GOOGLE_MAPS_API_KEY: ${dotenv.env['GOOGLE_MAPS_API_KEY']}');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locationService = LocationService();
    final directionsService = DirectionsService(dotenv.env['GOOGLE_MAPS_API_KEY']!);
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
          colorScheme: ColorScheme.fromSeed(
            seedColor: Color(0xFF2ECC71), // Emerald
            primary: Color(0xFF2980B9),   // Sapphire
            secondary: Color(0xFF9B59B6), // Amethyst
            error: Color(0xFFC0392B),     // Ruby
            surface: Colors.white,
            background: Colors.white,
            brightness: Brightness.light,
          ),
          scaffoldBackgroundColor: Colors.white,
          fontFamily: 'Roboto',
          visualDensity: VisualDensity.adaptivePlatformDensity,
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF2980B9),
            foregroundColor: Colors.white,
            elevation: 4,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF2ECC71),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
              padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
              elevation: 4,
            ),
          ),
          chipTheme: ChipThemeData(
            selectedColor: const Color(0xFF9B59B6).withOpacity(0.85),
            backgroundColor: const Color(0xFF2980B9).withOpacity(0.15),
            disabledColor: Colors.grey[300],
            labelStyle: const TextStyle(color: Colors.white),
            secondarySelectedColor: const Color(0xFF9B59B6).withOpacity(0.85),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            brightness: Brightness.light,
          ),
          cardTheme: CardTheme(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 3,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Colors.white,
            shadowColor: Colors.black12,
          ),
        ),
        home: HomeScreen(locationService: locationService),
      ),
    );
  }
}
