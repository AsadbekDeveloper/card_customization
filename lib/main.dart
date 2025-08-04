import 'package:card_customization/features/card_customization/presentation/bloc/card_customization_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/card_customization/presentation/pages/card_customization_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CardCustomizationBloc(),
      child: MaterialApp(
        title: 'Card Customization',
        debugShowCheckedModeBanner: false,
        home: const CardCustomizationPage(),
      ),
    );
  }
}
