import 'package:flutter/material.dart';

class SholatUtilities {
  static BoxShadow sholatBoxShadow = const BoxShadow(
    spreadRadius: 1,
    blurRadius: 3,
    offset: Offset(0, 1),
    color: Color(0x10000000),
  );

  static TextStyle textStyling({required double size, Color? color}) {
    return TextStyle(
      color: color,
      fontSize: size,
      fontWeight: FontWeight.w500,
      fontFamily: 'Roboto',
    );
  }
}
