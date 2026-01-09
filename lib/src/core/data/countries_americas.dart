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

  static const List<Country> all = [
    usa,
    canada,
    // TODO: Ajouter plus de pays des Amériques
  ];
}
