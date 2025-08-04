import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/models/card_customization_data.dart';
import '../../domain/usecases/save_card_customization.dart';
import 'card_customization_event.dart';
import 'card_customization_state.dart';

class CardCustomizationBloc extends Bloc<CardCustomizationEvent, CardCustomizationState> {
  final ImagePicker _picker = ImagePicker();
  final SaveCardCustomization _saveCardCustomization;

  CardCustomizationBloc(this._saveCardCustomization)
    : super(const CardCustomizationState(data: CardCustomizationData())) {
    on<PredefinedImageSelected>((event, emit) {
      emit(
        state.copyWith(
          data: CardCustomizationData(
            imagePath: event.imagePath,
            scale: state.data.scale,
            offset: state.data.offset,
            blur: state.data.blur,
          ),
          status: CardCustomizationStatus.initial,
          errorMessage: null,
        ),
      );
    });

    on<ImagePicked>((event, emit) async {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        emit(
          state.copyWith(
            data: CardCustomizationData(
              imageFile: File(pickedFile.path),
              scale: state.data.scale,
              offset: state.data.offset,
              blur: state.data.blur,
            ),
            status: CardCustomizationStatus.initial,
            errorMessage: null,
          ),
        );
      }
    });

    on<ScaleUpdated>((event, emit) {
      emit(
        state.copyWith(
          data: CardCustomizationData(
            imagePath: state.data.imagePath,
            imageFile: state.data.imageFile,
            color1: state.data.color1,
            color2: state.data.color2,
            scale: event.scale,
            offset: state.data.offset,
            blur: state.data.blur,
          ),
          status: CardCustomizationStatus.initial,
          errorMessage: null,
        ),
      );
    });

    on<PositionUpdated>((event, emit) {
      emit(
        state.copyWith(
          data: CardCustomizationData(
            imagePath: state.data.imagePath,
            imageFile: state.data.imageFile,
            color1: state.data.color1,
            color2: state.data.color2,
            scale: state.data.scale,
            offset: event.offset,
            blur: state.data.blur,
          ),
          status: CardCustomizationStatus.initial,
          errorMessage: null,
        ),
      );
    });

    on<ColorChanged>((event, emit) {
      emit(
        state.copyWith(
          data: CardCustomizationData(
            color1: event.color1,
            color2: event.color2,
            scale: state.data.scale,
            offset: state.data.offset,
            blur: state.data.blur,
          ),
          status: CardCustomizationStatus.initial,
          errorMessage: null,
        ),
      );
    });

    on<BlurChanged>((event, emit) {
      emit(
        state.copyWith(
          data: CardCustomizationData(
            imagePath: state.data.imagePath,
            imageFile: state.data.imageFile,
            color1: state.data.color1,
            color2: state.data.color2,
            scale: state.data.scale,
            offset: state.data.offset,
            blur: event.blur,
          ),
          status: CardCustomizationStatus.initial,
          errorMessage: null,
        ),
      );
    });

    on<SaveCustomization>((event, emit) async {
      emit(state.copyWith(status: CardCustomizationStatus.loading));
      try {
        await _saveCardCustomization(state.data);
        emit(state.copyWith(status: CardCustomizationStatus.success));
        await Future.delayed(const Duration(milliseconds: 500));
        emit(state.copyWith(status: CardCustomizationStatus.initial, errorMessage: null));
      } catch (e) {
        emit(state.copyWith(status: CardCustomizationStatus.failure, errorMessage: e.toString()));
        await Future.delayed(const Duration(milliseconds: 500));
        emit(state.copyWith(status: CardCustomizationStatus.initial, errorMessage: null));
      }
    });
  }
}
