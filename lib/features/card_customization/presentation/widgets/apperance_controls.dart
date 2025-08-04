import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../bloc/card_customization_bloc.dart';
import '../bloc/card_customization_event.dart';
import '../bloc/card_customization_state.dart';

class AppearanceControlsWidget extends StatelessWidget {
  const AppearanceControlsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CardCustomizationBloc, CardCustomizationState>(
      builder: (context, state) {
        final primary = state.data.color1 ?? Colors.blue;
        final secondary = state.data.color2;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                _buildColorDot(context, primary, isPrimary: true),
                const SizedBox(width: 12),
                _buildColorDot(context, secondary ?? Colors.transparent, isPrimary: false),
                const SizedBox(width: 8),
                Text(secondary != null ? "Gradient" : "Solid"),
              ],
            ),
            const SizedBox(height: 10),

            Row(
              children: [
                const Icon(Icons.blur_on),
                const SizedBox(width: 8),
                const Text('Blur', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                Expanded(
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: Colors.deepPurpleAccent,
                      inactiveTrackColor: Colors.deepPurple.withOpacity(0.3),
                      thumbColor: Colors.deepPurpleAccent,
                      overlayColor: Colors.deepPurpleAccent.withOpacity(0.2),
                      trackHeight: 4,
                      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
                    ),
                    child: Slider(
                      value: state.data.blur,
                      min: 0,
                      max: 25,
                      divisions: 25,
                      onChanged: (value) {
                        context.read<CardCustomizationBloc>().add(BlurChanged(value));
                      },
                    ),
                  ),
                ),
                Text(state.data.blur.toStringAsFixed(1)),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildColorDot(BuildContext context, Color color, {required bool isPrimary}) {
    final isTransparent = color == Colors.transparent;

    return InkWell(
      onTap: () => _pickColor(context, isPrimary),
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: isTransparent ? Colors.grey.shade800 : color,
          shape: BoxShape.circle,
          border: Border.all(width: 1),
        ),
        child: isTransparent ? const Icon(Icons.close, size: 18) : null,
      ),
    );
  }

  void _pickColor(BuildContext context, bool isPrimary) {
    final bloc = context.read<CardCustomizationBloc>();
    Color pickedColor = isPrimary
        ? bloc.state.data.color1 ?? Colors.blue
        : bloc.state.data.color2 ?? Colors.red;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(isPrimary ? 'Pick Primary Color' : 'Pick Secondary Color'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: pickedColor,
            onColorChanged: (color) => pickedColor = color,
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              if (isPrimary) {
                bloc.add(ColorChanged(pickedColor, color2: bloc.state.data.color2));
              } else {
                bloc.add(
                  ColorChanged(
                    bloc.state.data.color1 ?? Colors.blue,
                    color2: pickedColor == bloc.state.data.color1 ? null : pickedColor,
                  ),
                );
              }
              Navigator.pop(context);
            },
            child: const Text('Select'),
          ),
        ],
      ),
    );
  }
}
