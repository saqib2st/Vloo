// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/models/template/template_single_item_model.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/modules/textEditing/controllers/title_editing_controller.dart';



class CircularLabel extends GetView<TitleEditingController> {
  final String backgroundImage;
  RxString text = ''.obs;
  final TextStyle? labelStyle;
  final Color? bgColor;
  final TemplateSingleItemModel? templateSingleItemModel;
  final Color? textColor;

  CircularLabel(
      {super.key,
        this.labelStyle,
        required this.text,
        required this.backgroundImage,
        this.templateSingleItemModel,
        this.bgColor,
        this.textColor});

  @override
  Widget build(BuildContext context) {
    RegExp regex = RegExp(r'(\d+)|(\D+)');
    Iterable<Match> matches = regex.allMatches(text.value);

    List<String> parts = matches.map((match) => match.group(0)?? '').toList();

    return Stack(
      alignment: Alignment.center,
      children: [
        SvgPicture.asset(backgroundImage,
            width:  templateSingleItemModel?.height,
            height: templateSingleItemModel?.height,
            colorFilter: ColorFilter.mode(
                bgColor == Colors.transparent
                    ? Colors.red
                    : bgColor ?? Colors.red,
                BlendMode.srcIn),
            fit: BoxFit.contain),
        Container(
          alignment: Alignment.center,
          width:  (templateSingleItemModel?.width ?? 0)< (templateSingleItemModel?.height ?? 0)?templateSingleItemModel?.width:templateSingleItemModel?.height,
          height: templateSingleItemModel?.height,
          padding:  EdgeInsets.symmetric(horizontal: 5.sp),
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child:  (text.value.contains('.')&& (templateSingleItemModel?.currencyFormat == Strings.symbolInMiddle))?
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                    parts[0],
                    textScaler: const TextScaler.linear(1),
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize:100.sp,
                        fontStyle: FontStyle.italic,
                        color: textColor ?? Colors.white)),
                Padding(
                  padding: EdgeInsets.only(bottom: 80.h),
                  child: Text(parts[1],
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize:100.sp,
                        fontStyle: FontStyle.italic,
                        color: textColor ?? Colors.white),
                    textScaler: const TextScaler.linear(0.5),
                  ),

                ),
                Text(
                    parts[2],
                    textScaler: const TextScaler.linear(0.9),
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize:100.sp,
                        fontStyle: FontStyle.italic,
                        color: textColor ?? Colors.white)),
              ],
            )
                :
            Text(
                text.value,
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize:100.sp,
                    fontStyle: FontStyle.italic,
                    color: textColor ?? Colors.white)),
          ),
        ),
      ],
    );
  }
}

class CircularLabel2 extends GetView<TitleEditingController> {
  final String backgroundImage;
  RxString text = ''.obs;
  final TextStyle? labelStyle;
  final Color? bgColor;
  final TemplateSingleItemModel? templateSingleItemModel;
  final Color? textColor;

  CircularLabel2(
      {super.key,
        this.labelStyle,
        required this.text,
        required this.backgroundImage,
        this.templateSingleItemModel,
        this.bgColor,
        this.textColor});

  @override
  Widget build(BuildContext context) {

      RegExp regex = RegExp(r'(\d+)|(\D+)');
      Iterable<Match> matches = regex.allMatches(text.value);
      
      List<String> parts = matches.map((match) => match.group(0)?? '').toList();

    return text.isNotEmpty ?Stack(
      alignment: Alignment.center,
      children: [
        SvgPicture.asset(backgroundImage,
            width:  templateSingleItemModel?.height,
            height: templateSingleItemModel?.height,
            colorFilter: ColorFilter.mode(
                bgColor == Colors.transparent
                    ? Colors.red
                    : bgColor ?? Colors.red,
                BlendMode.srcIn),
            fit: BoxFit.contain),
        Container(
          alignment: Alignment.center,
          width:  (templateSingleItemModel?.width ?? 0)< (templateSingleItemModel?.height ?? 0)?templateSingleItemModel?.width:templateSingleItemModel?.height,
          height: templateSingleItemModel?.height,
          padding:  EdgeInsets.symmetric(horizontal: 5.sp),
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child:  ((Get.isRegistered<TitleEditingController>() && controller.selectedCurrencyFormat.value==Strings.symbolInMiddle)  && text.value.contains('.'))?
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                    parts[0],
                    textScaler: const TextScaler.linear(1),
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize:text.value.length>7?text.value.length * 0.98: (templateSingleItemModel?.fontSize ??
                            27 /
                                (text.value.length == 1
                                    ? text.value.length * 0.6
                                    : text.value.length * 0.4))
                            .sp,
                        fontStyle: FontStyle.italic,
                        color: textColor ?? Colors.white)),
                Padding(
                  padding: EdgeInsets.only(bottom: 20.h),
                  child: Text(parts[1],
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize:text.value.length>7?text.value.length * 0.98:
                        (templateSingleItemModel?.fontSize ?? 30 / 2).sp,
                        fontStyle: FontStyle.italic,
                        color: textColor ?? Colors.white),
                    textScaler: const TextScaler.linear(0.5),
                  ),

                ),
                Text(
                    parts[2],
                    textScaler: const TextScaler.linear(0.9),
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize:text.value.length>7?text.value.length * 0.98:
                        (templateSingleItemModel?.fontSize ?? 30 / 2).sp,
                        fontStyle: FontStyle.italic,
                        color: textColor ?? Colors.white)),
              ],
            )
                :
            Text(
                text.value,
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: (templateSingleItemModel?.fontSize ??
                        27 /
                            (text.value.length == 1
                                ? text.value.length * 0.6
                                : text.value.length * 0.4))
                        .sp,
                    fontStyle: FontStyle.italic,
                    color: textColor ?? Colors.white)),
          ),
        ),
      ],
    ): SvgPicture.asset(backgroundImage,
        width:  templateSingleItemModel?.height,
        height: templateSingleItemModel?.height,
        colorFilter: ColorFilter.mode(
            bgColor == Colors.transparent
                ? Colors.red
                : bgColor ?? Colors.red,
            BlendMode.srcIn),
        fit: BoxFit.contain);
  }
}

