// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/models/template/template_single_item_model.dart';
import 'package:vloo/app/modules/textEditing/controllers/title_editing_controller.dart';

import '../../../../data/utils/strings.dart';

class RectangleLabel extends GetView<TitleEditingController> {
  final String backgroundImage;
  RxString text = ''.obs;
  final TextStyle? labelStyle;
  final Color? bgColor;
  final TemplateSingleItemModel? templateSingleItemModel;
  final Color? textColor;

  RectangleLabel({super.key, required this.text, this.labelStyle, required this.backgroundImage, this.templateSingleItemModel, this.bgColor, this.textColor});

  @override
  Widget build(BuildContext context) {
    RegExp regex = RegExp(r'(\d+)|(\D+)');
    Iterable<Match> matches = regex.allMatches(text.value);

    List<String> parts = matches.map((match) => match.group(0)?? '').toList();
    return Stack(
      alignment: Alignment.center,
      children: [
        SvgPicture.asset(
          backgroundImage,
          colorFilter: ColorFilter.mode(bgColor == Colors.transparent ? Colors.amber : bgColor ?? Colors.amber, BlendMode.srcIn),
          fit: BoxFit.fitWidth,
          width: templateSingleItemModel?.height,
          height: templateSingleItemModel?.height,
        ),
        Container(
          alignment: Alignment.center,
          width:  (templateSingleItemModel?.width ?? 0)> (templateSingleItemModel?.height ?? 0)?templateSingleItemModel?.height:templateSingleItemModel?.height,
          height: templateSingleItemModel?.height,
          padding: EdgeInsets.symmetric(horizontal: 7.w),
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: (text.value.contains('.')&& (templateSingleItemModel?.currencyFormat == Strings.symbolInMiddle ))?
            Row(
              children: [
                Text( parts[0],
                    style: labelStyle?.copyWith(color: textColor ?? Colors.white) ??
                        TextStyle(fontWeight: FontWeight.w900, fontSize: 100.sp, fontStyle: FontStyle.italic, color: textColor ?? Colors.white)),
                Text(parts[1] ,
                    style: labelStyle?.copyWith(color: textColor ?? Colors.black) ??
                        TextStyle(fontWeight: FontWeight.w900, fontSize: 100.sp, fontStyle: FontStyle.italic, color: textColor ?? Colors.white)),
                Text(parts[2],
                    style: labelStyle?.copyWith( color: textColor ?? Colors.white) ??
                        TextStyle(fontWeight: FontWeight.w900, fontSize:100.sp, fontStyle: FontStyle.italic, color: textColor ?? Colors.white)),
              ],
            ): Text( text.value,
                style: labelStyle?.copyWith(color: textColor,fontSize: 100.sp) ??
                    TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 100.sp,
                        color: textColor ?? Colors.black)),
          ),
        ),
      ],
    );
  }
}


class RectangleLabel2 extends GetView<TitleEditingController> {
  final String backgroundImage;
  RxString text = ''.obs;
  final TextStyle? labelStyle;
  final Color? bgColor;
  final TemplateSingleItemModel? templateSingleItemModel;
  final Color? textColor;

  RectangleLabel2({super.key, required this.text, this.labelStyle, required this.backgroundImage, this.templateSingleItemModel, this.bgColor, this.textColor});

  @override
  Widget build(BuildContext context) {

    RegExp regex = RegExp(r'(\d+)|(\D+)');
    Iterable<Match> matches = regex.allMatches(text.value);

    List<String> parts = matches.map((match) => match.group(0)?? '').toList();

    return text.isNotEmpty? Stack(
      alignment: Alignment.center,
      children: [
        SvgPicture.asset(
          backgroundImage,
          colorFilter: ColorFilter.mode(bgColor == Colors.transparent ? Colors.amber : bgColor ?? Colors.amber, BlendMode.srcIn),
          fit: BoxFit.contain,
          width: templateSingleItemModel?.width,
          height: templateSingleItemModel?.height,
        ),
        ((Get.isRegistered<TitleEditingController>() && controller.selectedCurrencyFormat.value==Strings.symbolInMiddle)&& text.value.contains('.'))?
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text( parts[0],
                style: labelStyle?.copyWith(color: textColor ?? Colors.white) ??
                    TextStyle(fontWeight: FontWeight.w900, fontSize: text.value.length < 5
                        ? 40.sp
                        : text.value.length < 6
                        ? 35.sp
                        :text.value.length < 9? 20.sp:15, fontStyle: FontStyle.italic, color: textColor ?? Colors.white)),
            Text(parts[1] ,
                style: labelStyle?.copyWith(color: textColor ?? Colors.black) ??
                    TextStyle(fontWeight: FontWeight.w900, fontSize: text.value.length < 5
                        ? 40.sp
                        : text.value.length < 6
                        ? 35.sp
                        :text.value.length < 9? 20.sp:15, fontStyle: FontStyle.italic, color: textColor ?? Colors.white)),
            Text(parts[2],
                style: labelStyle?.copyWith( color: textColor ?? Colors.white) ??
                    TextStyle(fontWeight: FontWeight.w900, fontSize: text.value.length < 5
                        ? 40.sp
                        : text.value.length < 6
                        ? 35.sp
                        :text.value.length < 9? 20.sp:15, fontStyle: FontStyle.italic, color: textColor ?? Colors.white)),
          ],
        ): Text( text.value,
            style: labelStyle?.copyWith(color: textColor,fontSize: 100.sp) ??
            TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: text.value.length < 5
                        ? 40.sp
                        : text.value.length < 6
                            ? 35.sp
                            :text.value.length < 9? 20.sp:15,
                    fontStyle: FontStyle.italic,
            color: textColor ?? Colors.black)),
      ],
    ):SvgPicture.asset(
      backgroundImage,
      colorFilter: ColorFilter.mode(bgColor == Colors.transparent ? Colors.amber : bgColor ?? Colors.amber, BlendMode.srcIn),
      fit: BoxFit.contain,
      width: templateSingleItemModel?.width,
      height: templateSingleItemModel?.height,
    );
  }
}
