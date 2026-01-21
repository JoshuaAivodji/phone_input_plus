import 'package:flutter/material.dart';
import '../controllers/phone_controller.dart';
import '../models/phone_input_theme.dart';
import 'copy_button_widget.dart';
import 'country_button.dart';
import 'country_prefix_widget.dart';
import 'animated_validation_icon.dart';

/// 1. [userDecoration] - If provided, it takes full priority (only adds functional widgets)
/// 2. [theme] - If no decoration provided, builds from theme
/// 3. Default - Minimal InputDecoration if neither provided
class PhoneInputDecorationBuilder {
  static InputDecoration build({
    required InputDecoration? userDecoration,
    required PhoneInputTheme theme,
    required PhoneController controller,
    required bool isDetecting,
    required VoidCallback onCountryButtonPressed,
    required FocusNode focusNode,
    required bool hasInteracted,
    required bool enabled,
    required bool readOnly,
    required BuildContext context,
    CountryButtonStyle? countryButtonStyle,
    bool showCopyButton = false,
    IconData? copyButtonIcon,
    String? copiedMessage,
  }) {
    if (userDecoration != null) {
      return _buildWithUserDecoration(
        userDecoration: userDecoration,
        theme: theme,
        controller: controller,
        isDetecting: isDetecting,
        onCountryButtonPressed: onCountryButtonPressed,
        hasInteracted: hasInteracted,
        enabled: enabled,
        readOnly: readOnly,
        countryButtonStyle: countryButtonStyle,
        showCopyButton: showCopyButton,
        copyButtonIcon: copyButtonIcon,
        copiedMessage: copiedMessage,
      );
    }

    return _buildFromTheme(
      theme: theme,
      controller: controller,
      isDetecting: isDetecting,
      onCountryButtonPressed: onCountryButtonPressed,
      focusNode: focusNode,
      hasInteracted: hasInteracted,
      enabled: enabled,
      readOnly: readOnly,
      context: context,
      countryButtonStyle: countryButtonStyle,
      showCopyButton: showCopyButton,
      copyButtonIcon: copyButtonIcon,
      copiedMessage: copiedMessage,
    );
  }

  static InputDecoration _buildWithUserDecoration({
    required InputDecoration userDecoration,
    required PhoneInputTheme theme,
    required PhoneController controller,
    required bool isDetecting,
    required VoidCallback onCountryButtonPressed,
    required bool hasInteracted,
    required bool enabled,
    required bool readOnly,
    CountryButtonStyle? countryButtonStyle,
    required bool showCopyButton,
    IconData? copyButtonIcon,
    String? copiedMessage,
  }) {
    return userDecoration.copyWith(
      // Only add prefix if user hasn't defined one
      prefixIcon:
          userDecoration.prefixIcon ??
          CountryPrefixWidget(
            controller: controller,
            isDetecting: isDetecting,
            onCountryButtonPressed: onCountryButtonPressed,
            theme: theme,
            countryButtonStyle: countryButtonStyle,
            enabled: enabled,
            readOnly: readOnly,
          ),

      // Only add suffix if user hasn't defined one
      suffixIcon:
          userDecoration.suffixIcon ??
          _buildSuffixIcon(
            theme: theme,
            controller: controller,
            hasInteracted: hasInteracted,
            decoration: userDecoration,
            showCopyButton: showCopyButton,
            copyButtonIcon: copyButtonIcon,
            copiedMessage: copiedMessage,
          ),
    );
  }

  static InputDecoration _buildFromTheme({
    required PhoneInputTheme theme,
    required PhoneController controller,
    required bool isDetecting,
    required VoidCallback onCountryButtonPressed,
    required FocusNode focusNode,
    required bool hasInteracted,
    required bool enabled,
    required bool readOnly,
    required BuildContext context,
    CountryButtonStyle? countryButtonStyle,
    required bool showCopyButton,
    IconData? copyButtonIcon,
    String? copiedMessage,
  }) {
    final borderColor = _getBorderColor(
      theme: theme,
      focusNode: focusNode,
      controller: controller,
      hasInteracted: hasInteracted,
    );

    return InputDecoration(
      contentPadding: theme.contentPadding,
      filled: theme.filled,
      fillColor: theme.fillColor,

      // Prefix: Country flag + dial code
      prefixIcon: CountryPrefixWidget(
        controller: controller,
        isDetecting: isDetecting,
        onCountryButtonPressed: onCountryButtonPressed,
        theme: theme,
        countryButtonStyle: countryButtonStyle,
        enabled: enabled,
        readOnly: readOnly,
      ),

      // Suffix: Validation icon + copy button
      suffixIcon: _buildSuffixIcon(
        theme: theme,
        controller: controller,
        hasInteracted: hasInteracted,
        decoration: const InputDecoration(),
        showCopyButton: showCopyButton,
        copyButtonIcon: copyButtonIcon,
        copiedMessage: copiedMessage,
      ),

      // Borders with dynamic colors based on state
      border: _buildBorder(null, theme, borderColor),
      enabledBorder: _buildBorder(null, theme, borderColor),
      focusedBorder: _buildBorder(null, theme, theme.focusedBorderColor),
      errorBorder: _buildBorder(null, theme, theme.invalidBorderColor),
      focusedErrorBorder: _buildBorder(null, theme, theme.invalidBorderColor),
    );
  }

  static Widget? _buildSuffixIcon({
    required PhoneInputTheme theme,
    required PhoneController controller,
    required bool hasInteracted,
    required InputDecoration decoration,
    required bool showCopyButton,
    IconData? copyButtonIcon,
    String? copiedMessage,
  }) {
    final showValidation = theme.showValidationIcon && hasInteracted;

    // No suffix widgets needed
    if (!showValidation && !showCopyButton) {
      return decoration.suffixIcon;
    }

    // Only validation icon
    if (showValidation && !showCopyButton) {
      return Padding(
        padding: const EdgeInsets.only(right: 12),
        child: AnimatedValidationIcon(
          isValid: controller.value.isValid,
          isEmpty: controller.value.nationalNumber.isEmpty,
          animationDuration: theme.animationDuration,
        ),
      );
    }

    // Only copy button
    if (!showValidation && showCopyButton) {
      return CopyButtonWidget(
        controller: controller,
        icon: copyButtonIcon ?? Icons.copy,
        copiedMessage: copiedMessage,
      );
    }

    // Both validation icon and copy button
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedValidationIcon(
          isValid: controller.value.isValid,
          isEmpty: controller.value.nationalNumber.isEmpty,
          animationDuration: theme.animationDuration,
        ),
        CopyButtonWidget(
          controller: controller,
          icon: copyButtonIcon ?? Icons.copy,
          copiedMessage: copiedMessage,
        ),
      ],
    );
  }

  static Color? _getBorderColor({
    required PhoneInputTheme theme,
    required FocusNode focusNode,
    required PhoneController controller,
    required bool hasInteracted,
  }) {
    if (focusNode.hasFocus) {
      return theme.focusedBorderColor;
    }

    if (hasInteracted && controller.value.nationalNumber.isNotEmpty) {
      return controller.value.isValid
          ? theme.validBorderColor
          : theme.invalidBorderColor;
    }

    return theme.borderColor;
  }

  static InputBorder? _buildBorder(
    InputBorder? userBorder,
    PhoneInputTheme theme,
    Color? color,
  ) {
    if (userBorder == null) {
      return OutlineInputBorder(
        borderRadius: theme.borderRadius ?? BorderRadius.circular(4),
        borderSide: BorderSide(
          color: color ?? Colors.grey,
          width: theme.borderWidth ?? 1,
        ),
      );
    }

    if (userBorder is OutlineInputBorder) {
      return userBorder.copyWith(
        borderRadius: theme.borderRadius ?? userBorder.borderRadius,
        borderSide: color != null
            ? BorderSide(
                color: color,
                width: theme.borderWidth ?? userBorder.borderSide.width,
              )
            : userBorder.borderSide,
      );
    }

    if (userBorder is UnderlineInputBorder) {
      return userBorder.copyWith(
        borderRadius: theme.borderRadius ?? userBorder.borderRadius,
        borderSide: color != null
            ? BorderSide(
                color: color,
                width: theme.borderWidth ?? userBorder.borderSide.width,
              )
            : userBorder.borderSide,
      );
    }

    return userBorder;
  }
}
