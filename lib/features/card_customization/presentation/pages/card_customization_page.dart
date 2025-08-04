import 'package:card_customization/features/card_customization/presentation/bloc/card_customization_bloc.dart';
import 'package:card_customization/features/card_customization/presentation/bloc/card_customization_event.dart';
import 'package:card_customization/features/card_customization/presentation/widgets/save_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/card_widget.dart';
import '../widgets/apperance_controls.dart';
import '../widgets/image_grid_widget.dart';
import '../bloc/card_customization_state.dart';

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
      body: SafeArea(
        child: BlocListener<CardCustomizationBloc, CardCustomizationState>(
          listener: (context, state) {
            final messenger = ScaffoldMessenger.of(context);

            void showStyledSnackBar(String message, {Color? color}) {
              messenger.clearSnackBars();
              messenger.showSnackBar(
                SnackBar(
                  content: Text(
                    message,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                  backgroundColor: color ?? Colors.grey[900],
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  duration: const Duration(seconds: 2),
                ),
              );
            }

            switch (state.status) {
              case CardCustomizationStatus.loading:
                showStyledSnackBar('Saving customization...', color: Colors.blueAccent);
                break;
              case CardCustomizationStatus.success:
                showStyledSnackBar('Customization saved successfully!', color: Colors.green);
                break;
              case CardCustomizationStatus.failure:
                showStyledSnackBar(
                  'Failed to save customization: ${state.errorMessage}',
                  color: Colors.redAccent,
                );
                break;
              default:
                break;
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
                      const SizedBox(height: 10),
                      const AppearanceControlsWidget(),
                      const SizedBox(height: 10),
                      SaveButton(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
