import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:phone_input_plus/src/widgets/country_button.dart';
import 'package:phone_input_plus/src/core/country_data.dart';

void main() {
  group('CountryButton', () {
    testWidgets('Devrait afficher le drapeau et le dial code', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CountryButton(country: CountryData.benin, onPressed: () {}),
          ),
        ),
      );

      // Vérifie que le drapeau est affiché
      expect(find.text('🇧🇯'), findsOneWidget);

      // Vérifie que le dial code est affiché
      expect(find.text('+229'), findsOneWidget);

      // Vérifie que l'icône dropdown est affichée
      expect(find.byIcon(Icons.arrow_drop_down), findsOneWidget);
    });

    testWidgets('Devrait cacher le dial code si configuré', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CountryButton(
              country: CountryData.france,
              style: const CountryButtonStyle(showDialCode: false),
            ),
          ),
        ),
      );

      // Vérifie que le drapeau est affiché
      expect(find.text('🇫🇷'), findsOneWidget);

      // Vérifie que le dial code N'est PAS affiché
      expect(find.text('+33'), findsNothing);
    });

    testWidgets('Devrait cacher l\'icône dropdown si configuré', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CountryButton(
              country: CountryData.gabon,
              showDropdownIcon: false,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.arrow_drop_down), findsNothing);
    });

    testWidgets('Devrait appeler onPressed au tap', (tester) async {
      bool pressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CountryButton(
              country: CountryData.benin,
              onPressed: () {
                pressed = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(CountryButton));
      await tester.pump();

      expect(pressed, true);
    });

    testWidgets('Ne devrait pas répondre au tap si disabled', (tester) async {
      bool pressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CountryButton(
              country: CountryData.benin,
              enabled: false,
              onPressed: () {
                pressed = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(CountryButton));
      await tester.pump();

      expect(pressed, false);
    });
  });
}
