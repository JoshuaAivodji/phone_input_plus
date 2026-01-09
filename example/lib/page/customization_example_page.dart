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
          'Exemples de Customisation',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'Différents styles et configurations possibles.',
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 24),
        const Text(
          '1. Style minimal',
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
            hintText: 'Téléphone',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          '2. Avec Dialog (au lieu de BottomSheet)',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 20),
        PhoneInputField(
          initialCountry: CountryData.gabon,
          autoDetect: false,
          countrySelectorConfig: const CountrySelectorConfig(
            type: CountrySelectorType.dialog,
            title: 'Choisissez un pays',
            searchHint: 'Rechercher...',
            locale: 'fr',
          ),
          decoration: const InputDecoration(
            labelText: 'Téléphone',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          '3. Sans formatage automatique',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 20),
        PhoneInputField(
          initialCountry: CountryData.senegal,
          autoDetect: false,
          autoFormat: false,
          decoration: const InputDecoration(
            labelText: 'Téléphone (brut)',
            border: OutlineInputBorder(),
            helperText: 'Les espaces ne sont pas ajoutés automatiquement',
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          '4. En lecture seule',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        PhoneInputField(
          initialCountry: CountryData.france,
          autoDetect: false,
          readOnly: true,
          decoration: const InputDecoration(
            labelText: 'Téléphone (readonly)',
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
