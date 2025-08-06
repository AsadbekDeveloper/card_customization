import 'package:card_customization/features/card_customization/presentation/bloc/card_customization_bloc.dart';
import 'package:card_customization/features/card_customization/presentation/bloc/card_customization_event.dart';
import 'package:card_customization/features/card_customization/presentation/widgets/save_button.dart';
import 'package:card_customization/shared/utils/snackbar.dart';
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
  bool _isInteracting = false;

  void _setInteracting(bool value) {
    if (_isInteracting != value) {
      setState(() => _isInteracting = value);
    }
  }

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
      appBar: AppBar(title: const Text('Customize Card'), surfaceTintColor: Colors.white),
      body: SafeArea(
        child: BlocListener<CardCustomizationBloc, CardCustomizationState>(
          listener: (context, state) {
            switch (state.status) {
              case CardCustomizationStatus.loading:
                AppSnackbar.showStyledSnackBar(
                  context,
                  'Saving customization...',
                  color: Colors.blueAccent,
                );
                break;
              case CardCustomizationStatus.success:
                AppSnackbar.showStyledSnackBar(
                  context,
                  'Customization saved successfully!',
                  color: Colors.green,
                );
                break;
              case CardCustomizationStatus.failure:
                AppSnackbar.showStyledSnackBar(
                  context,
                  'Failed to save customization: ${state.errorMessage}',
                  color: Colors.redAccent,
                );
                break;
              default:
                break;
            }
          },
          child: CustomScrollView(
            physics: _isInteracting
                ? const NeverScrollableScrollPhysics()
                : const BouncingScrollPhysics(),
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverToBoxAdapter(
                  child: CardWidget(onInteractionChanged: _setInteracting),
                ),
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
