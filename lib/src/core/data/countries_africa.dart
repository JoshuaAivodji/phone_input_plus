import '../../models/country.dart';

class AfricanCountries {
  static const benin = Country(
    code: 'BJ',
    nameEn: 'Benin',
    nameFr: 'Bénin',
    dialCode: '+229',
    format: '## ## ## ## ##',
    nationalNumberLength: 10,
    validationPattern: r'^01\d{8}$',
    flagEmoji: '🇧🇯',
  );

  static const gabon = Country(
    code: 'GA',
    nameEn: 'Gabon',
    nameFr: 'Gabon',
    dialCode: '+241',
    format: '## ## ## ##',
    nationalNumberLength: 8,
    validationPattern: r'^0[1-7]\d{6}$',
    flagEmoji: '🇬🇦',
  );

  // Sénégal
  static const senegal = Country(
    code: 'SN',
    nameEn: 'Senegal',
    nameFr: 'Sénégal',
    dialCode: '+221',
    format: '## ### ## ##',
    nationalNumberLength: 9,
    validationPattern: r'^7[0-8]\d{7}$',
    flagEmoji: '🇸🇳',
  );

  static const coteDivoire = Country(
    code: 'CI',
    nameEn: 'Ivory Coast',
    nameFr: 'Côte d\'Ivoire',
    dialCode: '+225',
    format: '## ## ## ## ##',
    nationalNumberLength: 10,
    validationPattern: r'^[0-9]{10}$',
    flagEmoji: '🇨🇮',
  );

  static const cameroon = Country(
    code: 'CM',
    nameEn: 'Cameroon',
    nameFr: 'Cameroun',
    dialCode: '+237',
    format: '# ## ## ## ##',
    nationalNumberLength: 9,
    validationPattern: r'^6[5-9]\d{7}$',
    flagEmoji: '🇨🇲',
  );

  static const List<Country> all = [
    benin,
    gabon,
    senegal,
    coteDivoire,
    cameroon,
    // TODO: Ajouter plus de pays africains
  ];
}
