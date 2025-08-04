import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/card_customization_bloc.dart';
import '../bloc/card_customization_event.dart';

class PickFromGalleryButton extends StatelessWidget {
  const PickFromGalleryButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () =>
          context.read<CardCustomizationBloc>().add(ImagePicked()),
      child: const Text('Pick from Gallery'),
    );
  }
}
