import 'package:flutter/material.dart';
import 'package:phone_input_plus/phone_input_plus.dart';

class ValidationExamplePage extends StatefulWidget {
  const ValidationExamplePage({super.key});

  @override
  State<ValidationExamplePage> createState() => _ValidationExamplePageState();
}

class _ValidationExamplePageState extends State<ValidationExamplePage> {
  final _formKey = GlobalKey<FormState>();
  PhoneNumber? _submittedPhone;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Exemple avec Validation',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'Validation de formulaire avec messages d\'erreur.',
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 24),
        Form(
          key: _formKey,
          child: Column(
            children: [
              PhoneInputField(
                initialCountry: CountryData.benin,
                autoDetect: false,
                decoration: const InputDecoration(
                  labelText: 'Téléphone *',
                  hintText: 'Ex: 01 66 64 02 19',
                  border: OutlineInputBorder(),
                  helperText: 'Le numéro doit être valide',
                ),
                validator: (phone) {
                  if (phone == null || phone.isEmpty) {
                    return 'Le numéro de téléphone est requis';
                  }
                  if (!phone.isValid) {
                    return 'Le numéro n\'est pas valide pour ${phone.country.getName('fr')}';
                  }
                  return null;
                },
                onSubmitted: (phone) {
                  if (_formKey.currentState!.validate()) {
                    setState(() => _submittedPhone = phone);
                  }
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Formulaire valide !'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  },
                  icon: const Icon(Icons.check),
                  label: const Text('Valider'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (_submittedPhone != null) ...[
          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 16),
          Card(
            color: Colors.green[50],
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.green),
                      SizedBox(width: 8),
                      Text(
                        'Formulaire soumis avec succès !',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text('Numéro: ${_submittedPhone!.international}'),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}
