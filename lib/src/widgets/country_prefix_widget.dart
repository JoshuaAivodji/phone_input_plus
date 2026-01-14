import 'package:flutter/material.dart';
import '../controllers/phone_controller.dart';
import '../models/phone_input_theme.dart';
import '../core/phone_number.dart';
import 'country_button.dart';

class CountryPrefixWidget extends StatelessWidget {
  final PhoneController controller;
  final bool isDetecting;
  final VoidCallback onCountryButtonPressed;
  final PhoneInputTheme theme;
  final CountryButtonStyle? countryButtonStyle;
  final bool enabled;
  final bool readOnly;

  const CountryPrefixWidget({
    super.key,
    required this.controller,
    required this.isDetecting,
    required this.onCountryButtonPressed,
    required this.theme,
    this.countryButtonStyle,
    required this.enabled,
    required this.readOnly,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 4),
      child: ValueListenableBuilder<PhoneNumber>(
        valueListenable: controller,
        builder: (context, phoneNumber, child) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isDetecting)
                const Padding(
                  padding: EdgeInsets.all(12),
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                )
              else
                CountryButton(
                  country: phoneNumber.country,
                  onPressed: onCountryButtonPressed,
                  style:
                      theme.countryButtonStyle ??
                      countryButtonStyle ??
                      const CountryButtonStyle(),
                  enabled: enabled && !readOnly,
                ),
              Container(
                height: 24,
                width: 1,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                color: Theme.of(context).dividerColor,
              ),
            ],
          );
        },
      ),
    );
  }
}
