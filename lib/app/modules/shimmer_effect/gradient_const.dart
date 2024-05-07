import 'package:flutter/material.dart';

class GradienConstants {
  static const linearGradient = LinearGradient(
    colors: [
      Color(0xFFF2F4F6),
      Color(0xffffffff),
      Color(0xFFF2F4F6),
    ],
    stops: [
      0.1,
      0.3,
      0.4,
    ],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
    tileMode: TileMode.clamp,
  );
}
