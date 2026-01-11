import '../models/country.dart';

class PhoneNumber {
  /// Country of the phone number
  final Country country;

  /// National number (without dial code)
  /// Example: "0166640219" for Benin
  final String nationalNumber;

  const PhoneNumber({required this.country, required this.nationalNumber});

  /// Creates an empty PhoneNumber with a default country
  factory PhoneNumber.empty(Country defaultCountry) {
    return PhoneNumber(country: defaultCountry, nationalNumber: '');
  }

  /// Parse an international phone number (e.g. "+2290166640219")
  /// Throws a FormatException if the format is invalid
  factory PhoneNumber.fromInternational(
    String internationalNumber,
    List<Country> availableCountries,
  ) {
    final clean = internationalNumber.replaceAll(RegExp(r'[^\d+]'), '');

    if (!clean.startsWith('+')) {
      throw FormatException('The number must start with +');
    }

    // Find the matching country based on dial code
    final sortedCountries = List<Country>.from(availableCountries)
      ..sort((a, b) => b.dialCode.length.compareTo(a.dialCode.length));

    for (final country in sortedCountries) {
      if (clean.startsWith(country.dialCode)) {
        final nationalNumber = clean.substring(country.dialCode.length);
        return PhoneNumber(country: country, nationalNumber: nationalNumber);
      }
    }

    throw FormatException('No country found for this phone number');
  }

  /// International formatted number
  /// Example: "+2290166640219"
  String get international => country.getInternationalNumber(nationalNumber);

  /// Number formatted according to country rules
  /// Example: "01 66 64 02 19" for Benin
  String get formatted => country.formatNumber(nationalNumber);

  /// Checks whether the number is valid for this country
  bool get isValid => country.isValidNumber(nationalNumber);

  /// Checks whether the number is empty
  bool get isEmpty => nationalNumber.isEmpty;

  /// Checks whether the number is not empty
  bool get isNotEmpty => nationalNumber.isNotEmpty;

  /// Clean number (digits only)
  String get cleanNumber => nationalNumber.replaceAll(RegExp(r'[^\d]'), '');

  PhoneNumber copyWith({Country? country, String? nationalNumber}) {
    return PhoneNumber(
      country: country ?? this.country,
      nationalNumber: nationalNumber ?? this.nationalNumber,
    );
  }

  /// Serialize to Map
  Map<String, dynamic> toJson() {
    return {
      'countryCode': country.code,
      'dialCode': country.dialCode,
      'nationalNumber': nationalNumber,
      'international': international,
    };
  }

  /// Deserialize from Map
  /// Requires the list of available countries to resolve the Country
  factory PhoneNumber.fromJson(
    Map<String, dynamic> json,
    List<Country> availableCountries,
  ) {
    final countryCode = json['countryCode'] as String;
    final country = availableCountries.firstWhere(
      (c) => c.code == countryCode,
      orElse: () => availableCountries.first,
    );

    return PhoneNumber(
      country: country,
      nationalNumber: json['nationalNumber'] as String,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PhoneNumber &&
          runtimeType == other.runtimeType &&
          country == other.country &&
          nationalNumber == other.nationalNumber;

  @override
  int get hashCode => country.hashCode ^ nationalNumber.hashCode;

  @override
  String toString() => international;
}
