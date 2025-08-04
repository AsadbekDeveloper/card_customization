import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/card_customization_bloc.dart';
import '../bloc/card_customization_event.dart';

class ImageGridWidget extends StatelessWidget {
  const ImageGridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const crossAxisCount = 3;

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 6,
      itemBuilder: (context, index) {
        final imagePath = 'assets/images/image${index + 1}.jpg';

        return GestureDetector(
          onTap: () =>
              context.read<CardCustomizationBloc>().add(PredefinedImageSelected(imagePath)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(imagePath, fit: BoxFit.cover),
          ),
        );
      },
    );
  }
}
