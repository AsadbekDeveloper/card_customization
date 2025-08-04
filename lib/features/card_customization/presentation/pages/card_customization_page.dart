import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/card_customization_bloc.dart';
import '../widgets/card_widget.dart';
import '../widgets/image_grid_widget.dart';
import '../widgets/pick_from_gallery_button.dart';

class CardCustomizationPage extends StatelessWidget {
  const CardCustomizationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CardCustomizationBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Customize Card'),
        ),
        body: const Column(
          children: [
            CardWidget(),
            ImageGridWidget(),
            PickFromGalleryButton(),
          ],
        ),
      ),
    );
  }
}
