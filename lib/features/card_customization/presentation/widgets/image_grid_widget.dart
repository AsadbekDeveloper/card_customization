import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/card_customization_bloc.dart';
import '../bloc/card_customization_event.dart';

class ImageGridWidget extends StatelessWidget {
  const ImageGridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: 5,
        itemBuilder: (context, index) {
          final imagePath = 'assets/images/image${index + 1}.jpg';
          return GestureDetector(
            onTap: () => context
                .read<CardCustomizationBloc>()
                .add(PredefinedImageSelected(imagePath)),
            child: Image.asset(imagePath),
          );
        },
      ),
    );
  }
}
