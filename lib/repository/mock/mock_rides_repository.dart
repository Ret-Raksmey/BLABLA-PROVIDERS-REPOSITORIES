import '../../dummy_data/dummy_data.dart';
import '../../model/ride/ride.dart';
import '../../model/ride/ride_filter.dart';
import '../../model/ride/ride_pref.dart';
import '../../repository/rides_repository.dart';

import '../../model/location/locations.dart';
import '../../model/user/user.dart';

class MockRidesRepository extends RidesRepository {
  final List<RidePreference> _pastPreferences = fakeRidePrefs;

  @override
  Future<List<RidePreference>> getPastPreferences() async {
    // Simulate a network delay of 2 seconds
    await Future.delayed(Duration(seconds: 2));
    return _pastPreferences;
  }

  @override
  Future<void> addPreference(RidePreference preference) async {
    // Simulate a network delay of 2 seconds
    await Future.delayed(Duration(seconds: 2));
    _pastPreferences.add(preference);
  }
  
  @override
  List<Ride> getRidesFor(RidePreference ridePreference, RideFilter? rideFilter) {
    // TODO: implement getRidesFor
    throw UnimplementedError();
  }
}