import 'package:flutter_test/flutter_test.dart';
import 'package:phone_input_plus/src/core/country_data.dart';

void main() {
  group('CountryData', () {
    test('Devrait avoir au moins 8 pays au total', () {
      expect(CountryData.allCountries.length, greaterThanOrEqualTo(8));
    });

    test('Devrait trouver un pays par code', () {
      final gabon = CountryData.getByCode('BJ');
      expect(gabon, isNotNull);
      expect(gabon!.nameEn, 'Benin');
      expect(gabon.dialCode, '+229');
    });

    test('Devrait trouver un pays par dial code', () {
      final benin = CountryData.getByDialCode('+229');
      expect(benin, isNotNull);
      expect(benin!.code, 'BJ');
    });

    test('Devrait rechercher des pays par nom', () {
      final results = CountryData.search('France');
      expect(results.length, 1);
      expect(results.first.code, 'FR');
    });

    test('Devrait rechercher en français', () {
      final results = CountryData.search('Sénégal', locale: 'fr');
      expect(results.isNotEmpty, true);
      expect(results.first.code, 'SN');
    });

    test('Devrait avoir la liste africanPlusMajor', () {
      final list = CountryData.africanPlusMajor;
      expect(list.any((c) => c.code == 'BJ'), true);
      expect(list.any((c) => c.code == 'FR'), true);
      expect(list.any((c) => c.code == 'US'), true);
    });

    test('Les pays africains devraient contenir le Bénin', () {
      expect(CountryData.africanCountries.any((c) => c.code == 'BJ'), true);
    });
  });
}
