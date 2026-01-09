import 'package:flutter/material.dart';
import '../models/country.dart';
import 'country_detector.dart';

class LocaleDetector implements CountryDetector {
  /// Locale to use (if null, uses the system locale)
  final Locale? locale;

  LocaleDetector({this.locale});

  @override
  Future<Country?> detectCountry(List<Country> availableCountries) async {
    try {
      // Get the country code from the locale
      final countryCode =
          locale?.countryCode ??
          WidgetsBinding.instance.platformDispatcher.locale.countryCode;

      if (countryCode == null) {
        debugPrint('[LocaleDetector] No country code in the locale');
        return null;
      }

      debugPrint('[LocaleDetector] Detected country code: $countryCode');

      // Find the country in the available list
      final country = _findCountry(countryCode, availableCountries);

      if (country != null) {
        debugPrint('[LocaleDetector] Country found: ${country.nameEn}');
        return country;
      } else {
        debugPrint(
          '[LocaleDetector] Country $countryCode not available in the list',
        );
        return null;
      }
    } catch (e) {
      debugPrint('[LocaleDetector] Error: $e');
      return null;
    }
  }

  /// Finds a country in the list by its code
  Country? _findCountry(String code, List<Country> countries) {
    try {
      return countries.firstWhere(
        (country) => country.code.toUpperCase() == code.toUpperCase(),
      );
    } catch (e) {
      return null;
    }
  }
}
