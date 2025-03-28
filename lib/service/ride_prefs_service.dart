import '../model/ride/ride_pref.dart';
import '../repository/ride_preferences_repository.dart';

// DEPRECATED: This service is replaced by RidesPreferencesProvider
// This file exists to avoid dependency issues during transition
@Deprecated('Use RidesPreferencesProvider instead')
class RidePrefService {
  // Static private instance
  static RidePrefService? _instance;

  // Access to past preferences
  final RidePreferencesRepository repository;

  // The current preference
  RidePreference? _currentPreference;

  ///
  /// Private constructor
  ///
  RidePrefService._internal(this.repository);

  ///
  /// Initialize
  ///
  @Deprecated('Use RidesPreferencesProvider instead')
  static void initialize(RidePreferencesRepository repository) {
    if (_instance == null) {
      print('WARNING: RidePrefService is deprecated. Use RidesPreferencesProvider instead.');
      _instance = RidePrefService._internal(repository);
    } else {
      throw Exception("RidePreferencesService is already initialized.");
    }
  }

  ///
  /// Singleton accessor
  ///
  @Deprecated('Use RidesPreferencesProvider instead')
  static RidePrefService get instance {
    if (_instance == null) {
      throw Exception(
          "RidePreferencesService is not initialized. Call initialize() first.");
    }
    print('WARNING: Using deprecated RidePrefService. Use RidesPreferencesProvider instead.');
    return _instance!;
  }

  // Current preference
  @Deprecated('Use RidesPreferencesProvider.currentPreference instead')
  RidePreference? get currentPreference {
    return _currentPreference;
  }

  @Deprecated('Use RidesPreferencesProvider.setCurrentPreference instead')
  void setCurrentPreference(RidePreference preference) {
    _currentPreference = preference;
  }

  // Past preferences
  @Deprecated('Use RidesPreferencesProvider.preferencesHistory instead')
  Future<List<RidePreference>> getPastPreferences() {
    return repository.getPastPreferences();
  }

  @Deprecated('Use RidesPreferencesProvider methods instead')
  Future<void> addPreference(RidePreference preference) {
    return repository.addPreference(preference);
  }
}