import 'package:flutter_test/flutter_test.dart';
import 'package:phone_input_plus/src/core/phone_number.dart';
import 'package:phone_input_plus/src/core/country_data.dart';

void main() {
  group('PhoneNumber', () {
    final benin = CountryData.benin;
    final gabon = CountryData.gabon;

    test('Devrait créer un PhoneNumber valide', () {
      final phone = PhoneNumber(country: benin, nationalNumber: '0166640219');

      expect(phone.country, benin);
      expect(phone.nationalNumber, '0166640219');
    });

    test('Devrait formater correctement le numéro', () {
      final phone = PhoneNumber(country: benin, nationalNumber: '0166640219');

      expect(phone.formatted, '01 66 64 02 19');
      expect(phone.international, '+2290166640219');
    });

    test('Devrait valider correctement un numéro béninois', () {
      final validPhone = PhoneNumber(
        country: benin,
        nationalNumber: '0166640219',
      );
      expect(validPhone.isValid, true);

      final invalidPhone = PhoneNumber(
        country: benin,
        nationalNumber: '0266640219',
      );
      expect(invalidPhone.isValid, false);
    });

    test('Devrait créer un PhoneNumber vide', () {
      final empty = PhoneNumber.empty(gabon);

      expect(empty.isEmpty, true);
      expect(empty.isNotEmpty, false);
      expect(empty.nationalNumber, '');
      expect(empty.country, gabon);
    });

    test('Devrait parser un numéro international', () {
      final phone = PhoneNumber.fromInternational(
        '+2290166640219',
        CountryData.allCountries,
      );

      expect(phone.country.code, 'BJ');
      expect(phone.nationalNumber, '0166640219');
    });

    test('Devrait parser avec espaces et caractères spéciaux', () {
      final phone = PhoneNumber.fromInternational(
        '+229 01 66 64 02 19',
        CountryData.allCountries,
      );

      expect(phone.country.code, 'BJ');
      expect(phone.nationalNumber, '0166640219');
    });

    test('Devrait throw si pas de +', () {
      expect(
        () => PhoneNumber.fromInternational(
          '2290166640219',
          CountryData.allCountries,
        ),
        throwsFormatException,
      );
    });

    test('Devrait throw si pays inconnu', () {
      expect(
        () => PhoneNumber.fromInternational(
          '+999123456789',
          CountryData.allCountries,
        ),
        throwsFormatException,
      );
    });

    test('cleanNumber devrait retirer les caractères non-numériques', () {
      final phone = PhoneNumber(
        country: benin,
        nationalNumber: '01 66 64 02 19',
      );

      expect(phone.cleanNumber, '0166640219');
    });
  });
}
