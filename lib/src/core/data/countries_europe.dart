import '../../models/country.dart';

class EuropeanCountries {
  static const france = Country(
    code: 'FR',
    nameEn: 'France',
    nameFr: 'France',
    dialCode: '+33',
    format: '# ## ## ## ##',
    nationalNumberLength: 9,
    validationPattern: r'^[1-9]\d{8}$',
    flagEmoji: '🇫🇷',
  );

  static const belgium = Country(
    code: 'BE',
    nameEn: 'Belgium',
    nameFr: 'Belgique',
    dialCode: '+32',
    format: '### ## ## ##',
    nationalNumberLength: 9,
    validationPattern: r'^[1-9]\d{8}$',
    flagEmoji: '🇧🇪',
  );

  static const switzerland = Country(
    code: 'CH',
    nameEn: 'Switzerland',
    nameFr: 'Suisse',
    dialCode: '+41',
    format: '## ### ## ##',
    nationalNumberLength: 9,
    validationPattern: r'^[1-9]\d{8}$',
    flagEmoji: '🇨🇭',
  );

  static const germany = Country(
    code: 'DE',
    nameEn: 'Germany',
    nameFr: 'Allemagne',
    dialCode: '+49',
    format: '#### ########',
    nationalNumberLength: 10,
    validationPattern: r'^[1-9]\d{9,10}$',
    flagEmoji: '🇩🇪',
  );

  static const italy = Country(
    code: 'IT',
    nameEn: 'Italy',
    nameFr: 'Italie',
    dialCode: '+39',
    format: '### #### ###',
    nationalNumberLength: 10,
    validationPattern: r'^[0-9]{9,10}$',
    flagEmoji: '🇮🇹',
  );

  static const spain = Country(
    code: 'ES',
    nameEn: 'Spain',
    nameFr: 'Espagne',
    dialCode: '+34',
    format: '### ### ###',
    nationalNumberLength: 9,
    validationPattern: r'^[6-9]\d{8}$',
    flagEmoji: '🇪🇸',
  );

  static const portugal = Country(
    code: 'PT',
    nameEn: 'Portugal',
    nameFr: 'Portugal',
    dialCode: '+351',
    format: '### ### ###',
    nationalNumberLength: 9,
    validationPattern: r'^[29]\d{8}$',
    flagEmoji: '🇵🇹',
  );

  static const netherlands = Country(
    code: 'NL',
    nameEn: 'Netherlands',
    nameFr: 'Pays-Bas',
    dialCode: '+31',
    format: '# ########',
    nationalNumberLength: 9,
    validationPattern: r'^[1-9]\d{8}$',
    flagEmoji: '🇳🇱',
  );

  static const unitedKingdom = Country(
    code: 'GB',
    nameEn: 'United Kingdom',
    nameFr: 'Royaume-Uni',
    dialCode: '+44',
    format: '#### ######',
    nationalNumberLength: 10,
    validationPattern: r'^[1-9]\d{9,10}$',
    flagEmoji: '🇬🇧',
  );

  static const ireland = Country(
    code: 'IE',
    nameEn: 'Ireland',
    nameFr: 'Irlande',
    dialCode: '+353',
    format: '## ### ####',
    nationalNumberLength: 9,
    validationPattern: r'^[1-9]\d{8}$',
    flagEmoji: '🇮🇪',
  );

  static const List<Country> all = [
    france,
    belgium,
    switzerland,
    germany,
    italy,
    spain,
    portugal,
    netherlands,
    unitedKingdom,
    ireland,
  ];
}
