import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import '../controllers/bottom_nav_controller.dart';

class BottomNavView extends GetView<BottomNavController> {
  const BottomNavView({super.key});

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;

    return PopScope(
      canPop: false,
      onPopInvoked: (willPop) {
        if (controller.currentIndex.value != 0) {
          controller.currentIndex.value = 0;
        } else {
          exit(0);
        }
      },
      child: Scaffold(
          body: Obx(
            () => controller.screens[controller.currentIndex.value],
          ),
          bottomNavigationBar: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return Obx(() => BottomAppBar(
             height: orientation == Orientation.landscape
                 ? constraints.maxHeight * 0.18
                 : constraints.maxHeight * 0.11,
             elevation: 0,
             color: AppColor.primaryDarkColor,
             shape: const CircularNotchedRectangle(),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceAround,
               children: List.generate(
                 controller.getMenuCount(),
                     (index) => InkWell(
                   onTap: () => controller.changeTab(index),
                   child: Column(
                     mainAxisSize: MainAxisSize.min, //Help to avoid overflow in bottom AppBar
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       if (index == controller.currentIndex.value)
                         Container(
                           height: 4.h,
                           width: 30.w,
                           color: AppColor.secondaryColor,
                         ),
                       SizedBox(
                         height: 10.h,
                       ),
                       controller.getIconList()[index](
                         index == controller.currentIndex.value,
                       ),
                       SizedBox(
                         height: 2.h,
                       ),
                       Text(
                         controller.getTitleList()[index],
                         style: TextStyle(
                           fontSize: 10.sp,
                           color: index == controller.currentIndex.value
                               ? AppColor.secondaryColor
                               : AppColor.appLightBlue,
                         ),
                       ),
                       SizedBox(
                         height: 5.h,
                       ),
                     ],
                   ),
                 ),
               ),
             ),
                        ));
          })),
    );
  }
}
