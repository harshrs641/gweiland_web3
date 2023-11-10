import 'package:flutter/material.dart';

class CryptoColors {
  static const Color green = Color(0xFF00CE08);
  static const Color red = Color(0xFFFF3D00);
  static  Color grey = const Color(0xFF0B0B0B).withOpacity(.3);

  static Color getPercentColor(double? percentage) {
    if (percentage == null || percentage == 0 || percentage > 0.0) return green;
    return red;
  }
}
