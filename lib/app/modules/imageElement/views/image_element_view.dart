import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/modules/imageElement/views/tabs/phone_tab.dart';
import 'package:vloo/app/modules/imageElement/views/tabs/stock_photo_tab.dart';
import 'package:vloo/app/modules/imageElement/views/tabs/vloo_library_tab.dart';
import '../controllers/image_element_controller.dart';

class ImageElementView extends GetView<ImageElementController> {
  String comingFrom;
   ImageElementView({super.key, required this.comingFrom});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryDarkColor,
      body: Container(
        color: AppColor.primaryDarkColor,
        padding: EdgeInsets.only(top: 45.h),
        child: Container(
          padding: const EdgeInsets.all(16.0).copyWith(bottom: 0),
          child: Column(
            children: [
              TabBar(
                controller: controller.libraryTabController,
                labelStyle: TextStyle(
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
                indicatorWeight: 1.0,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: [
                  Tab(height: 42.h,text: Strings.vlooLibrary),
                  Tab(height: 42.h,text: Strings.phone),
                  Tab(height: 42.h,text: Strings.stockPhoto),
                ],
                indicatorColor: AppColor.appSkyBlue,
                unselectedLabelColor: AppColor.unselectedTab,
                labelColor: AppColor.appSkyBlue,
                dividerColor: AppColor.transparent,
              ),
              const SizedBox(height: 4),
               Expanded(
                child: TabBarView(
                  controller: controller.libraryTabController,
                  children: [
                    VlooLibrary(comingFrom: comingFrom),
                    PhoneTab(comingFrom: comingFrom),
                    StockPhoto(comingFrom: comingFrom),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          Get.back();
        },
        child: Container(
          height: 117.h,
          decoration: BoxDecoration(
              color: AppColor.primaryDarkColor,
              border: const Border(
                top: BorderSide(
                    width: 2.0, color: AppColor.appSkyBlue), // Top border
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
