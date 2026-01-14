import 'package:flutter/material.dart';
import 'package:phone_input_plus/phone_input_plus.dart';

class StylesExamplePage extends StatefulWidget {
  const StylesExamplePage({super.key});

  @override
  State<StylesExamplePage> createState() => _StylesExamplePageState();
}

class _StylesExamplePageState extends State<StylesExamplePage> {
  final Map<String, PhoneNumber?> _phoneNumbers = {
    'standard': null,
    'modern': null,
    'minimal': null,
    'rounded': null,
  };

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Input Field Styles',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'Different visual styles for the phone input field.',
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 24),
        _buildStyleSection(
          title: '1. Standard Style',
          description: 'Default clean and simple style',
          style: PhoneInputStyle.standard,
          key: 'standard',
        ),
        _buildStyleSection(
          title: '2. Modern Style',
          description: 'With animations, validation icon, and progress bar',
          style: PhoneInputStyle.modern,
          key: 'modern',
          features: [
            '✅ Validation icon (✓/✗)',
            '✅ Shake animation on error',
            '✅ Dynamic border colors',
          ],
        ),
        _buildStyleSection(
          title: '3. Minimal Style',
          description: 'Ultra clean with underline only',
          style: PhoneInputStyle.minimal,
          key: 'minimal',
        ),
        _buildStyleSection(
          title: '4. Rounded Style',
          description: 'iOS-like with rounded corners and background',
          style: PhoneInputStyle.rounded,
          key: 'rounded',
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildStyleSection({
    required String title,
    required String description,
    required PhoneInputStyle style,
    required String key,
    List<String>? features,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: TextStyle(color: Colors.grey[600], fontSize: 14),
        ),
        if (features != null) ...[
          const SizedBox(height: 8),
          ...features.map(
            (feature) => Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 4),
              child: Text(
                feature,
                style: TextStyle(color: Colors.grey[700], fontSize: 13),
              ),
            ),
          ),
        ],
        const SizedBox(height: 12),
        PhoneInputField(
          style: style,
          initialCountry: CountryData.benin,
          autoDetect: false,
          decoration: InputDecoration(
            labelText: 'Phone Number',
            hintText: 'Enter your number',
            border: style == PhoneInputStyle.rounded ? InputBorder.none : null,
          ),
          validator: (phone) {
            if (phone == null || phone.isEmpty) {
              return 'Required';
            }
            if (!phone.isValid) {
              return 'Invalid number';
            }
            return null;
          },
          onChanged: (phone) {
            setState(() => _phoneNumbers[key] = phone);
          },
        ),
        if (_phoneNumbers[key] != null) ...[
          const SizedBox(height: 8),
          _buildResultChip(_phoneNumbers[key]!),
        ],
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildResultChip(PhoneNumber phone) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: phone.isValid ? Colors.green[50] : Colors.orange[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: phone.isValid ? Colors.green : Colors.orange),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            phone.isValid ? Icons.check_circle : Icons.info,
            size: 16,
            color: phone.isValid ? Colors.green : Colors.orange,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              phone.international,
              style: TextStyle(
                fontSize: 13,
                color: phone.isValid ? Colors.green[900] : Colors.orange[900],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
