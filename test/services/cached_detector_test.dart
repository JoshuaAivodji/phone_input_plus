import 'package:flutter_test/flutter_test.dart';
import 'package:phone_input_plus/src/services/cached_detector.dart';
import 'package:phone_input_plus/src/services/locale_detector.dart';
import 'package:phone_input_plus/src/core/country_data.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('CachedDetector', () {
    late CachedDetector detector;
    const testCacheKey = 'test_country_cache';

    setUp(() async {
      // Initialise SharedPreferences en mode test
      SharedPreferences.setMockInitialValues({});

      // Crée un détecteur avec un delegate locale
      detector = CachedDetector(
        delegate: LocaleDetector(locale: const Locale('fr', 'BJ')),
        cacheKey: testCacheKey,
        cacheDurationHours: 24,
      );
    });

    tearDown(() async {
      await detector.clearCache();
    });

    test('Devrait détecter et mettre en cache', () async {
      final country = await detector.detectCountry(CountryData.allCountries);

      expect(country, isNotNull);
      expect(country!.code, 'BJ');

      // Vérifie que le cache est créé
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString(testCacheKey), 'BJ');
      expect(prefs.getInt('${testCacheKey}_time'), isNotNull);
    });

    test('Devrait utiliser le cache valide', () async {
      // Première détection (met en cache)
      final country1 = await detector.detectCountry(CountryData.allCountries);
      expect(country1!.code, 'BJ');

      // Change le delegate (ne devrait pas être appelé grâce au cache)
      detector = CachedDetector(
        delegate: LocaleDetector(locale: const Locale('fr', 'FR')),
        cacheKey: testCacheKey,
        cacheDurationHours: 24,
      );

      // Deuxième détection (devrait venir du cache)
      final country2 = await detector.detectCountry(CountryData.allCountries);
      expect(country2!.code, 'BJ');
    });

    test('Devrait re-détecter si cache expiré', () async {
      final prefs = await SharedPreferences.getInstance();

      // Met un cache expiré
      await prefs.setString(testCacheKey, 'FR');
      await prefs.setInt(
        '${testCacheKey}_time',
        DateTime.now().millisecondsSinceEpoch -
            Duration(hours: 25).inMilliseconds, // Expiré (> 24h)
      );

      // Détection devrait ignorer le cache expiré
      final country = await detector.detectCountry(CountryData.allCountries);

      expect(country, isNotNull);
      expect(country!.code, 'BJ'); // Nouvelle détection, pas FR du cache
    });
  });
}
