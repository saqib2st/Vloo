import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ClickableIcon extends StatelessWidget {
  final String iconPath;
  final Color? color;
  final double? height;
  final EdgeInsets? padding;
  final VoidCallback? onPressed;
  const ClickableIcon({
    Key? key,
    required this.iconPath,
    this.onPressed,
    this.color,
    this.height,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: padding,
        color: Colors.transparent,
        child: SvgPicture.asset(
          iconPath,
          height: height,
          fit: BoxFit.scaleDown,
          placeholderBuilder: (BuildContext context) => Container(
              padding: const EdgeInsets.all(30.0),
              child: const CircularProgressIndicator()),
          colorFilter:
              color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
        ),
      ),
    );
  }
}
