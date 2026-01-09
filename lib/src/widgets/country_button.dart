import 'package:flutter/material.dart';
import '../models/country.dart';

class CountryButton extends StatelessWidget {
  /// Country to display
  final Country country;

  /// Callback when the button is pressed
  final VoidCallback? onPressed;

  /// Button style
  final CountryButtonStyle style;

  /// Is the button enabled?
  final bool enabled;

  /// Show dropdown arrow icon?
  final bool showDropdownIcon;

  const CountryButton({
    super.key,
    required this.country,
    this.onPressed,
    this.style = const CountryButtonStyle(),
    this.enabled = true,
    this.showDropdownIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enabled ? onPressed : null,
      borderRadius: style.borderRadius,
      child: Container(
        padding: style.padding,
        constraints: style.constraints,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              country.flagEmoji,
              style: style.flagStyle ?? const TextStyle(fontSize: 24),
            ),
            if (style.showDialCode) ...[
              SizedBox(width: style.spacing),
              Text(
                country.dialCode,
                style:
                    style.dialCodeStyle ??
                    TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: enabled
                          ? Theme.of(context).textTheme.bodyLarge?.color
                          : Theme.of(context).disabledColor,
                    ),
              ),
            ],
            if (showDropdownIcon && enabled) ...[
              SizedBox(width: style.spacing / 2),
              Icon(
                style.dropdownIcon,
                size: style.dropdownIconSize,
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class CountryButtonStyle {
  /// Padding around the button
  final EdgeInsetsGeometry padding;

  /// Spacing between elements
  final double spacing;

  /// Border radius for ripple effect
  final BorderRadius? borderRadius;

  /// Size constraints
  final BoxConstraints? constraints;

  /// Flag (emoji) text style
  final TextStyle? flagStyle;

  /// Dial code text style
  final TextStyle? dialCodeStyle;

  /// Show dial code?
  final bool showDialCode;

  /// Dropdown icon
  final IconData dropdownIcon;

  /// Dropdown icon size
  final double dropdownIconSize;

  const CountryButtonStyle({
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    this.spacing = 8,
    this.borderRadius,
    this.constraints,
    this.flagStyle,
    this.dialCodeStyle,
    this.showDialCode = true,
    this.dropdownIcon = Icons.arrow_drop_down,
    this.dropdownIconSize = 24,
  });

  CountryButtonStyle copyWith({
    EdgeInsetsGeometry? padding,
    double? spacing,
    BorderRadius? borderRadius,
    BoxConstraints? constraints,
    TextStyle? flagStyle,
    TextStyle? dialCodeStyle,
    bool? showDialCode,
    IconData? dropdownIcon,
    double? dropdownIconSize,
  }) {
    return CountryButtonStyle(
      padding: padding ?? this.padding,
      spacing: spacing ?? this.spacing,
      borderRadius: borderRadius ?? this.borderRadius,
      constraints: constraints ?? this.constraints,
      flagStyle: flagStyle ?? this.flagStyle,
      dialCodeStyle: dialCodeStyle ?? this.dialCodeStyle,
      showDialCode: showDialCode ?? this.showDialCode,
      dropdownIcon: dropdownIcon ?? this.dropdownIcon,
      dropdownIconSize: dropdownIconSize ?? this.dropdownIconSize,
    );
  }
}
