import 'dart:ui';

import 'package:flutter/cupertino.dart';

class CustomTheme {
  const CustomTheme();

  static const Color loginGradientStart = Color(0xFF2BC0E4);
  static const Color loginGradientEnd = Color(0xFF3CD3AD);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: <Color>[loginGradientStart, loginGradientEnd],
    stops: <double>[0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
