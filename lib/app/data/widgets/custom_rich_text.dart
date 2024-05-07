import 'package:flutter/material.dart';

class CustomRichText extends StatelessWidget {
  final String? title;
  final String? discription;
  final String? boldText;
  final TextStyle textStyle;
  final TextStyle textStyle2;
  final TextStyle? textStyle3;
  final TextAlign? textAlign;
  const CustomRichText(
      {super.key, this.title, this.discription, required this.textStyle, required this.textStyle2, this.textAlign, this.boldText, this.textStyle3});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 15),
      child: RichText(
        textAlign: textAlign?? TextAlign.start  ,
          text: TextSpan(
              text: '$title ',
              style: textStyle,
              children: [TextSpan(text: discription, style: textStyle2) , TextSpan(text: boldText, style: textStyle3)])),
    );
  }
}
