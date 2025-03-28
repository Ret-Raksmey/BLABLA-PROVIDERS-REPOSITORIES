import 'package:flutter/foundation.dart';
import '../model/ride/ride_pref.dart';
import '../repository/ride_preferences_repository.dart';
import 'async_value.dart';

class RidesPreferencesProvider extends ChangeNotifier {
  RidePreference? _currentPreference;
  late AsyncValue<List<RidePreference>> pastPreferences;

  final RidePreferencesRepository repository;

  RidesPreferencesProvider({required this.repository}) {
    // Initialize with loading state
    pastPreferences = AsyncValue.loading();
    // Fetch past preferences
    fetchPastPreferences();
  }

  RidePreference? get currentPreference => _currentPreference;

  Future<void> fetchPastPreferences() async {
    // 1- Handle loading
    pastPreferences = AsyncValue.loading();
    notifyListeners();

    try {
      // 2- Fetch data
      List<RidePreference> pastPrefs = await repository.getPastPreferences();
      
      // 3- Handle success
      pastPreferences = AsyncValue.success(pastPrefs);
    } catch (error) {
      // 4- Handle error
      pastPreferences = AsyncValue.error(error);
    }
    
    notifyListeners();
  }

  void setCurrentPreference(RidePreference pref) {
    // Process only if the new preference is not equal to the current one
    if (_currentPreference != pref) {
      // Update the current preference
      _currentPreference = pref;
      
      // Add to preferences history (using second approach - update cache directly)
      _addPreference(pref);
      
      // Notify listeners
      notifyListeners();
    }
  }

  Future<void> _addPreference(RidePreference preference) async {
    // First approach would be:
    // 1. Call repository.addPreference(preference)
    // 2. Then call fetchPastPreferences() to get fresh data
    
    // Second approach (chosen for better UX):
    // 1. Call repository method
    await repository.addPreference(preference);
    
    // 2. Update the provider cache directly
    if (pastPreferences.isSuccess && pastPreferences.data != null) {
      List<RidePreference> updatedList = List.from(pastPreferences.data!);
      updatedList.add(preference);
      pastPreferences = AsyncValue.success(updatedList);
      notifyListeners();
    }
  }
}