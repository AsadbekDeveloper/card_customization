import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../bloc/card_customization_bloc.dart';
import '../bloc/card_customization_event.dart';
import '../bloc/card_customization_state.dart';

class ColorPickerWidget extends StatelessWidget {
  const ColorPickerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CardCustomizationBloc, CardCustomizationState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () => _pickColor(context, true),
              child: const Text('Primary Color'),
            ),
            ElevatedButton(
              onPressed: () => _pickColor(context, false),
              child: const Text('Secondary Color'),
            ),
          ],
        );
      },
    );
  }

  void _pickColor(BuildContext context, bool isPrimary) {
    Color pickedColor = isPrimary
        ? context.read<CardCustomizationBloc>().state.data.color1 ??
            Colors.blue
        : context.read<CardCustomizationBloc>().state.data.color2 ??
            Colors.red;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pick a color!'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: pickedColor,
            onColorChanged: (color) => pickedColor = color,
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('Got it'),
            onPressed: () {
              final bloc = context.read<CardCustomizationBloc>();
              if (isPrimary) {
                bloc.add(ColorChanged(pickedColor, color2: bloc.state.data.color2));
              } else {
                bloc.add(ColorChanged(bloc.state.data.color1 ?? Colors.blue, color2: pickedColor));
              }
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
