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

  static const senegal = Country(
    code: 'SN',
    nameEn: 'Senegal',
    nameFr: 'Sénégal',
    dialCode: '+221',
    format: '## ### ## ##',
    nationalNumberLength: 9,
    validationPattern: r'^7\d{8}$',
    flagEmoji: '🇸🇳',
  );

  static const coteDivoire = Country(
    code: 'CI',
    nameEn: 'Ivory Coast',
    nameFr: "Côte d'Ivoire",
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
    validationPattern: r'^6\d{8}$',
    flagEmoji: '🇨🇲',
  );

  static const nigeria = Country(
    code: 'NG',
    nameEn: 'Nigeria',
    nameFr: 'Nigéria',
    dialCode: '+234',
    format: '### ### ####',
    nationalNumberLength: 10,
    validationPattern: r'^[7-9]\d{9}$',
    flagEmoji: '🇳🇬',
  );

  static const ghana = Country(
    code: 'GH',
    nameEn: 'Ghana',
    nameFr: 'Ghana',
    dialCode: '+233',
    format: '## ### ####',
    nationalNumberLength: 9,
    validationPattern: r'^[2-5]\d{8}$',
    flagEmoji: '🇬🇭',
  );

  static const togo = Country(
    code: 'TG',
    nameEn: 'Togo',
    nameFr: 'Togo',
    dialCode: '+228',
    format: '## ## ## ##',
    nationalNumberLength: 8,
    validationPattern: r'^[279]\d{7}$',
    flagEmoji: '🇹🇬',
  );

  static const burkinaFaso = Country(
    code: 'BF',
    nameEn: 'Burkina Faso',
    nameFr: 'Burkina Faso',
    dialCode: '+226',
    format: '## ## ## ##',
    nationalNumberLength: 8,
    validationPattern: r'^[67]\d{7}$',
    flagEmoji: '🇧🇫',
  );

  static const mali = Country(
    code: 'ML',
    nameEn: 'Mali',
    nameFr: 'Mali',
    dialCode: '+223',
    format: '## ## ## ##',
    nationalNumberLength: 8,
    validationPattern: r'^[6-9]\d{7}$',
    flagEmoji: '🇲🇱',
  );

  static const niger = Country(
    code: 'NE',
    nameEn: 'Niger',
    nameFr: 'Niger',
    dialCode: '+227',
    format: '## ## ## ##',
    nationalNumberLength: 8,
    validationPattern: r'^[789]\d{7}$',
    flagEmoji: '🇳🇪',
  );

  static const congo = Country(
    code: 'CG',
    nameEn: 'Republic of the Congo',
    nameFr: 'Congo',
    dialCode: '+242',
    format: '## ### ####',
    nationalNumberLength: 9,
    validationPattern: r'^[56]\d{7}$',
    flagEmoji: '🇨🇬',
  );

  static const drc = Country(
    code: 'CD',
    nameEn: 'Democratic Republic of the Congo',
    nameFr: 'République démocratique du Congo',
    dialCode: '+243',
    format: '### ### ###',
    nationalNumberLength: 9,
    validationPattern: r'^[89]\d{8}$',
    flagEmoji: '🇨🇩',
  );

  static const kenya = Country(
    code: 'KE',
    nameEn: 'Kenya',
    nameFr: 'Kenya',
    dialCode: '+254',
    format: '### ### ###',
    nationalNumberLength: 9,
    validationPattern: r'^[17]\d{8}$',
    flagEmoji: '🇰🇪',
  );

  static const southAfrica = Country(
    code: 'ZA',
    nameEn: 'South Africa',
    nameFr: 'Afrique du Sud',
    dialCode: '+27',
    format: '## ### ####',
    nationalNumberLength: 9,
    validationPattern: r'^[6-8]\d{8}$',
    flagEmoji: '🇿🇦',
  );

  static const tanzania = Country(
    code: 'TZ',
    nameEn: 'Tanzania',
    nameFr: 'Tanzanie',
    dialCode: '+255',
    format: '### ### ###',
    nationalNumberLength: 9,
    validationPattern: r'^[67]\d{8}$',
    flagEmoji: '🇹🇿',
  );

  static const uganda = Country(
    code: 'UG',
    nameEn: 'Uganda',
    nameFr: 'Ouganda',
    dialCode: '+256',
    format: '### ### ###',
    nationalNumberLength: 9,
    validationPattern: r'^[7]\d{8}$',
    flagEmoji: '🇺🇬',
  );

  static const List<Country> all = [
    benin,
    gabon,
    senegal,
    coteDivoire,
    cameroon,
    nigeria,
    ghana,
    togo,
    burkinaFaso,
    mali,
    niger,
    congo,
    drc,
    kenya,
    southAfrica,
    tanzania,
    uganda,
  ];
}
