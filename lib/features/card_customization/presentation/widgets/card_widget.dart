import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/card_customization_bloc.dart';
import '../bloc/card_customization_state.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CardCustomizationBloc, CardCustomizationState>(
      builder: (context, state) {
        return Container(
          height: 200,
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: (state.data.imageFile != null
                  ? FileImage(state.data.imageFile!)
                  : AssetImage(state.data.imagePath!)) as ImageProvider,
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
        );
      },
    );
  }
}
