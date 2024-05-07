import 'package:flutter/material.dart';
import 'package:vloo/app/data/configs/text.dart';

class ClickableText extends StatelessWidget {
  final void Function()? onPressed;
  final String name;
  final bool underline;
  final TextStyle? style;

  const ClickableText(
      {Key? key,
      this.onPressed,
      required this.name,
      this.underline = false,
      this.style})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Text(
        name,
        style: style ?? CustomTextStyle.font12R,
      ),
    );
  }
}
