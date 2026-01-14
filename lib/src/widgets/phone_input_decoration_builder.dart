import 'package:flutter/material.dart';
import '../controllers/phone_controller.dart';
import '../models/phone_input_theme.dart';
import 'copy_button_widget.dart';
import 'country_button.dart';
import 'country_prefix_widget.dart';
import 'animated_validation_icon.dart';

class PhoneInputDecorationBuilder {
  /// Build decoration from user decoration and theme
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
    final decoration = userDecoration ?? const InputDecoration();

    // Determine border color based on state
    final borderColor = _getBorderColor(
      theme: theme,
      focusNode: focusNode,
      controller: controller,
      hasInteracted: hasInteracted,
    );

    return decoration.copyWith(
      contentPadding: theme.contentPadding ?? decoration.contentPadding,
      filled: theme.filled ?? decoration.filled,
      fillColor: theme.fillColor ?? decoration.fillColor,

      // Prefix: Country flag + separator
      prefixIcon: CountryPrefixWidget(
        controller: controller,
        isDetecting: isDetecting,
        onCountryButtonPressed: onCountryButtonPressed,
        theme: theme,
        countryButtonStyle: countryButtonStyle,
        enabled: enabled,
        readOnly: readOnly,
      ),

      // Suffix: Validation icon if enabled
      suffixIcon: _buildSuffixIcon(
        theme: theme,
        controller: controller,
        hasInteracted: hasInteracted,
        decoration: decoration,
        showCopyButton: showCopyButton,
        copyButtonIcon: copyButtonIcon,
        copiedMessage: copiedMessage,
      ),

      // Borders with theme
      border: _buildBorder(decoration.border, theme, borderColor),
      enabledBorder: _buildBorder(decoration.enabledBorder, theme, borderColor),
      focusedBorder: _buildBorder(decoration.focusedBorder, theme, borderColor),
      errorBorder: _buildBorder(
        decoration.errorBorder,
        theme,
        theme.invalidBorderColor,
      ),
      focusedErrorBorder: _buildBorder(
        decoration.focusedErrorBorder,
        theme,
        theme.invalidBorderColor,
      ),
    );
  }

  /// Build suffix icon (validation + copy button)
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

    if (!showValidation && !showCopyButton) {
      return decoration.suffixIcon;
    }

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

    if (!showValidation && showCopyButton) {
      return CopyButtonWidget(
        controller: controller,
        icon: copyButtonIcon ?? Icons.copy,
        copiedMessage: copiedMessage,
      );
    }

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

  /// Determine border color based on current state
  static Color? _getBorderColor({
    required PhoneInputTheme theme,
    required FocusNode focusNode,
    required PhoneController controller,
    required bool hasInteracted,
  }) {
    if (focusNode.hasFocus) {
      return theme.focusedBorderColor;
    } else if (hasInteracted && controller.value.nationalNumber.isNotEmpty) {
      return controller.value.isValid
          ? theme.validBorderColor
          : theme.invalidBorderColor;
    } else {
      return theme.borderColor;
    }
  }

  /// Build border with theme customization
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
