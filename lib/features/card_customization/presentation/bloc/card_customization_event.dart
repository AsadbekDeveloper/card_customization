import 'package:flutter/material.dart';

abstract class CardCustomizationEvent  {}

class PredefinedImageSelected extends CardCustomizationEvent {
  final String imagePath;

  PredefinedImageSelected(this.imagePath);
}

class ImagePicked extends CardCustomizationEvent {}

class ScaleUpdated extends CardCustomizationEvent {
  final double scale;

  ScaleUpdated(this.scale);
}

class PositionUpdated extends CardCustomizationEvent {
  final Offset offset;

  PositionUpdated(this.offset);
}

class ColorChanged extends CardCustomizationEvent {
  final Color color1;
  final Color? color2;

  ColorChanged(this.color1, {this.color2});
}

class BlurChanged extends CardCustomizationEvent {
  final double blur;

  BlurChanged(this.blur);
}
