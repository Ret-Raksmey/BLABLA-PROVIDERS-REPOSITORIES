// lib/data/repository/ride_preferences_repository.dart
import '../../model/ride/ride_pref.dart';

abstract class RidePreferencesRepository {
  Future<List<RidePreference>> getPastPreferences();
  Future<void> addPreference(RidePreference preference);
}