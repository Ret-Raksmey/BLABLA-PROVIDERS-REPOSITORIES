import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../model/ride/ride_filter.dart';
import '../../../provider/async_value.dart';
import '../../../provider/rides_preferences_provider.dart';
import '../../widgets/errors/bla_error_screen.dart';
import 'widgets/ride_pref_bar.dart';

import '../../../model/ride/ride.dart';
import '../../../model/ride/ride_pref.dart';
import '../../../service/rides_service.dart';
import '../../theme/theme.dart';
import '../../../utils/animations_util.dart';
import 'widgets/ride_pref_modal.dart';
import 'widgets/rides_tile.dart';

///
///  The Ride Selection screen allow user to select a ride, once ride preferences have been defined.
///  The screen also allow user to re-define the ride preferences and to activate some filters.
///
class RidesScreen extends StatefulWidget {
  const RidesScreen({super.key});

  @override
  State<RidesScreen> createState() => _RidesScreenState();
}

class _RidesScreenState extends State<RidesScreen> {
  RideFilter currentFilter = RideFilter();

  List<Ride> getMatchingRides(RidePreference preference) {
    return RidesService.instance.getRidesFor(preference, currentFilter);
  }

  void onBackPressed() {
    // Back to the previous view
    Navigator.of(context).pop();
  }

  void onPreferencePressed() async {
    // Watch the RidesPreferencesProvider
    final provider = Provider.of<RidesPreferencesProvider>(context, listen: false);
    
    // Open a modal to edit the ride preferences
    RidePreference? newPreference = await Navigator.of(
      context,
    ).push<RidePreference>(
      AnimationUtils.createTopToBottomRoute(
        RidePrefModal(initialPreference: provider.currentPreference),
      ),
    );

    if (newPreference != null) {
      // Update the current preference
      provider.setCurrentPreference(newPreference);
    }
  }

  void onFilterPressed() {
    // Filter functionality would go here
  }

  @override
  Widget build(BuildContext context) {
    // Watch the RidesPreferencesProvider for changes
    return Consumer<RidesPreferencesProvider>(
      builder: (context, provider, child) {
        // Get current preference from provider
        final currentPreference = provider.currentPreference;
        
        // Handle case when no preference is set
        if (currentPreference == null) {
          return Scaffold(
            body: Center(
              child: Text('No ride preference selected'),
            ),
          );
        }
        
        // Handle AsyncValue states
        return provider.pastPreferences.when(
          loading: () {
            return Scaffold(
              body: Center(
                child: BlaError(message: 'Loading...'),
              ),
            );
          },
          error: (error) {
            return Scaffold(
              body: Center(
                child: BlaError(message: 'No connection. Try later.'),
              ),
            );
          },
          success: (pastPreferences) {
            // Get matching rides
            final matchingRides = getMatchingRides(currentPreference);

            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.only(
                  left: BlaSpacings.m,
                  right: BlaSpacings.m,
                  top: BlaSpacings.s,
                ),
                child: Column(
                  children: [
                    // Top search Search bar
                    RidePrefBar(
                      ridePreference: currentPreference,
                      onBackPressed: onBackPressed,
                      onPreferencePressed: onPreferencePressed,
                      onFilterPressed: onFilterPressed,
                    ),

                    Expanded(
                      child: ListView.builder(
                        itemCount: matchingRides.length,
                        itemBuilder: (ctx, index) =>
                            RideTile(ride: matchingRides[index], onPressed: () {}),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }
    );
  }
}