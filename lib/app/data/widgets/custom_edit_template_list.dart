import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/utils/utils.dart';

class CustomEditTemplateListItem extends StatelessWidget {
  final dynamic myIcon;
  final bool isBgRemoved;
  final String price;
  final double width;
  final double? height;
  final String burgerName;
  final String description;
  final TextStyle titleStyle;
  final TextStyle priceStyle;
  final TextStyle descriptionStyle;
  final VoidCallback onImagePressed;
  final VoidCallback onTitlePressed;
  final VoidCallback onPricePressed;
  final VoidCallback onDiscriptionPressed;
  final String? comingFrom;

  const CustomEditTemplateListItem({
    super.key,
    this.myIcon,
    required this.isBgRemoved,
    required this.price,
    required this.burgerName,
    required this.description,
    required this.titleStyle,
    required this.priceStyle,
    required this.descriptionStyle,
    required this.onImagePressed,
    required this.onTitlePressed,
    required this.onPricePressed,
    required this.onDiscriptionPressed,
    required this.width,
    this.height,
    this.comingFrom,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Column(
        children: [
          GestureDetector(
            onTap: onTitlePressed,
            child: Text(
              burgerName,
              style: titleStyle,
            ),
          ),

          Row(
            children: [
              GestureDetector(
                  onTap: onPricePressed,
                  child: Expanded(
                      child: Text(
                    price,
                    style: priceStyle,
                  ))),
              SizedBox(width: 5.w,),
              Container(
                width: Get.width * 0.15,
                height: Get.height * 0.05,
                child: GestureDetector(
                  onTap: onImagePressed,
                  child: comingFrom == 'edit'
                      ? Utils.getNetworkImage(
                          myIcon as String,
                          BoxFit.cover,
                      100,
                      100

                        )
                      : Container(
                    width: Get.width * 0.15,
                    height: Get.height * 0.05,
                    alignment: Alignment.center,
                          child: Image.file(
                            File(myIcon),
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ), /*Image.asset(
                  myIcon,
                  width: 80.w,
                  height: 60.h,
                ),*/
                ),
              ),
            ],
          ),
          SizedBox(height: Get.height* 0.01 ,),
          GestureDetector(
            onTap: onDiscriptionPressed,
            child: Text(
              description,
              style: descriptionStyle,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
