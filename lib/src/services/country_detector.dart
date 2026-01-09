import '../models/country.dart';

abstract class CountryDetector {
  /// Detects the user's country
  /// Returns null if detection fails
  Future<Country?> detectCountry(List<Country> availableCountries);
}
