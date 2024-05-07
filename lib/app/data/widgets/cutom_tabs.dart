import 'package:flutter/material.dart';
import 'package:vloo/app/data/configs/sizing.dart';

class CustomTab extends StatelessWidget {
  final Widget icon;
  final String text;

  const CustomTab({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
           SizedBox(width: 5.w),
          Text(text),
        ],
      ),
    );
  }
}
