import 'package:card_customization/features/card_customization/presentation/bloc/card_customization_bloc.dart';
import 'package:card_customization/features/card_customization/presentation/bloc/card_customization_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/blur_slider_widget.dart';
import '../widgets/card_widget.dart';
import '../widgets/color_picker_widget.dart';
import '../widgets/image_grid_widget.dart';
import '../widgets/pick_from_gallery_button.dart';
import '../bloc/card_customization_state.dart'; // Import the state file

class CardCustomizationPage extends StatefulWidget {
  const CardCustomizationPage({super.key});

  @override
  State<CardCustomizationPage> createState() => _CardCustomizationPageState();
}

class _CardCustomizationPageState extends State<CardCustomizationPage> {
  @override
  void initState() {
    super.initState();
    context.read<CardCustomizationBloc>().add(
      (PredefinedImageSelected('assets/images/image1.jpg')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Customize Card')),
      body: BlocListener<CardCustomizationBloc, CardCustomizationState>(
        listener: (context, state) {
          if (state.status == CardCustomizationStatus.loading) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Saving customization...')),
            );
          } else if (state.status == CardCustomizationStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Customization saved successfully!')),
            );
          } else if (state.status == CardCustomizationStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to save customization: ${state.errorMessage}')),
            );
          }
        },
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: const SliverToBoxAdapter(child: CardWidget()),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverToBoxAdapter(
                child: Column(
                  children: [
                    ImageGridWidget(),
                    const PickFromGalleryButton(),
                    const ColorPickerWidget(),
                    const BlurSliderWidget(),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        context.read<CardCustomizationBloc>().add(SaveCustomization());
                      },
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
