import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/models/card_customization_data.dart';
import 'card_customization_event.dart';
import 'card_customization_state.dart';

class CardCustomizationBloc extends Bloc<CardCustomizationEvent, CardCustomizationState> {
  final ImagePicker _picker = ImagePicker();

  CardCustomizationBloc() : super(CardCustomizationState(CardCustomizationData())) {
    on<PredefinedImageSelected>((event, emit) {
      emit(
        CardCustomizationState(
          CardCustomizationData(
            imagePath: event.imagePath,
            scale: state.data.scale,
            offset: state.data.offset,
            blur: state.data.blur,
          ),
        ),
      );
    });

    on<ImagePicked>((event, emit) async {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        emit(
          CardCustomizationState(
            CardCustomizationData(
              imageFile: File(pickedFile.path),
              scale: state.data.scale,
              offset: state.data.offset,
              blur: state.data.blur,
            ),
          ),
        );
      }
    });

    on<ScaleUpdated>((event, emit) {
      emit(
        CardCustomizationState(
          CardCustomizationData(
            imagePath: state.data.imagePath,
            imageFile: state.data.imageFile,
            color1: state.data.color1,
            color2: state.data.color2,
            scale: event.scale,
            offset: state.data.offset,
            blur: state.data.blur,
          ),
        ),
      );
    });

    on<PositionUpdated>((event, emit) {
      emit(
        CardCustomizationState(
          CardCustomizationData(
            imagePath: state.data.imagePath,
            imageFile: state.data.imageFile,
            color1: state.data.color1,
            color2: state.data.color2,
            scale: state.data.scale,
            offset: event.offset,
            blur: state.data.blur,
          ),
        ),
      );
    });

    on<ColorChanged>((event, emit) {
      emit(
        CardCustomizationState(
          CardCustomizationData(
            color1: event.color1,
            color2: event.color2,
            scale: state.data.scale,
            offset: state.data.offset,
            blur: state.data.blur,
          ),
        ),
      );
    });

    on<BlurChanged>((event, emit) {
      emit(
        CardCustomizationState(
          CardCustomizationData(
            imagePath: state.data.imagePath,
            imageFile: state.data.imageFile,
            color1: state.data.color1,
            color2: state.data.color2,
            scale: state.data.scale,
            offset: state.data.offset,
            blur: event.blur,
          ),
        ),
      );
    });
  }
}
