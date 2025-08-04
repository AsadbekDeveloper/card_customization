abstract class CardCustomizationEvent {}

class PredefinedImageSelected extends CardCustomizationEvent {
  final String imagePath;

  PredefinedImageSelected(this.imagePath);
}

class ImagePicked extends CardCustomizationEvent {}
