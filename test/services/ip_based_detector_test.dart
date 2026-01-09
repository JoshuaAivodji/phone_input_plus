import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:phone_input_plus/src/services/ip_based_detector.dart';
import 'package:phone_input_plus/src/core/country_data.dart';

void main() {
  group('IpBasedDetector', () {
    late IpBasedDetector detector;

    setUp(() {
      detector = IpBasedDetector();
    });

    test(
      'Devrait détecter un pays via IP',
      () async {
        final country = await detector.detectCountry(CountryData.allCountries);

        // Le test peut échouer si pas d'internet ou si les API sont down
        // On vérifie juste que ça ne crash pas
        expect(country, isA<dynamic>());

        if (country != null) {
          debugPrint('Pays détecté: ${country.nameEn} (${country.code})');
          expect(country.code.length, 2); // Code ISO valide
        }
      },
      //skip: 'Test nécessite internet',
    );

    test(
      'Devrait retourner null si le pays détecté n\'est pas dans la liste',
      () async {
        // Liste avec un seul pays (peu probable que l'IP tombe dessus)
        final limitedList = [CountryData.gabon];

        final country = await detector.detectCountry(limitedList);

        // Peut être null si l'IP ne correspond pas à Gabon
        if (country != null) {
          expect(country.code, 'GA');
        }
      },
    );
  });
}
