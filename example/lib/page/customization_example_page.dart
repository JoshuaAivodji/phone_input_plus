import 'package:flutter/material.dart';
import 'package:phone_input_plus/phone_input_plus.dart';

class CustomizationExamplePage extends StatelessWidget {
  const CustomizationExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Customization Examples',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'Different possible styles and configurations.',
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 24),
        const Text(
          '1. Minimal style',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 20),
        PhoneInputField(
          initialCountry: CountryData.benin,
          autoDetect: false,
          countryButtonStyle: const CountryButtonStyle(
            showDialCode: false,
            padding: EdgeInsets.all(8),
          ),
          decoration: const InputDecoration(
            hintText: 'Phone',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          '2. With Dialog (instead of BottomSheet)',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 20),
        PhoneInputField(
          initialCountry: CountryData.gabon,
          autoDetect: false,
          countrySelectorConfig: const CountrySelectorConfig(
            type: CountrySelectorType.dialog,
            title: 'Select a country',
            searchHint: 'Search...',
            locale: 'en',
          ),
          decoration: const InputDecoration(
            labelText: 'Phone',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          '3. Without automatic formatting',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 20),
        PhoneInputField(
          initialCountry: CountryData.senegal,
          autoDetect: false,
          autoFormat: false,
          decoration: const InputDecoration(
            labelText: 'Phone (raw)',
            border: OutlineInputBorder(),
            helperText: 'Spaces are not added automatically',
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          '4. Read-only',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        PhoneInputField(
          initialCountry: CountryData.france,
          autoDetect: false,
          readOnly: true,
          decoration: const InputDecoration(
            labelText: 'Phone (readonly)',
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
