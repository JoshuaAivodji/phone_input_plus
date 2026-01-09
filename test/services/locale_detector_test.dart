import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:phone_input_plus/src/services/locale_detector.dart';
import 'package:phone_input_plus/src/core/country_data.dart';

void main() {
  group('LocaleDetector', () {
    test('Devrait détecter le pays depuis une locale BJ', () async {
      final detector = LocaleDetector(locale: const Locale('fr', 'BJ'));

      final country = await detector.detectCountry(CountryData.allCountries);

      expect(country, isNotNull);
      expect(country!.code, 'BJ');
      expect(country.nameEn, 'Benin');
    });

    test(
      'Devrait retourner null si le pays n\'est pas dans la liste',
      () async {
        final detector = LocaleDetector(locale: const Locale('en', 'GB'));
        final limitedList = [CountryData.benin, CountryData.gabon];

        final country = await detector.detectCountry(limitedList);

        expect(country, isNull);
      },
    );
  });
}
