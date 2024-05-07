import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/modules/imageElement/views/tabs/phone_tab.dart';
import 'package:vloo/app/modules/imageElement/views/tabs/stock_photo_tab.dart';
import 'package:vloo/app/modules/imageElement/views/tabs/vloo_library_tab.dart';
import 'package:vloo/app/modules/templates/controllers/templates_controller.dart';
import 'package:vloo/app/modules/templates/views/Widget/bacground_phone_tab.dart';
import 'package:vloo/app/modules/templates/views/Widget/bg_vloo_library_tab.dart';

import '../../../data/configs/text.dart';

class BackgroundImageView extends GetView<TemplatesController> {
  const BackgroundImageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryDarkColor,
      body: Stack(
        children: [
          // Main content of the container
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(top: 45.h),
              child: DefaultTabController(
                length: 2,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TabBar(
                        tabs: const [
                          Tab(text: Strings.vlooLibrary),
                          Tab(text: Strings.phone),
                        ],
                        dividerColor: AppColor.transparent,
                        indicatorColor: AppColor.appSkyBlue,
                        unselectedLabelColor: AppColor.unselectedTab,
                        labelColor: AppColor.appSkyBlue,
                        labelStyle: CustomTextStyle.font14R,
                      ),
                      SizedBox(height: 8.h),
                      const Expanded(
                        child: TabBarView(
                          children: [
                            BgVlooLibrary(),
                            BackgroundPhoneTab(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: GestureDetector(
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
    );
  }
}
