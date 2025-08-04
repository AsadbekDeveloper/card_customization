import 'package:card_customization/features/card_customization/presentation/bloc/card_customization_bloc.dart';
import 'package:card_customization/features/card_customization/presentation/bloc/card_customization_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurpleAccent,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 3,
        ),
        icon: const Icon(Icons.save_alt_rounded),
        label: const Text('Save', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        onPressed: () {
          context.read<CardCustomizationBloc>().add(SaveCustomization());
        },
      ),
    );
  }
}
