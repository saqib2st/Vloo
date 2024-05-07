import 'package:flutter/material.dart';
import 'package:vloo/app/data/configs/sizing.dart';

class MatchCards extends StatelessWidget {
  final Color color;
  const MatchCards({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 16.w,
      width: 11.w,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(2), color: color),
    );
  }
}
