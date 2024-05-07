import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/configs/text.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/modules/myscreens/controllers/myscreens_controller.dart';

import 'subMyMediaView.dart';
import 'subMyProjectView.dart';

class ChooseProjectBroadcast extends GetView<MyscreensController> {
  const ChooseProjectBroadcast({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryDarkColor,
      body: DefaultTabController(
        length: 2,
        child: Container(
          padding: EdgeInsets.only(top: 100.h),
          child: Column(children: [
            TabBar(
              dividerColor: AppColor.transparent,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorPadding: const EdgeInsets.only(bottom: 8),
              labelPadding: EdgeInsets.zero,
              indicatorColor: AppColor.appSkyBlue,
              indicatorWeight: 2,
              labelColor: AppColor.appSkyBlue,
              unselectedLabelColor: AppColor.hintTextColor,
              labelStyle: CustomTextStyle.font16R,
              tabs:  [
                Tab(
                  text: 'myProjects'.tr,
                ),
                Tab(
                  text: "myMedias".tr,
                ),
              ],
            ),
            SizedBox(
              height: 30.h,
            ),
            const Expanded(
                child: TabBarView(
                    children: [SubMyProjectView(), SubMyMediaView()])),
          ]),
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Container(
            height: 117.h,
            decoration: BoxDecoration(
                color: AppColor.primaryDarkColor,
                border: const Border(
                  top: BorderSide(
                      width: 2.0,
                      color: AppColor.appSkyBlue), // Top border
                  right: BorderSide.none, // No border on the right
                  bottom: BorderSide.none, // No border on the bottom
                  left: BorderSide.none, // No border on the left
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.sp),
                  topRight: Radius.circular(20.sp),
                )),
            child: Center(
              child: Text(
                Strings.cancel,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
