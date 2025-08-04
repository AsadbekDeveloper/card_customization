import 'dart:typed_data';
import 'package:card_customization/features/card_customization/data/models/card_customization_data.dart';

abstract class CardCustomizationRepository {
  Future<void> saveCustomization({
    required CardCustomizationData data,
    Uint8List? compressedImageBytes,
  });
}
