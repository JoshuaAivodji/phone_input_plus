import 'package:flutter/services.dart';
import 'package:phone_input_plus/phone_input_plus.dart';

class PhoneLengthInputFormatter extends TextInputFormatter {
  Country country;

  PhoneLengthInputFormatter(this.country);

  /// Update the country when it changes
  void updateCountry(Country newCountry) {
    country = newCountry;
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;

    // IF THE TEXT STARTS WITH +, DO NOT LIMIT
    // (this is an international paste, detection will handle it)
    if (text.startsWith('+')) {
      return newValue;
    }

    // Clean the text (count digits only)
    final cleanText = text.replaceAll(RegExp(r'[^\d]'), '');

    // If the number of digits exceeds the limit
    if (cleanText.length > country.nationalNumberLength) {
      // Return the old value (prevents further input)
      return oldValue;
    }

    // Otherwise, accept the new value as-is (with formatting)
    return newValue;
  }
}
