import 'package:flutter/services.dart';

class PhoneNumberTextInputFormatter extends TextInputFormatter {
  final bool allowPlus;

  PhoneNumberTextInputFormatter({this.allowPlus = true});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;

    if (text.isEmpty) return newValue;

    // If + is allowed AND the text starts with +
    if (allowPlus && text.startsWith('+')) {
      // Keep the + and only digits after it
      final cleaned = '+${text.substring(1).replaceAll(RegExp(r'[^\d]'), '')}';

      return TextEditingValue(
        text: cleaned,
        selection: TextSelection.collapsed(offset: cleaned.length),
      );
    }

    // Otherwise, keep only digits
    final cleaned = text.replaceAll(RegExp(r'[^\d]'), '');

    return TextEditingValue(
      text: cleaned,
      selection: TextSelection.collapsed(offset: cleaned.length),
    );
  }
}
