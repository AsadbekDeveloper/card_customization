import 'dart:io';
import 'package:bloc_test/bloc_test.dart';
import 'package:card_customization/features/card_customization/data/models/card_customization_data.dart';
import 'package:card_customization/features/card_customization/domain/usecases/save_card_customization.dart';
import 'package:card_customization/features/card_customization/presentation/bloc/card_customization_bloc.dart';
import 'package:card_customization/features/card_customization/presentation/bloc/card_customization_event.dart';
import 'package:card_customization/features/card_customization/presentation/bloc/card_customization_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';

class MockSaveCardCustomization extends Mock implements SaveCardCustomization {}

class MockImagePicker extends Mock implements ImagePicker {}

class MockXFile extends Mock implements XFile {}

void main() {
  late MockSaveCardCustomization mockSaveCardCustomization;
  late MockImagePicker mockImagePicker;
  late CardCustomizationBloc cardCustomizationBloc;

  setUpAll(() {
    registerFallbackValue(CardCustomizationData());
    registerFallbackValue(ImageSource.gallery);
    registerFallbackValue(File(''));
    registerFallbackValue(const Offset(0, 0));
  });

  setUp(() {
    mockSaveCardCustomization = MockSaveCardCustomization();
    mockImagePicker = MockImagePicker();
    cardCustomizationBloc = CardCustomizationBloc(
      mockSaveCardCustomization,
      imagePicker: mockImagePicker,
    );
  });

  tearDown(() {
    cardCustomizationBloc.close();
  });

  group('CardCustomizationBloc', () {
    test('initial state is CardCustomizationState.initial', () {
      expect(
        cardCustomizationBloc.state,
        const CardCustomizationState(data: CardCustomizationData()),
      );
    });

    blocTest<CardCustomizationBloc, CardCustomizationState>(
      'emits [initial] when PredefinedImageSelected is added',
      build: () => cardCustomizationBloc,
      act: (bloc) => bloc.add(PredefinedImageSelected('assets/images/image1.jpg')),
      expect: () => [
        const CardCustomizationState(
          data: CardCustomizationData(imagePath: 'assets/images/image1.jpg'),
        ),
      ],
    );

    blocTest<CardCustomizationBloc, CardCustomizationState>(
      'emits [initial] with imageFile when ImagePicked is added and image is picked',
      build: () {
        final mockXFile = MockXFile();
        when(() => mockXFile.path).thenReturn('path/to/image.jpg');
        when(
          () => mockImagePicker.pickImage(source: ImageSource.gallery),
        ).thenAnswer((_) async => mockXFile);
        return cardCustomizationBloc;
      },
      act: (bloc) => bloc.add(ImagePicked()),
      expect: () => [
        CardCustomizationState(data: CardCustomizationData(imageFile: File('path/to/image.jpg'))),
      ],
    );

    blocTest<CardCustomizationBloc, CardCustomizationState>(
      'does not emit anything when ImagePicked is added and no image is picked',
      build: () {
        when(
          () => mockImagePicker.pickImage(source: ImageSource.gallery),
        ).thenAnswer((_) async => null);
        return cardCustomizationBloc;
      },
      act: (bloc) => bloc.add(ImagePicked()),
      expect: () => [],
    );

    blocTest<CardCustomizationBloc, CardCustomizationState>(
      'emits [initial] when ScaleUpdated is added',
      build: () => cardCustomizationBloc,
      act: (bloc) => bloc.add(ScaleUpdated(2.0)),
      expect: () => [const CardCustomizationState(data: CardCustomizationData(scale: 2.0))],
    );

    blocTest<CardCustomizationBloc, CardCustomizationState>(
      'emits [initial] when PositionUpdated is added',
      build: () => cardCustomizationBloc,
      act: (bloc) => bloc.add(PositionUpdated(const Offset(10, 20))),
      expect: () => [
        const CardCustomizationState(data: CardCustomizationData(offset: Offset(10, 20))),
      ],
    );

    blocTest<CardCustomizationBloc, CardCustomizationState>(
      'emits [initial] when ColorChanged is added',
      build: () => cardCustomizationBloc,
      act: (bloc) => bloc.add(ColorChanged(Colors.red, color2: Colors.blue)),
      expect: () => [
        const CardCustomizationState(
          data: CardCustomizationData(color1: Colors.red, color2: Colors.blue),
        ),
      ],
    );

    blocTest<CardCustomizationBloc, CardCustomizationState>(
      'emits [initial] when BlurChanged is added',
      build: () => cardCustomizationBloc,
      act: (bloc) => bloc.add(BlurChanged(5.0)),
      expect: () => [const CardCustomizationState(data: CardCustomizationData(blur: 5.0))],
    );

    blocTest<CardCustomizationBloc, CardCustomizationState>(
      'emits [loading, success, initial] when SaveCustomization is added and successful',
      build: () {
        when(() => mockSaveCardCustomization(any())).thenAnswer((_) async => Future.value());
        return cardCustomizationBloc;
      },
      act: (bloc) => bloc.add(SaveCustomization()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        const CardCustomizationState(
          data: CardCustomizationData(),
          status: CardCustomizationStatus.loading,
        ),
        const CardCustomizationState(
          data: CardCustomizationData(),
          status: CardCustomizationStatus.success,
        ),
        const CardCustomizationState(
          data: CardCustomizationData(),
          status: CardCustomizationStatus.initial,
        ),
      ],
      verify: (_) {
        verify(() => mockSaveCardCustomization(any())).called(1);
      },
    );

    blocTest<CardCustomizationBloc, CardCustomizationState>(
      'emits [loading, failure, initial] when SaveCustomization is added and fails',
      build: () {
        when(() => mockSaveCardCustomization(any())).thenThrow(Exception('Save failed'));
        return cardCustomizationBloc;
      },
      act: (bloc) => bloc.add(SaveCustomization()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        const CardCustomizationState(
          data: CardCustomizationData(),
          status: CardCustomizationStatus.loading,
        ),
        const CardCustomizationState(
          data: CardCustomizationData(),
          status: CardCustomizationStatus.failure,
          errorMessage: 'Exception: Save failed',
        ),
        const CardCustomizationState(
          data: CardCustomizationData(),
          status: CardCustomizationStatus.initial,
        ),
      ],
      verify: (_) {
        verify(() => mockSaveCardCustomization(any())).called(1);
      },
    );
  });
}
