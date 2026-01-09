import 'package:flutter/foundation.dart';
import '../core/phone_number.dart';
import '../models/country.dart';

class PhoneController extends ValueNotifier<PhoneNumber> {
  PhoneController({Country? initialCountry, PhoneNumber? initialValue})
    : super(
        initialValue ??
            (initialCountry != null
                ? PhoneNumber.empty(initialCountry)
                : throw ArgumentError(
                    'You must provide either initialCountry or initialValue',
                  )),
      );

  /// Currently selected country
  Country get country => value.country;

  /// Current national number
  String get nationalNumber => value.nationalNumber;

  /// International formatted number
  String get international => value.international;

  /// Formatted number based on country rules
  String get formatted => value.formatted;

  /// Is the number valid?
  bool get isValid => value.isValid;

  /// Is the number empty?
  bool get isEmpty => value.isEmpty;

  /// Is the number not empty?
  bool get isNotEmpty => value.isNotEmpty;

  /// Change the country (keeps the current number)
  void changeCountry(Country newCountry) {
    value = value.copyWith(country: newCountry);
  }

  /// Update the national number (keeps the current country)
  void updateNumber(String number) {
    value = value.copyWith(nationalNumber: number);
  }

  /// Set a complete PhoneNumber
  void setValue(PhoneNumber phoneNumber) {
    value = phoneNumber;
  }

  /// Reset the controller (clears the number, keeps the country)
  void clear() {
    value = PhoneNumber.empty(country);
  }

  /// Fully reset with a new country
  void reset(Country newCountry) {
    value = PhoneNumber.empty(newCountry);
  }

  /// Copy the current number to another country
  /// Useful when the user changes country while typing
  void migrateToCountry(Country newCountry) {
    // Keep the current number, only change the country
    value = PhoneNumber(country: newCountry, nationalNumber: nationalNumber);
  }

  /// Parse and set an international number
  /// Returns true if parsing was successful
  bool trySetInternational(
    String internationalNumber,
    List<Country> availableCountries,
  ) {
    try {
      final phone = PhoneNumber.fromInternational(
        internationalNumber,
        availableCountries,
      );
      value = phone;
      return true;
    } catch (e) {
      debugPrint('Error while parsing international phone number: $e');
      return false;
    }
  }

  /// Returns the current PhoneNumber as JSON
  Map<String, dynamic> toJson() => value.toJson();

  @override
  String toString() => value.toString();
}
