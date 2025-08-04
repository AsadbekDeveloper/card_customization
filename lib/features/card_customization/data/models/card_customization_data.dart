import 'dart:io';

class CardCustomizationData {
  final String? imagePath;
  final File? imageFile;

  const CardCustomizationData({this.imagePath, this.imageFile});

  CardCustomizationData copyWith({String? imagePath, File? imageFile}) {
    return CardCustomizationData(
      imagePath: imagePath ?? this.imagePath,
      imageFile: imageFile ?? this.imageFile,
    );
  }
}
