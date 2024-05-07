import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/models/template/template_single_item_model.dart';
import 'package:vloo/app/modules/textEditing/controllers/title_editing_controller.dart';

class RectangleLabelRounded extends GetView<TitleEditingController> {
  final String backgroundImage;
  RxString text = ''.obs;
  final TextStyle? labelStyle;
  final Color? bgColor;
  final Color? textColor;
  final TemplateSingleItemModel? templateSingleItemModel;
  RectangleLabelRounded(
      {super.key,
      required this.backgroundImage,
      required this.text,
      this.labelStyle,
      this.templateSingleItemModel,
      this.bgColor,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SvgPicture.asset(backgroundImage,
            colorFilter: ColorFilter.mode(
                bgColor == Colors.transparent
                    ? Colors.red
                    : bgColor ?? Colors.red,
                BlendMode.srcIn),
            width: templateSingleItemModel?.width,
            height: templateSingleItemModel?.height,
            fit: BoxFit.contain),
        Container(
          alignment: Alignment.center,
          width:  (templateSingleItemModel?.width ?? 0)> (templateSingleItemModel?.height ?? 0)?templateSingleItemModel?.height:templateSingleItemModel?.width,
          height: templateSingleItemModel?.height,
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Transform.rotate(
              angle: 6.1,
              child: Text(
                  text.value,
                    style: labelStyle ??
                        TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize:150.sp,
                            fontStyle: FontStyle.italic,
                            color: textColor ?? Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}



class RectangleLabelRoundedTitle extends GetView<TitleEditingController> {
  final String backgroundImage;
  RxString text = ''.obs;
  final TextStyle? labelStyle;
  final Color? bgColor;
  final Color? textColor;
  final TemplateSingleItemModel? templateSingleItemModel;
  RectangleLabelRoundedTitle(
      {super.key,
      required this.backgroundImage,
      required this.text,
      this.labelStyle,
      this.templateSingleItemModel,
      this.bgColor,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SvgPicture.asset(backgroundImage,
            colorFilter: ColorFilter.mode(
                bgColor == Colors.transparent
                    ? Colors.red
                    : bgColor ?? Colors.red,
                BlendMode.srcIn),
            width: templateSingleItemModel?.width,
            height: templateSingleItemModel?.height,
            fit: BoxFit.contain),
        Transform.rotate(
          angle: 6.1,
          child: Text(
              text.value ,
                style: labelStyle ??
                    TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize:text.value.length<5?45.sp:
                        text.value.length<=7?40.sp:
                        28.sp,
                        fontStyle: FontStyle.italic,
                        color: textColor ?? Colors.white),
          ),
        ),
      ],
    );
  }
}
