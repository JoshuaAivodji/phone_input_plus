import '../../models/country.dart';

class AmericanCountries {
  static const usa = Country(
    code: 'US',
    nameEn: 'United States',
    nameFr: 'États-Unis',
    dialCode: '+1',
    format: '(###) ###-####',
    nationalNumberLength: 10,
    validationPattern: r'^[2-9]\d{2}[2-9]\d{6}$',
    flagEmoji: '🇺🇸',
  );

  static const canada = Country(
    code: 'CA',
    nameEn: 'Canada',
    nameFr: 'Canada',
    dialCode: '+1',
    format: '(###) ###-####',
    nationalNumberLength: 10,
    validationPattern: r'^[2-9]\d{2}[2-9]\d{6}$',
    flagEmoji: '🇨🇦',
  );

  static const mexico = Country(
    code: 'MX',
    nameEn: 'Mexico',
    nameFr: 'Mexique',
    dialCode: '+52',
    format: '## #### ####',
    nationalNumberLength: 10,
    validationPattern: r'^[1-9]\d{9}$',
    flagEmoji: '🇲🇽',
  );

  static const brazil = Country(
    code: 'BR',
    nameEn: 'Brazil',
    nameFr: 'Brésil',
    dialCode: '+55',
    format: '## ##### ####',
    nationalNumberLength: 11,
    validationPattern: r'^[1-9]\d{10}$',
    flagEmoji: '🇧🇷',
  );

  static const argentina = Country(
    code: 'AR',
    nameEn: 'Argentina',
    nameFr: 'Argentine',
    dialCode: '+54',
    format: '## #### ####',
    nationalNumberLength: 10,
    validationPattern: r'^[1-9]\d{9}$',
    flagEmoji: '🇦🇷',
  );

  static const chile = Country(
    code: 'CL',
    nameEn: 'Chile',
    nameFr: 'Chili',
    dialCode: '+56',
    format: '# #### ####',
    nationalNumberLength: 9,
    validationPattern: r'^[2-9]\d{8}$',
    flagEmoji: '🇨🇱',
  );

  static const colombia = Country(
    code: 'CO',
    nameEn: 'Colombia',
    nameFr: 'Colombie',
    dialCode: '+57',
    format: '### #######',
    nationalNumberLength: 10,
    validationPattern: r'^[1-9]\d{9}$',
    flagEmoji: '🇨🇴',
  );

  static const peru = Country(
    code: 'PE',
    nameEn: 'Peru',
    nameFr: 'Pérou',
    dialCode: '+51',
    format: '### ### ###',
    nationalNumberLength: 9,
    validationPattern: r'^[1-9]\d{8}$',
    flagEmoji: '🇵🇪',
  );

  static const venezuela = Country(
    code: 'VE',
    nameEn: 'Venezuela',
    nameFr: 'Venezuela',
    dialCode: '+58',
    format: '### ### ####',
    nationalNumberLength: 10,
    validationPattern: r'^[2-9]\d{9}$',
    flagEmoji: '🇻🇪',
  );

  static const dominicanRepublic = Country(
    code: 'DO',
    nameEn: 'Dominican Republic',
    nameFr: 'République dominicaine',
    dialCode: '+1',
    format: '### ### ####',
    nationalNumberLength: 10,
    validationPattern: r'^[2-9]\d{2}[2-9]\d{6}$',
    flagEmoji: '🇩🇴',
  );

  static const List<Country> all = [
    usa,
    canada,
    mexico,
    brazil,
    argentina,
    chile,
    colombia,
    peru,
    venezuela,
    dominicanRepublic,
  ];
}
