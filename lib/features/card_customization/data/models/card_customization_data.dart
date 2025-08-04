import 'dart:io';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class CardCustomizationData extends Equatable {
  final String? imagePath;
  final File? imageFile;
  final double scale;
  final Offset offset;
  final Color? color1;
  final Color? color2;
  final double blur;

  const CardCustomizationData({
    this.imagePath,
    this.imageFile,
    this.scale = 1.0,
    this.offset = Offset.zero,
    this.color1,
    this.color2,
    this.blur = 0.0,
  });

  @override
  List<Object?> get props =>
      [imagePath, imageFile, scale, offset, color1, color2, blur];
}
