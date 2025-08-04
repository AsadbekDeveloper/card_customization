import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/card_customization_bloc.dart';
import '../bloc/card_customization_event.dart';
import '../bloc/card_customization_state.dart';

class CardWidget extends StatefulWidget {
  const CardWidget({super.key});

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  late double _scale;
  late Offset _offset;

  @override
  void initState() {
    super.initState();
    _scale = context.read<CardCustomizationBloc>().state.data.scale;
    _offset = context.read<CardCustomizationBloc>().state.data.offset;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CardCustomizationBloc, CardCustomizationState>(
      listener: (context, state) {
        _scale = state.data.scale;
        _offset = state.data.offset;
      },
      builder: (context, state) {
        return AspectRatio(
          aspectRatio: 16 / 9,
          child: GestureDetector(
            onScaleStart: (details) {
              _scale = state.data.scale;
              _offset = state.data.offset;
            },
            onScaleUpdate: (details) {
              final deltaScale = (details.scale - 1) * 0.2;
              final newScale = (_scale + deltaScale).clamp(0.5, 3.0);

              context.read<CardCustomizationBloc>().add(ScaleUpdated(newScale));
              context.read<CardCustomizationBloc>().add(
                PositionUpdated(_offset + details.focalPointDelta),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ColoredBox(color: Colors.grey),
                  Container(
                    decoration: BoxDecoration(
                      gradient:
                          state.data.imageFile == null &&
                              state.data.imagePath == null &&
                              state.data.color1 != null
                          ? LinearGradient(
                              colors: [state.data.color1!, state.data.color2 ?? state.data.color1!],
                            )
                          : null,
                      color:
                          state.data.imageFile == null &&
                              state.data.imagePath == null &&
                              state.data.color1 == null
                          ? Colors.grey
                          : null,
                    ),
                    child: (state.data.imageFile != null || state.data.imagePath != null)
                        ? Transform(
                            transform: Matrix4.identity()
                              ..translate(state.data.offset.dx, state.data.offset.dy)
                              ..scale(state.data.scale),
                            child: Image(
                              image:
                                  (state.data.imageFile != null
                                          ? FileImage(state.data.imageFile!)
                                          : AssetImage(state.data.imagePath!))
                                      as ImageProvider,
                              fit: BoxFit.cover,
                            ),
                          )
                        : null,
                  ),

                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: state.data.blur, sigmaY: state.data.blur),
                    child: Container(color: Colors.black12),
                  ),
                  Positioned(
                    top: 24,
                    left: 24,
                    child: Icon(Icons.credit_card, color: Colors.white70, size: 36),
                  ),
                  Positioned(
                    bottom: 60,
                    left: 24,
                    child: Text(
                      '1234 5678 9012 3456',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        letterSpacing: 2,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 28,
                    left: 24,
                    child: Text(
                      'CARDHOLDER NAME',
                      style: TextStyle(color: Colors.white70, fontSize: 14, letterSpacing: 1),
                    ),
                  ),
                  Positioned(
                    bottom: 28,
                    right: 24,
                    child: Text('08/29', style: TextStyle(color: Colors.white70, fontSize: 14)),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
