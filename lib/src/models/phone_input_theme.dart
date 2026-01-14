import 'package:flutter/material.dart';
import 'phone_input_style.dart';
import '../widgets/country_button.dart';

class PhoneInputTheme {
  /// Border radius for the input field
  final BorderRadius? borderRadius;

  /// Padding inside the input field
  final EdgeInsets? contentPadding;

  /// Background color
  final Color? fillColor;

  /// Whether to fill the background
  final bool? filled;

  /// Border color in normal state
  final Color? borderColor;

  /// Border color when focused
  final Color? focusedBorderColor;

  /// Border color when valid
  final Color? validBorderColor;

  /// Border color when invalid
  final Color? invalidBorderColor;

  /// Border width
  final double? borderWidth;

  /// Show validation icon (✓/✗)
  final bool showValidationIcon;

  /// Show progress indicator
  final bool showProgressIndicator;

  /// Enable shake animation on validation error
  final bool enableShakeAnimation;

  /// Animation duration
  final Duration animationDuration;

  /// Country button style
  final CountryButtonStyle? countryButtonStyle;

  const PhoneInputTheme({
    this.borderRadius,
    this.contentPadding,
    this.fillColor,
    this.filled,
    this.borderColor,
    this.focusedBorderColor,
    this.validBorderColor,
    this.invalidBorderColor,
    this.borderWidth,
    this.showValidationIcon = false,
    this.showProgressIndicator = false,
    this.enableShakeAnimation = false,
    this.animationDuration = const Duration(milliseconds: 300),
    this.countryButtonStyle,
  });

  /// Standard style (default)
  factory PhoneInputTheme.standard() {
    return const PhoneInputTheme();
  }

  /// Modern style with animations and visual feedback
  factory PhoneInputTheme.modern() {
    return PhoneInputTheme(
      borderRadius: BorderRadius.circular(12),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      showValidationIcon: true,
      showProgressIndicator: true,
      enableShakeAnimation: true,
      animationDuration: const Duration(milliseconds: 300),
      validBorderColor: Colors.green,
      invalidBorderColor: Colors.red,
      focusedBorderColor: Colors.blue,
      borderWidth: 2,
    );
  }

  /// Minimal style - ultra clean
  factory PhoneInputTheme.minimal() {
    return PhoneInputTheme(
      borderRadius: BorderRadius.zero,
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      filled: false,
      borderWidth: 0,
      countryButtonStyle: const CountryButtonStyle(
        showDialCode: false,
        padding: EdgeInsets.only(right: 8),
      ),
    );
  }

  /// Rounded style - iOS-like
  factory PhoneInputTheme.rounded() {
    return PhoneInputTheme(
      borderRadius: BorderRadius.circular(24),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      fillColor: Colors.grey[100],
      filled: true,
      borderColor: Colors.transparent,
      focusedBorderColor: Colors.transparent,
      borderWidth: 0,
    );
  }

  /// Outlined style - Material emphasized
  factory PhoneInputTheme.outlined() {
    return PhoneInputTheme(
      borderRadius: BorderRadius.circular(8),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      borderWidth: 2,
      focusedBorderColor: Colors.blue,
      borderColor: Colors.grey[400],
    );
  }

  /// Create a theme from a style enum
  factory PhoneInputTheme.fromStyle(PhoneInputStyle style) {
    switch (style) {
      case PhoneInputStyle.standard:
        return PhoneInputTheme.standard();
      case PhoneInputStyle.modern:
        return PhoneInputTheme.modern();
      case PhoneInputStyle.minimal:
        return PhoneInputTheme.minimal();
      case PhoneInputStyle.rounded:
        return PhoneInputTheme.rounded();
      case PhoneInputStyle.outlined:
        return PhoneInputTheme.outlined();
    }
  }

  /// Copy with modifications
  PhoneInputTheme copyWith({
    BorderRadius? borderRadius,
    EdgeInsets? contentPadding,
    Color? fillColor,
    bool? filled,
    Color? borderColor,
    Color? focusedBorderColor,
    Color? validBorderColor,
    Color? invalidBorderColor,
    double? borderWidth,
    bool? showValidationIcon,
    bool? showProgressIndicator,
    bool? enableShakeAnimation,
    Duration? animationDuration,
    CountryButtonStyle? countryButtonStyle,
  }) {
    return PhoneInputTheme(
      borderRadius: borderRadius ?? this.borderRadius,
      contentPadding: contentPadding ?? this.contentPadding,
      fillColor: fillColor ?? this.fillColor,
      filled: filled ?? this.filled,
      borderColor: borderColor ?? this.borderColor,
      focusedBorderColor: focusedBorderColor ?? this.focusedBorderColor,
      validBorderColor: validBorderColor ?? this.validBorderColor,
      invalidBorderColor: invalidBorderColor ?? this.invalidBorderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      showValidationIcon: showValidationIcon ?? this.showValidationIcon,
      showProgressIndicator:
          showProgressIndicator ?? this.showProgressIndicator,
      enableShakeAnimation: enableShakeAnimation ?? this.enableShakeAnimation,
      animationDuration: animationDuration ?? this.animationDuration,
      countryButtonStyle: countryButtonStyle ?? this.countryButtonStyle,
    );
  }
}
