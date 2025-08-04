import 'dart:typed_data';
import 'package:card_customization/features/card_customization/data/models/card_customization_data.dart';
import 'package:card_customization/features/card_customization/domain/repositories/card_customization_repository.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class SaveCardCustomization {
  final CardCustomizationRepository repository;

  SaveCardCustomization(this.repository);

  Future<void> call(CardCustomizationData data) async {
    Uint8List? compressedImageBytes;
    if (data.imageFile != null) {
      compressedImageBytes = await FlutterImageCompress.compressWithFile(
        data.imageFile!.path,
        minWidth: 1000,
        minHeight: 1000,
        quality: 85,
      );
    }

    await repository.saveCustomization(
      data: data,
      compressedImageBytes: compressedImageBytes,
    );
  }
}
