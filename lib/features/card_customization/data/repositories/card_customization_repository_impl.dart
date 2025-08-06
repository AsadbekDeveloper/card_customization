import 'dart:typed_data';
import 'package:card_customization/features/card_customization/data/models/card_customization_data.dart';
import 'package:card_customization/features/card_customization/domain/repositories/card_customization_repository.dart';
import 'package:flutter/widgets.dart';

class CardCustomizationRepositoryImpl implements CardCustomizationRepository {
  @override
  Future<void> saveCustomization({
    required CardCustomizationData data,
    Uint8List? compressedImageBytes,
  }) async {
    final mockPayload = {
      'blur': data.blur,
      'color1': data.color1?.value.toRadixString(16),
      'color2': data.color2?.value.toRadixString(16),
      'hasImage': compressedImageBytes != null,
      'imageBytesLength': compressedImageBytes?.lengthInBytes,
    };

    await Future.delayed(const Duration(seconds: 2));

    debugPrint('🔁 Sending mock customization payload:');
    debugPrint(mockPayload.toString());

    final isSuccess = true;

    if (isSuccess) {
      debugPrint('✅ Customization "saved" successfully (mock).');
    } else {
      debugPrint('❌ Failed to "save" customization (mock).');
      throw Exception('Mock API save failed');
    }
  }
}
