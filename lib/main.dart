import 'package:flutter/material.dart';
import 'features/card_customization/presentation/pages/card_customization_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Card Customization',
      debugShowCheckedModeBanner: false,
      home: const CardCustomizationPage(),
    );
  }
}
