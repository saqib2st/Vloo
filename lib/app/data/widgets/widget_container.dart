import 'package:flutter/material.dart';

class WidgetContainer extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? color;
  final double? height, width;
  final Widget child;
  final EdgeInsets? padding, margin;
  final BorderRadius? borderRadius;
  final BoxShape shape;
  const WidgetContainer(
      {super.key,
      this.onPressed,
      this.color,
      this.height,
      this.width,
      required this.child,
      this.borderRadius,
      this.padding,
      this.margin,
      this.shape = BoxShape.rectangle});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        margin: margin,
        padding:
            padding ?? const EdgeInsets.symmetric(vertical: 6, horizontal: 9),
        decoration: BoxDecoration(
            shape: shape,
            borderRadius: shape == BoxShape.rectangle
                ? borderRadius ?? BorderRadius.circular(7)
                : null,
            color: color ?? Colors.white),
        child: child,
      ),
    );
  }
}
