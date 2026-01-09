import 'package:flutter_test/flutter_test.dart';
import 'package:phone_input_plus/src/controllers/phone_controller.dart';
import 'package:phone_input_plus/src/core/phone_number.dart';
import 'package:phone_input_plus/src/core/country_data.dart';

void main() {
  group('PhoneController', () {
    final benin = CountryData.benin;
    final gabon = CountryData.gabon;
    final france = CountryData.france;

    test('Devrait initialiser avec un pays par défaut', () {
      final controller = PhoneController(initialCountry: benin);

      expect(controller.country, benin);
      expect(controller.isEmpty, true);
      expect(controller.nationalNumber, '');
    });

    test('Devrait initialiser avec un PhoneNumber complet', () {
      final initialPhone = PhoneNumber(
        country: gabon,
        nationalNumber: '07123456',
      );
      final controller = PhoneController(initialValue: initialPhone);

      expect(controller.country, gabon);
      expect(controller.nationalNumber, '07123456');
      expect(controller.isNotEmpty, true);
    });

    test('Devrait throw si aucun paramètre fourni', () {
      expect(() => PhoneController(), throwsArgumentError);
    });

    test('changeCountry devrait changer le pays', () {
      final controller = PhoneController(initialCountry: benin);

      controller.changeCountry(france);

      expect(controller.country, france);
      expect(controller.nationalNumber, '');
    });

    test('updateNumber devrait mettre à jour le numéro', () {
      final controller = PhoneController(initialCountry: benin);

      controller.updateNumber('0166640219');

      expect(controller.nationalNumber, '0166640219');
      expect(controller.country, benin);
    });

    test('setValue devrait définir un PhoneNumber complet', () {
      final controller = PhoneController(initialCountry: benin);

      final newPhone = PhoneNumber(country: gabon, nationalNumber: '07123456');
      controller.setValue(newPhone);

      expect(controller.value, newPhone);
      expect(controller.country, gabon);
      expect(controller.nationalNumber, '07123456');
    });

    test('clear devrait vider le numéro mais garder le pays', () {
      final controller = PhoneController(initialCountry: benin);
      controller.updateNumber('0166640219');

      controller.clear();

      expect(controller.country, benin);
      expect(controller.isEmpty, true);
      expect(controller.nationalNumber, '');
    });

    test('reset devrait réinitialiser avec un nouveau pays', () {
      final controller = PhoneController(initialCountry: benin);
      controller.updateNumber('0166640219');

      controller.reset(france);

      expect(controller.country, france);
      expect(controller.isEmpty, true);
    });

    test('migrateToCountry devrait changer le pays en gardant le numéro', () {
      final controller = PhoneController(initialCountry: benin);
      controller.updateNumber('0166640219');

      controller.migrateToCountry(gabon);

      expect(controller.country, gabon);
      expect(controller.nationalNumber, '0166640219');
      expect(controller.isValid, false);
    });

    test('Getters devraient fonctionner correctement', () {
      final controller = PhoneController(initialCountry: benin);
      controller.updateNumber('0166640219');

      expect(controller.international, '+2290166640219');
      expect(controller.formatted, '01 66 64 02 19');
      expect(controller.isValid, true);
    });

    test('isValid devrait refléter la validation', () {
      final controller = PhoneController(initialCountry: benin);

      expect(controller.isValid, false);

      controller.updateNumber('0166640219');
      expect(controller.isValid, true);

      controller.updateNumber('0266640219');
      expect(controller.isValid, false);
    });

    test('trySetInternational devrait parser et définir le numéro', () {
      final controller = PhoneController(initialCountry: benin);

      final success = controller.trySetInternational(
        '+2290166640219',
        CountryData.allCountries,
      );

      expect(success, true);
      expect(controller.country.code, 'BJ');
      expect(controller.nationalNumber, '0166640219');
    });

    test('trySetInternational devrait retourner false si échec', () {
      final controller = PhoneController(initialCountry: benin);

      final success = controller.trySetInternational(
        '+999123456789',
        CountryData.allCountries,
      );

      expect(success, false);
      expect(controller.country, benin);
      expect(controller.isEmpty, true);
    });

    test('Devrait notifier les listeners lors des changements', () {
      final controller = PhoneController(initialCountry: benin);
      int notificationCount = 0;

      controller.addListener(() {
        notificationCount++;
      });

      controller.updateNumber('0166640219');
      expect(notificationCount, 1);

      controller.changeCountry(gabon);
      expect(notificationCount, 2);

      controller.clear();
      expect(notificationCount, 3);
    });

    test('dispose devrait libérer les ressources', () {
      final controller = PhoneController(initialCountry: benin);

      controller.addListener(() {});

      expect(() => controller.dispose(), returnsNormally);
    });
  });
}
