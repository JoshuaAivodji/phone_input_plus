import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/country.dart';
import 'country_detector.dart';

class CachedDetector implements CountryDetector {
  /// Delegated detector (the one that does the actual detection)
  final CountryDetector delegate;

  /// Key for storing the country code
  final String cacheKey;

  /// Cache duration in hours
  final int cacheDurationHours;

  CachedDetector({
    required this.delegate,
    this.cacheKey = 'phone_input_plus_detected_country',
    this.cacheDurationHours = 24,
  });

  @override
  Future<Country?> detectCountry(List<Country> availableCountries) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Check cache
      final cachedCountryCode = prefs.getString(cacheKey);
      final cachedTime = prefs.getInt('${cacheKey}_time');

      if (cachedCountryCode != null && cachedTime != null) {
        // Check if cache is still valid
        final cacheAge = DateTime.now().millisecondsSinceEpoch - cachedTime;
        final maxAge = Duration(hours: cacheDurationHours).inMilliseconds;

        if (cacheAge < maxAge) {
          debugPrint('[CachedDetector] Cache valid: $cachedCountryCode');

          // Find the country in the available list
          final country = _findCountry(cachedCountryCode, availableCountries);

          if (country != null) {
            debugPrint('[CachedDetector] Cached country: ${country.nameEn}');
            return country;
          } else {
            debugPrint(
              '[CachedDetector] Cached country not available, re-detecting...',
            );
          }
        } else {
          debugPrint('[CachedDetector] Cache expired, re-detecting...');
        }
      } else {
        debugPrint('[CachedDetector] No cache, detecting...');
      }

      // Missing/expired/invalid cache, delegate detection
      final country = await delegate.detectCountry(availableCountries);

      // Save in cache if found
      if (country != null) {
        await prefs.setString(cacheKey, country.code);
        await prefs.setInt(
          '${cacheKey}_time',
          DateTime.now().millisecondsSinceEpoch,
        );
        debugPrint('[CachedDetector] Country cached: ${country.code}');
      }

      return country;
    } catch (e) {
      debugPrint('[CachedDetector] Error: $e');
      return null;
    }
  }

  /// Clears the cache
  Future<void> clearCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(cacheKey);
      await prefs.remove('${cacheKey}_time');
      debugPrint('[CachedDetector] Cache cleared');
    } catch (e) {
      debugPrint('[CachedDetector] Error clearing cache: $e');
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
