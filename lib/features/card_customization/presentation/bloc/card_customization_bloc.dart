import 'dart:io';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/models/card_customization_data.dart';
import 'card_customization_event.dart';
import 'card_customization_state.dart';

class CardCustomizationBloc
    extends Bloc<CardCustomizationEvent, CardCustomizationState> {
  final ImagePicker _picker = ImagePicker();

  CardCustomizationBloc()
      : super(CardCustomizationState(CardCustomizationData(
          imagePath:
              'assets/images/image${Random().nextInt(5) + 1}.jpg',
        ))) {
    on<PredefinedImageSelected>((event, emit) {
      emit(CardCustomizationState(
          state.data.copyWith(imagePath: event.imagePath, imageFile: null)));
    });

    on<ImagePicked>((event, emit) async {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        emit(CardCustomizationState(state.data
            .copyWith(imageFile: File(pickedFile.path), imagePath: null)));
      }
    });
  }
}
