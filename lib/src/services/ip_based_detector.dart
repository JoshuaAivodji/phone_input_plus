import 'package:flutter/foundation.dart';
import '../models/country.dart';
import 'country_detector.dart';
import 'providers/ip_api_provider.dart';
import 'providers/providers_list.dart';

class IpBasedDetector implements CountryDetector {
  final List<IpApiProvider> providers;

  IpBasedDetector({List<IpApiProvider>? providers})
    : providers = providers ?? DefaultProviders.all;

  @override
  Future<Country?> detectCountry(List<Country> availableCountries) async {
    // Try each provider until one succeeds
    for (final provider in providers) {
      try {
        debugPrint('[IpBasedDetector] Attempting with ${provider.name}...');

        final countryCode = await provider.fetchCountryCode();

        if (countryCode != null) {
          debugPrint('[IpBasedDetector] Detected country code: $countryCode');

          // Find the country in the available list
          final country = _findCountry(countryCode, availableCountries);

          if (country != null) {
            debugPrint('[IpBasedDetector] Country found: ${country.nameEn}');
            return country;
          } else {
            debugPrint(
              '[IpBasedDetector] Country $countryCode not available in the list',
            );
          }
        }
      } catch (e) {
        debugPrint('[IpBasedDetector] Error with ${provider.name}: $e');
        continue; // Try the next provider
      }
    }

    debugPrint('[IpBasedDetector] All providers failed');
    return null;
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
