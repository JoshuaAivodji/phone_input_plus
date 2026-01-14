import 'package:flutter/material.dart';
import 'package:phone_input_plus_example/page/styles_example_page.dart';

import 'page/basic_example_page.dart';
import 'page/controller_example_page.dart';
import 'page/customization_example_page.dart';
import 'page/validation_example_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PhoneInputPlus Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const DemoHomePage(),
    );
  }
}

class DemoHomePage extends StatefulWidget {
  const DemoHomePage({super.key});

  @override
  State<DemoHomePage> createState() => _DemoHomePageState();
}

class _DemoHomePageState extends State<DemoHomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    BasicExamplePage(),
    ControllerExamplePage(),
    ValidationExamplePage(),
    StylesExamplePage(),
    CustomizationExamplePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PhoneInputPlus Examples'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() => _currentIndex = index);
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.phone), label: 'Basic'),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Controller',
          ),
          NavigationDestination(
            icon: Icon(Icons.check_circle),
            label: 'Validation',
          ),
          NavigationDestination(icon: Icon(Icons.palette), label: 'Styles'),
          NavigationDestination(icon: Icon(Icons.tune), label: 'Custom'),
        ],
      ),
    );
  }
}
