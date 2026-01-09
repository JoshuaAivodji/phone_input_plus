class Country {
  /// ISO 3166-1 alpha-2 country code (e.g. 'FR', 'GA', 'BJ')
  final String code;

  /// Country name in English
  final String nameEn;

  /// Country name in French
  final String nameFr;

  /// International dialing code (e.g. '+33', '+241', '+229')
  final String dialCode;

  /// Phone number display format (e.g. '## ## ## ## ##')
  /// The '#' symbol represents a digit
  final String format;

  /// National number length (without dial code)
  final int nationalNumberLength;

  /// Regex pattern used to validate the number (optional but recommended)
  /// Example: '^01\\d{8}$' for Benin (starts with 01)
  final String? validationPattern;

  /// Flag emoji for quick display
  final String flagEmoji;

  const Country({
    required this.code,
    required this.nameEn,
    required this.nameFr,
    required this.dialCode,
    required this.format,
    required this.nationalNumberLength,
    this.validationPattern,
    required this.flagEmoji,
  });

  /// Returns the country name based on locale (defaults to English)
  String getName([String locale = 'en']) {
    return locale.startsWith('fr') ? nameFr : nameEn;
  }

  /// Formats a number according to the country format
  /// Example: '0166640219' becomes '01 66 64 02 19'
  String formatNumber(String number) {
    if (number.isEmpty) return '';

    final cleanNumber = number.replaceAll(RegExp(r'[^\d]'), '');

    String formatted = '';
    int digitIndex = 0;

    for (int i = 0; i < format.length && digitIndex < cleanNumber.length; i++) {
      if (format[i] == '#') {
        formatted += cleanNumber[digitIndex];
        digitIndex++;
      } else {
        formatted += format[i];
      }
    }

    if (digitIndex < cleanNumber.length) {
      formatted += cleanNumber.substring(digitIndex);
    }

    return formatted;
  }

  /// Validates a number for this country
  bool isValidNumber(String number) {
    final cleanNumber = number.replaceAll(RegExp(r'[^\d]'), '');

    if (cleanNumber.length != nationalNumberLength) {
      return false;
    }

    if (validationPattern != null) {
      return RegExp(validationPattern!).hasMatch(cleanNumber);
    }

    return true;
  }

  /// Returns the full international number
  /// Example: '0166640219' becomes '+2290166640219'
  String getInternationalNumber(String nationalNumber) {
    final cleanNumber = nationalNumber.replaceAll(RegExp(r'[^\d]'), '');
    return '$dialCode$cleanNumber';
  }

  Country copyWith({
    String? code,
    String? nameEn,
    String? nameFr,
    String? dialCode,
    String? format,
    int? nationalNumberLength,
    String? validationPattern,
    String? flagEmoji,
  }) {
    return Country(
      code: code ?? this.code,
      nameEn: nameEn ?? this.nameEn,
      nameFr: nameFr ?? this.nameFr,
      dialCode: dialCode ?? this.dialCode,
      format: format ?? this.format,
      nationalNumberLength: nationalNumberLength ?? this.nationalNumberLength,
      validationPattern: validationPattern ?? this.validationPattern,
      flagEmoji: flagEmoji ?? this.flagEmoji,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Country &&
          runtimeType == other.runtimeType &&
          code == other.code;

  @override
  int get hashCode => code.hashCode;

  @override
  String toString() => '$flagEmoji ${getName()} ($dialCode)';
}
