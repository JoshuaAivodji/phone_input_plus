import 'package:flutter/foundation.dart';
import '../models/country.dart';
import 'country_detector.dart';
import 'ip_based_detector.dart';
import 'locale_detector.dart';
import 'cached_detector.dart';

/// Composite detector that tries multiple strategies
/// 1. Cache (if available and valid)
/// 2. IP detection
/// 3. Device locale (fallback)
class CompositeDetector implements CountryDetector {
  final CountryDetector detector;

  CompositeDetector({int cacheDurationHours = 24, String? cacheKey})
    : detector = CachedDetector(
        delegate: _FallbackDetector(),
        cacheDurationHours: cacheDurationHours,
        cacheKey: cacheKey ?? 'phone_input_plus_detected_country',
      );

  @override
  Future<Country?> detectCountry(List<Country> availableCountries) {
    return detector.detectCountry(availableCountries);
  }

  /// Clears the cache (useful to force a new detection)
  Future<void> clearCache() async {
    if (detector is CachedDetector) {
      await (detector as CachedDetector).clearCache();
    }
  }
}

/// Internal detector that tries IP then Locale
class _FallbackDetector implements CountryDetector {
  final IpBasedDetector ipDetector = IpBasedDetector();
  final LocaleDetector localeDetector = LocaleDetector();

  @override
  Future<Country?> detectCountry(List<Country> availableCountries) async {
    // First, try IP detection
    debugPrint('[CompositeDetector] Attempting IP detection...');
    final countryFromIp = await ipDetector.detectCountry(availableCountries);

    if (countryFromIp != null) {
      debugPrint(
        '[CompositeDetector] Country detected via IP: ${countryFromIp.nameEn}',
      );
      return countryFromIp;
    }

    // Fallback to device locale
    debugPrint(
      '[CompositeDetector] IP detection failed, falling back to locale...',
    );
    final countryFromLocale = await localeDetector.detectCountry(
      availableCountries,
    );

    if (countryFromLocale != null) {
      debugPrint(
        '[CompositeDetector] Country detected via locale: ${countryFromLocale.nameEn}',
      );
      return countryFromLocale;
    }

    debugPrint('[CompositeDetector] All detection strategies failed');
    return null;
  }
}
