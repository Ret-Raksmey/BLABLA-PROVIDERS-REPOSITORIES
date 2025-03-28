// lib/data/dto/ride_preference_dto.dart
class RidePreferenceDTO {
  final String departureLocationName;
  final String departureCountry;
  final String arrivalLocationName;
  final String arrivalCountry;
  final DateTime departureDate;
  final int requestedSeats;

  RidePreferenceDTO({
    required this.departureLocationName,
    required this.departureCountry,
    required this.departureDate,
    required this.arrivalLocationName,
    required this.arrivalCountry,
    required this.requestedSeats,
  });

  // Conversion methods between DTO and domain model
  // ...
}