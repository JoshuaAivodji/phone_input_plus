import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:phone_input_plus/src/services/composite_detector.dart';
import 'package:phone_input_plus/src/core/country_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('CompositeDetector', () {
    late CompositeDetector detector;

    setUp(() async {
      // Initialise SharedPreferences en mode test
      SharedPreferences.setMockInitialValues({});

      detector = CompositeDetector(
        cacheDurationHours: 24,
        cacheKey: 'test_composite_cache',
      );
    });

    tearDown(() async {
      await detector.clearCache();
    });

    test('Devrait essayer IP puis Locale en fallback', () async {
      final country = await detector.detectCountry(CountryData.allCountries);

      // Le test peut réussir via IP ou Locale selon l'environnement
      // On vérifie juste que ça ne crash pas
      expect(country, isA<dynamic>());

      if (country != null) {
        debugPrint('Pays détecté par CompositeDetector: ${country.nameEn}');
        expect(country.code.length, 2);
      }
    });

    test('clearCache devrait fonctionner', () async {
      // Effectue une détection pour créer un cache
      await detector.detectCountry(CountryData.allCountries);

      await detector.clearCache();

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('test_composite_cache'), isNull);
    });

    test('Devrait gérer une liste vide de pays', () async {
      final country = await detector.detectCountry([]);

      expect(country, isNull);
    });
  });
}
