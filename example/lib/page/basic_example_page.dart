import 'package:flutter/material.dart';
import 'package:phone_input_plus/phone_input_plus.dart';

class BasicExamplePage extends StatefulWidget {
  const BasicExamplePage({super.key});

  @override
  State<BasicExamplePage> createState() => _BasicExamplePageState();
}

class _BasicExamplePageState extends State<BasicExamplePage> {
  PhoneNumber? _phoneNumber;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Exemple Basique',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'Utilisation simple sans controller. Le package détecte automatiquement votre pays.',
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 24),
        const Text(
          '1. Avec auto-détection',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 20),
        PhoneInputField(
          decoration: const InputDecoration(
            labelText: 'Numéro de téléphone',
            hintText: 'Entrez votre numéro',
            border: OutlineInputBorder(),
          ),
          onChanged: (phone) {
            setState(() {
              _phoneNumber = phone;
            });
          },
        ),
        const SizedBox(height: 24),
        const Text(
          '2. Avec pays initial (Bénin)',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 20),
        PhoneInputField(
          initialCountry: CountryData.benin,
          autoDetect: false,
          decoration: const InputDecoration(
            labelText: 'Téléphone (Bénin)',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          '3. Liste limitée de pays (Afrique de l\'Ouest)',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 20),
        PhoneInputField(
          countries: [
            CountryData.benin,
            CountryData.gabon,
            CountryData.senegal,
            CountryData.civ,
            CountryData.cameroon,
          ],
          autoDetect: false,
          initialCountry: CountryData.benin,
          decoration: const InputDecoration(
            labelText: 'Téléphone',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 24),
        if (_phoneNumber != null) ...[
          const Divider(),
          const SizedBox(height: 16),
          _buildResultCard(_phoneNumber!),
        ],
      ],
    );
  }

  Widget _buildResultCard(PhoneNumber phone) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Résultat :',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),
            _buildInfoRow(
              'Pays',
              '${phone.country.flagEmoji} ${phone.country.getName('fr')}',
            ),
            _buildInfoRow('Code pays', phone.country.dialCode),
            _buildInfoRow('Numéro national', phone.nationalNumber),
            _buildInfoRow('Formaté', phone.formatted),
            _buildInfoRow('International', phone.international),
            _buildInfoRow(
              'Valide',
              phone.isValid ? 'Oui' : 'Non',
              isGood: phone.isValid ? true : false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool? isGood}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text('$label :', style: const TextStyle(color: Colors.grey)),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: isGood == true ? Colors.green : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
