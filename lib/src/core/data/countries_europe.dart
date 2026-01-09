import '../../models/country.dart';

class EuropeanCountries {
  static const france = Country(
    code: 'FR',
    nameEn: 'France',
    nameFr: 'France',
    dialCode: '+33',
    format: '## ## ## ## ##',
    nationalNumberLength: 9,
    validationPattern: r'^[1-9]\d{8}$',
    flagEmoji: '🇫🇷',
  );

  static const List<Country> all = [
    france,
    // TODO: Ajouter plus de pays européens
  ];
}
