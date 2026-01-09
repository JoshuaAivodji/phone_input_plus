import 'package:flutter_test/flutter_test.dart';
import 'package:phone_input_plus/src/models/country.dart';

void main() {
  group('Country Model - Bénin', () {
    const benin = Country(
      code: 'BJ',
      nameEn: 'Benin',
      nameFr: 'Bénin',
      dialCode: '+229',
      format: '## ## ## ## ##',
      nationalNumberLength: 10,
      validationPattern: r'^01\d{8}$',
      flagEmoji: '🇧🇯',
    );

    test('Devrait formater correctement un numéro béninois', () {
      expect(benin.formatNumber('0166640219'), '01 66 64 02 19');
    });

    test('Devrait valider un numéro béninois correct', () {
      expect(benin.isValidNumber('0166640219'), true);
      expect(benin.isValidNumber('0123456789'), true);
    });

    test('Devrait rejeter un numéro qui ne commence pas par 01', () {
      expect(benin.isValidNumber('0266640219'), false);
      expect(benin.isValidNumber('9166640219'), false);
    });

    test('Devrait rejeter un numéro de mauvaise longueur', () {
      expect(benin.isValidNumber('016664021'), false);
      expect(benin.isValidNumber('01666402199'), false);
    });

    test('Devrait retourner le numéro international', () {
      expect(benin.getInternationalNumber('0166640219'), '+2290166640219');
    });

    test('Devrait retourner le nom selon la locale', () {
      expect(benin.getName('en'), 'Benin');
      expect(benin.getName('fr'), 'Bénin');
      expect(benin.getName(), 'Benin');
    });
  });
}
