import 'package:flutter/material.dart';
import 'package:phone_input_plus/phone_input_plus.dart';

class ControllerExamplePage extends StatefulWidget {
  const ControllerExamplePage({super.key});

  @override
  State<ControllerExamplePage> createState() => _ControllerExamplePageState();
}

class _ControllerExamplePageState extends State<ControllerExamplePage> {
  late PhoneController _controller;
  String _log = '';

  @override
  void initState() {
    super.initState();
    _controller = PhoneController(initialCountry: CountryData.benin);
    _controller.addListener(_onPhoneChanged);
  }

  void _onPhoneChanged() {
    setState(() {
      _log =
          'Changement détecté :\n'
          '- Pays: ${_controller.country.nameEn}\n'
          '- Numéro: ${_controller.nationalNumber}\n'
          '- International: ${_controller.international}\n'
          '- Valide: ${_controller.isValid}';
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Exemple avec Controller',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'Contrôle programmatique du champ avec PhoneController.',
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 24),
        PhoneInputField(
          controller: _controller,
          autoDetect: false,
          decoration: const InputDecoration(
            labelText: 'Téléphone',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Actions programmatiques :',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                _controller.changeCountry(CountryData.gabon);
              },
              icon: const Text('🇬🇦'),
              label: const Text('Gabon'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                _controller.changeCountry(CountryData.france);
              },
              icon: const Text('🇫🇷'),
              label: const Text('France'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                _controller.updateNumber('0166640219');
              },
              icon: const Icon(Icons.edit),
              label: const Text('Set Numéro BJ'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                _controller.clear();
              },
              icon: const Icon(Icons.clear),
              label: const Text('Clear'),
            ),
          ],
        ),
        const SizedBox(height: 24),
        if (_log.isNotEmpty) ...[
          const Text(
            'Log des changements :',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Card(
            color: Colors.grey[100],
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                _log,
                style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
