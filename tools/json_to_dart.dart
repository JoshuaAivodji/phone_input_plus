import 'dart:convert';
import 'dart:io';

void main(List<String> args) async {
  // use : dart run tools/json_to_dart.dart <input.json> <output.dart> <ClassName>
  if (args.length != 3) {
    /*print(
      'Usage: dart run tools/json_to_dart.dart <input.json> <output.dart> <ClassName>',
    );
    print(
      'Example: dart run tools/json_to_dart.dart african_countries.json countries_africa.dart AfricanCountries',
    );*/
    exit(1);
  }

  final inputFile = args[0];
  final outputFile = args[1];
  final className = args[2];

  await generateCountriesFile(
    inputJsonPath: 'tools/$inputFile',
    outputDartPath: 'lib/src/core/data/$outputFile',
    className: className,
  );
}

Future<void> generateCountriesFile({
  required String inputJsonPath,
  required String outputDartPath,
  required String className,
}) async {
  //print('read of $inputJsonPath...');

  final jsonFile = File(inputJsonPath);
  if (!await jsonFile.exists()) {
    //print('File not found: $inputJsonPath');
    exit(1);
  }

  final jsonString = await jsonFile.readAsString();
  final List<dynamic> countries = jsonDecode(jsonString);

  //print('${countries.length} Countries found in JSON');

  // Remove Duplicates
  final Set<String> seenCodes = {};
  final StringBuffer dartCode = StringBuffer();

  // File Header
  dartCode.writeln('import \'../../models/country.dart\';');
  dartCode.writeln('');
  dartCode.writeln('/// $className (Generated from JSON)');
  dartCode.writeln('class $className {');
  dartCode.writeln('  $className._(); // Private constructor');
  dartCode.writeln('');

  final List<String> varNames = [];

  for (var country in countries) {
    final code = country['code'] as String;

    if (seenCodes.contains(code)) {
      //print('Ignored duplicate: $code');
      continue;
    }
    seenCodes.add(code);

    final nameEn = country['nameEn'] as String;
    final nameFr = country['nameFr'] as String;
    final dialCode = country['dialCode'] as String;
    final format = country['format'] as String;
    final nationalNumberLength = country['nationalNumberLength'] as int;
    final validationPattern = country['validationPattern'] as String;
    final flagEmoji = country['flagEmoji'] as String;

    // Generate variable name (camelCase)
    final varName = _toCamelCase(nameEn);
    varNames.add(varName);

    // Escape special characters for Dart
    final escapedNameFr = nameFr.replaceAll("'", "\\'");

    dartCode.writeln('  static const $varName = Country(');
    dartCode.writeln('    code: \'$code\',');
    dartCode.writeln('    nameEn: \'$nameEn\',');
    dartCode.writeln('    nameFr: \'$escapedNameFr\',');
    dartCode.writeln('    dialCode: \'$dialCode\',');
    dartCode.writeln('    format: \'$format\',');
    dartCode.writeln('    nationalNumberLength: $nationalNumberLength,');
    dartCode.writeln('    validationPattern: r\'$validationPattern\',');
    dartCode.writeln('    flagEmoji: \'$flagEmoji\',');
    dartCode.writeln('  );');
    dartCode.writeln('');
  }

  dartCode.writeln('  /// All ${className.toLowerCase()}');
  dartCode.writeln('  static const List<Country> all = [');
  for (var varName in varNames) {
    dartCode.writeln('    $varName,');
  }
  dartCode.writeln('  ];');
  dartCode.writeln('}');

  final outputFileObj = File(outputDartPath);
  await outputFileObj.writeAsString(dartCode.toString());

  //print('File generate: $outputDartPath');
  //print('${seenCodes.length} Countries added to $className');
}

String _toCamelCase(String text) {
  //Clean and camelCase
  final words = text
      .replaceAll(RegExp(r'[^\w\s]'), '')
      .split(RegExp(r'\s+'))
      .where((word) => word.isNotEmpty)
      .toList();

  if (words.isEmpty) return 'unknown';

  //First word lowercase, subsequent words capitalized
  return words.first.toLowerCase() +
      words
          .skip(1)
          .map((w) => w[0].toUpperCase() + w.substring(1).toLowerCase())
          .join('');
}
