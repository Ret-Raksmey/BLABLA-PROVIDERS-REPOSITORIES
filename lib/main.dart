import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ui/provider/rides_preferences_provider.dart';
import 'repository/mock/mock_locations_repository.dart';
import 'repository/mock/mock_ride_preferences_repository.dart';
import 'repository/mock/mock_rides_repository.dart';
import 'service/locations_service.dart';
import 'service/rides_service.dart';
import 'ui/screens/ride_pref/ride_pref_screen.dart';
import 'ui/theme/theme.dart';

void main() {
  // Initialize the services that we still need
  LocationsService.initialize(MockLocationsRepository());
  RidesService.initialize(MockRidesRepository());
  
  // Create repository for the provider
  final ridesPrefsRepository = MockRidePreferencesRepository();

  // Run the UI
  runApp(
    // Create a MultiProvider
    MultiProvider(
      providers: [
        // Create a ChangeNotifierProvider to expose the RidesPreferencesProvider
        ChangeNotifierProvider(
          create: (_) => RidesPreferencesProvider(
            repository: ridesPrefsRepository
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: Scaffold(body: RidePrefScreen()),
    );
  }
}