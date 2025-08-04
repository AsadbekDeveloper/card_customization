import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/card_customization_bloc.dart';
import '../bloc/card_customization_event.dart';
import '../bloc/card_customization_state.dart';

class BlurSliderWidget extends StatelessWidget {
  const BlurSliderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CardCustomizationBloc, CardCustomizationState>(
      builder: (context, state) {
        return Slider(
          value: state.data.blur,
          min: 0,
          max: 10,
          divisions: 10,
          label: state.data.blur.round().toString(),
          onChanged: (double value) {
            context.read<CardCustomizationBloc>().add(BlurChanged(value));
          },
        );
      },
    );
  }
}
