import '../models/country.dart';
import 'data/countries_africa.dart';
import 'data/countries_europe.dart';
import 'data/countries_americas.dart';

class CountryData {
  CountryData._();

  // AFRICA
  static const Country benin = AfricanCountries.benin;
  static const Country burkinaFaso = AfricanCountries.burkinaFaso;
  static const Country ivoryCoast = AfricanCountries.ivoryCoast;
  static const Country capeVerde = AfricanCountries.capeVerde;
  static const Country gambia = AfricanCountries.gambia;
  static const Country ghana = AfricanCountries.ghana;
  static const Country guinea = AfricanCountries.guinea;
  static const Country guineaBissau = AfricanCountries.guineabissau;
  static const Country liberia = AfricanCountries.liberia;
  static const Country mali = AfricanCountries.mali;
  static const Country mauritania = AfricanCountries.mauritania;
  static const Country niger = AfricanCountries.niger;
  static const Country nigeria = AfricanCountries.nigeria;
  static const Country senegal = AfricanCountries.senegal;
  static const Country sierraLeone = AfricanCountries.sierraLeone;
  static const Country togo = AfricanCountries.togo;
  static const Country cameroon = AfricanCountries.cameroon;
  static const Country centralAfricanRepublic =
      AfricanCountries.centralAfricanRepublic;
  static const Country chad = AfricanCountries.chad;
  static const Country republicOfTheCongo = AfricanCountries.republicOfTheCongo;
  static const Country democraticRepublicOfTheCongo =
      AfricanCountries.democraticRepublicOfTheCongo;
  static const Country gabon = AfricanCountries.gabon;
  static const Country equatorialGuinea = AfricanCountries.equatorialGuinea;
  static const Country saoTomeAndPrincipe = AfricanCountries.saoTomeAndPrincipe;
  static const Country burundi = AfricanCountries.burundi;
  static const Country djibouti = AfricanCountries.djibouti;
  static const Country eritrea = AfricanCountries.eritrea;
  static const Country ethiopia = AfricanCountries.ethiopia;
  static const Country kenya = AfricanCountries.kenya;
  static const Country rwanda = AfricanCountries.rwanda;
  static const Country somalia = AfricanCountries.somalia;
  static const Country southSudan = AfricanCountries.southSudan;
  static const Country tanzania = AfricanCountries.tanzania;
  static const Country uganda = AfricanCountries.uganda;
  static const Country seychelles = AfricanCountries.seychelles;
  static const Country angola = AfricanCountries.angola;
  static const Country botswana = AfricanCountries.botswana;
  static const Country lesotho = AfricanCountries.lesotho;
  static const Country malawi = AfricanCountries.malawi;
  static const Country mozambique = AfricanCountries.mozambique;
  static const Country namibia = AfricanCountries.namibia;
  static const Country southAfrica = AfricanCountries.southAfrica;
  static const Country eswatini = AfricanCountries.eswatini;
  static const Country zambia = AfricanCountries.zambia;
  static const Country zimbabwe = AfricanCountries.zimbabwe;
  static const Country algeria = AfricanCountries.algeria;
  static const Country egypt = AfricanCountries.egypt;
  static const Country libya = AfricanCountries.libya;
  static const Country morocco = AfricanCountries.morocco;
  static const Country tunisia = AfricanCountries.tunisia;
  static const Country sudan = AfricanCountries.sudan;
  static const Country comoros = AfricanCountries.comoros;

  // EUROPE
  static const Country france = EuropeanCountries.france;

  // AMERICAS
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

  /// African countries + France/USA (Common preset)
  static List<Country> get africanPlusMajor => [
    ...africanCountries,
    france,
    usa,
  ];
}
