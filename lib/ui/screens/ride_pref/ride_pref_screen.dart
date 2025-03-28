import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/ride/ride_pref.dart';
import '../../../utils/animations_util.dart';
import '../../provider/rides_preferences_provider.dart';
import '../../theme/theme.dart';
import '../../widgets/errors/bla_error_screen.dart';
import '../rides/rides_screen.dart';
import 'widgets/ride_pref_form.dart';
import 'widgets/ride_pref_history_tile.dart';

const String blablaHomeImagePath = 'assets/images/blabla_home.png';

///
/// This screen allows user to:
/// - Enter his/her ride preference and launch a search on it
/// - Or select a last entered ride preferences and launch a search on it
///
class RidePrefScreen extends StatelessWidget {
  const RidePrefScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Watch for changes in the RidesPreferencesProvider
    return Consumer<RidesPreferencesProvider>(
      builder: (context, provider, child) {
        final currentRidePreference = provider.currentPreference;
        
        // Handle the AsyncValue based on its state
        return provider.pastPreferences.when(
          loading: () {
            // Display a loading screen
            return Stack(
              children: [
                const BlaBackground(),
                Center(
                  child: BlaError(message: 'Loading preferences...'),
                ),
              ],
            );
          },
          error: (error) {
            // Display an error screen
            return Stack(
              children: [
                const BlaBackground(),
                Center(
                  child: BlaError(message: 'No connection. Try later.'),
                ),
              ],
            );
          },
          success: (pastPreferences) {
            // Normal screen with preferences
            return Stack(
              children: [
                // 1 - Background Image
                const BlaBackground(),

                // 2 - Foreground content
                Column(
                  children: [
                    SizedBox(height: BlaSpacings.m),
                    Text(
                      "Your pick of rides at low price",
                      style: BlaTextStyles.heading.copyWith(color: Colors.white),
                    ),
                    SizedBox(height: 100),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: BlaSpacings.xxl),
                      decoration: BoxDecoration(
                        color: Colors.white, // White background
                        borderRadius: BorderRadius.circular(16), // Rounded corners
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // 2.1 Display the Form to input the ride preferences
                          RidePrefForm(
                              initialPreference: currentRidePreference,
                              onSubmit: (pref) => onRidePrefSelected(context, pref)),
                          SizedBox(height: BlaSpacings.m),

                          // 2.2 Optionally display a list of past preferences
                          SizedBox(
                            height: 200, // Set a fixed height
                            child: ListView.builder(
                              shrinkWrap: true, // Fix ListView height issue
                              physics: AlwaysScrollableScrollPhysics(),
                              itemCount: pastPreferences.length,
                              itemBuilder: (ctx, index) => RidePrefHistoryTile(
                                ridePref: pastPreferences[index],
                                onPressed: () =>
                                    onRidePrefSelected(context, pastPreferences[index]),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

  void onRidePrefSelected(BuildContext context, RidePreference newPreference) async {
    // 1 - Update the current preference using the Provider
    Provider.of<RidesPreferencesProvider>(context, listen: false)
        .setCurrentPreference(newPreference);

    // 2 - Navigate to the rides screen (with a bottom to top animation)
    await Navigator.of(context)
        .push(AnimationUtils.createBottomToTopRoute(RidesScreen()));
  }
}

class BlaBackground extends StatelessWidget {
  const BlaBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 340,
      child: Image.asset(
        blablaHomeImagePath,
        fit: BoxFit.cover, // Adjust image fit to cover the container
      ),
    );
  }
}