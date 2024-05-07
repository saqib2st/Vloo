import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/configs/text.dart';
import 'package:vloo/app/data/utils/static_assets.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/modules/templates/controllers/templates_controller.dart';

class LayerListItemView extends GetView<TemplatesController> {
  final String? heading;
  final String? value;
  final String? iconPath;
  final bool isSelected;

  const LayerListItemView({
    super.key,
    this.heading,
    this.value,
    this.iconPath,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
      decoration: BoxDecoration(
        color: isSelected
            ? AppColor.appSkyBlue.withOpacity(0.3)
            : AppColor.primaryColor.withOpacity(0.5),
        border: Border.all(width: 1, color: AppColor.appLightBlue),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset(
            iconPath ?? "",
            height: 30.w,
            width: 30.w,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            "$heading :" ?? ":",
            style: CustomTextStyle.font16R.copyWith(
                color: AppColor.appLightBlue, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            width: 10,
          ),
          if (heading != "Image")
            Expanded(
              child: Text(
                value ?? "",
                textAlign: TextAlign.center,
                style: CustomTextStyle.font16R.copyWith(
                    color: AppColor.appLightBlue, fontWeight: FontWeight.w400),
              ),
            )
          else
            Expanded(
                child: Image.network(value!,
                    fit: BoxFit.fitHeight, width: 50, height: 40)),

          /* Expanded(
            child: TextField(
              autofocus: false,
              controller: TextEditingController(text: value),
              readOnly: true,
              textAlign: TextAlign.start,
              maxLines: 1,
              enableSuggestions: true,
              style: CustomTextStyle.font16R.copyWith(
                */ /*shadows: [
                    Shadow(
                        color:
                        controller.currentBackgroundColor.value,
                        blurRadius: 30,
                        offset: Offset.zero)
                  ],*/ /*
                //color: controller.currentTextColor.value,
                // fontFamily: controller.selectedFont.value.fontFamily
              ),
              decoration: InputDecoration(counterStyle: TextStyle(color: Colors.white.withOpacity(0.3)), border: InputBorder.none, hintText: "Add Text Here", hintStyle: CustomTextStyle.font12R.copyWith(shadows: [const Shadow(color: Colors.transparent, blurRadius: 30, offset: Offset.zero)], fontSize: 22, color: Colors.white.withOpacity(0.2), */ /*fontFamily: controller.selectedFont.value.fontFamily*/ /*)),
            ),
          ),*/
          const SizedBox(
            width: 10,
          ),
          SvgPicture.asset(
            StaticAssets.menuBurger,
            height: 25.w,
            width: 30.w,
          ),
        ],
      ),
    );
  }
}
