import '../models/country.dart';
import 'data/countries_africa.dart';
import 'data/countries_europe.dart';
import 'data/countries_americas.dart';

class CountryData {
  CountryData._();

  // Africa
  static const Country benin = AfricanCountries.benin;
  static const Country gabon = AfricanCountries.gabon;
  static const Country senegal = AfricanCountries.senegal;
  static const Country civ = AfricanCountries.coteDivoire;
  static const Country cameroon = AfricanCountries.cameroon;

  // Europe
  static const Country france = EuropeanCountries.france;

  // Americas
  static const Country usa = AmericanCountries.usa;
  static const Country canada = AmericanCountries.canada;

  /// African countries
  static const List<Country> africanCountries = AfricanCountries.all;

  /// European countries
  static const List<Country> europeanCountries = EuropeanCountries.all;

  /// American countries
  static const List<Country> americanCountries = AmericanCountries.all;

  /// All available countries
  static const List<Country> allCountries = [
    ...AfricanCountries.all,
    ...EuropeanCountries.all,
    ...AmericanCountries.all,
  ];

  /// Get a country by its ISO code (e.g. 'FR', 'GA', 'BJ')
  static Country? getByCode(String code) {
    try {
      return allCountries.firstWhere(
        (country) => country.code.toUpperCase() == code.toUpperCase(),
      );
    } catch (e) {
      return null;
    }
  }

  /// Get a country by its dial code (e.g. '+33', '+241')
  static Country? getByDialCode(String dialCode) {
    try {
      return allCountries.firstWhere((country) => country.dialCode == dialCode);
    } catch (e) {
      return null;
    }
  }

  /// Search countries by name (EN or FR)
  static List<Country> search(String query, {String locale = 'en'}) {
    if (query.isEmpty) return allCountries;

    final lowerQuery = query.toLowerCase();

    return allCountries.where((country) {
      final name = country.getName(locale).toLowerCase();
      final code = country.code.toLowerCase();
      final dialCode = country.dialCode;

      return name.contains(lowerQuery) ||
          code.contains(lowerQuery) ||
          dialCode.contains(query);
    }).toList();
  }

  /// African countries + France/USA
  static List<Country> get africanPlusMajor => [
    ...africanCountries,
    france,
    usa,
  ];
}
