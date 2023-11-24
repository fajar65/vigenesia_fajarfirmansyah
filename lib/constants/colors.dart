import 'dart:math';

import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xff0085FF);
}

Color getRandomPastelColorWithOpacity(Opacity? opacity) {
  Random random = Random();
  // Generate somewhat high values for RGB components for a pastel color
  int r = random.nextInt(156) + 100; // 100 to 255
  int g = random.nextInt(156) + 100; // 100 to 255
  int b = random.nextInt(156) + 100; // 100 to 255

  // Set the opacity to 20%
  double opacity = 0.20;

  return Color.fromRGBO(r, g, b, opacity);
}
