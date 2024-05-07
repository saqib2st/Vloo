import 'package:flutter/material.dart';
import 'package:vloo/app/data/configs/sizing.dart';

class TextTabs extends StatelessWidget {
  final Color color;
  final TextStyle titleStyle;
  final String title;
  final VoidCallback? onPressed;
  final double? height, width;
  final Widget? icon;
  final bool trailing;
  final BoxDecoration? boxDecoration;
  final EdgeInsets? margin;
  const TextTabs(
      {super.key,
      required this.color,
      required this.title,
      this.onPressed,
      this.height,
      this.width,
      this.trailing = true,
      this.boxDecoration,
      required this.titleStyle,
      this.icon,
      this.margin});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: height == null
            ? const EdgeInsets.symmetric(horizontal: 10, vertical: 5)
            : null,
        margin: margin ?? EdgeInsets.all(5.w),
        height: height,
        width: width,
        decoration: boxDecoration ??
            BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
            ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!trailing)
              if (icon != null)
                Row(
                  children: [
                    icon!,
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
            Text(
              title,
              style: titleStyle,
            ),
            if (trailing)
              if (icon != null)
                Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    icon!,
                  ],
                ),
          ],
        ),
      ),
    );
  }
}
