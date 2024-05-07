
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/configs/text.dart';
import 'package:vloo/app/data/utils/static_assets.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/widgets/primary_appbar.dart';
import 'package:vloo/app/modules/imageElement/controllers/image_element_controller.dart';
import 'package:vloo/app/modules/imageElement/views/animations/move_animations.dart';
import 'package:vloo/app/modules/imageElement/views/animations/transition_animations.dart';
import 'package:vloo/app/modules/imageElement/views/availability.dart';
import 'package:vloo/app/modules/imageElement/views/image_content.dart';
import 'package:vloo/app/modules/imageElement/views/image_element_view.dart';


class ImageScreen extends GetView<ImageElementController> {
  const ImageScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: PrimaryAppbar(
        title: Strings.image,
        text: Strings.confirm,
        onPressed: () {
          controller.isBackgroundRemoved.value = false;
          Get.close(2);
          controller.resetView();

        },
        onPressed2: () async {
         controller.onGoingBackFromImage();
        },
      ),
      body: Container(
        color: AppColor.primaryDarkColor,
        child: Stack(
          children: [
            // Main content of the container
            const Positioned.fill(
              child: Center(
                child: ImageContent(isAnimEnabled: false),
              ),
            ),
            // Small window at the bottom

            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(5.0).copyWith(top: 8),
                height: 500.h,
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
                child: Obx(() => DefaultTabController(
                  length: 4,
                  child: Column(
                    children: [
                      TabBar(
                        onTap: (value){
                          controller.tabInnerIndex.value = value;
                        },
                        dividerColor: AppColor.transparent,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorPadding: EdgeInsets.fromLTRB(8.w, 0, 8.w, 0),
                        labelPadding: EdgeInsets.zero,
                        indicatorColor: AppColor.appSkyBlue,
                        indicatorWeight: 4,
                        labelColor: AppColor.appSkyBlue,
                        unselectedLabelColor: AppColor.hintTextColor,
                        labelStyle: CustomTextStyle.font11R,
                        controller: controller.templateEditingTabController,
                        tabs: [
                          Tab(icon: SvgPicture.asset(controller.tabInnerIndex.value == 0 ? StaticAssets.transitionsSelected : StaticAssets.transitions, width: 25.w, height: 25.h),text: Strings.transitions),
                          Tab(icon: SvgPicture.asset(controller.tabInnerIndex.value == 1 ? StaticAssets.moveIconSelected : StaticAssets.moveIconGrey, width: 25.w, height: 25.h), text: Strings.moves),
                          GestureDetector(
                              onTap: () =>{
                                if(!Get.isRegistered<ImageElementController>()){
                                  Get.put<ImageElementController>(ImageElementController())
                                },
                                Get.to(()=> ImageElementView(comingFrom: 'edit')),
                              },
                              child: Tab(icon: SvgPicture.asset(controller.tabInnerIndex.value == 2 ? StaticAssets.replaceSelected : StaticAssets.replaceIcon, width: 25.w, height: 25.h), text: Strings.replace)),
                          Tab(icon: SvgPicture.asset(controller.tabInnerIndex.value == 3 ? StaticAssets.cubeIconSelected : StaticAssets.cubeIconGrey, width: 25.w, height: 25.h), text: Strings.availability),
                        ],
                      ),
                      const Padding(
                        padding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Divider(
                          color: AppColor.appIconBackgound,
                          thickness: 0.8,
                        ),
                      ),
                       Expanded(
                          child: TabBarView(
                              controller: controller.templateEditingTabController,
                              children: const [
                            SingleChildScrollView(child: TransitionAnimation()),
                            SingleChildScrollView(child: MoveAnimation()),
                            SingleChildScrollView(child: SizedBox()),
                            SingleChildScrollView(child: Availability()),
                          ]))
                    ],
                  ),
                )),
              ),
            ),

            // Positioned(
            //     left: 0,
            //     right: 0,
            //     bottom: 0,
            //     child: Obx(
            //       () => controller.showAnimationContent.value
            //           ? Container(
            //               height: 500.h,
            //               decoration: const ShapeDecoration(
            //                 color: AppColor.primaryDarkColor,
            //                 shape: RoundedRectangleBorder(
            //                   borderRadius: BorderRadius.only(
            //                     topLeft: Radius.circular(20),
            //                     topRight: Radius.circular(20),
            //                   ),
            //                   side: BorderSide(
            //                     color: AppColor.appLightBlue,
            //                     width: 1,
            //                   ),
            //                 ),
            //               ),
            //               child: const Padding(
            //                 padding: EdgeInsets.all(25.0),
            //                 child: MoveAnimation(),
            //               )
            // )
            //           : Container(
            //               height: 500.h,
            //               decoration: const ShapeDecoration(
            //                 color: AppColor.primaryDarkColor,
            //                 shape: RoundedRectangleBorder(
            //                   borderRadius: BorderRadius.only(
            //                     topLeft: Radius.circular(20),
            //                     topRight: Radius.circular(20),
            //                   ),
            //                   side: BorderSide(
            //                     color: AppColor.appLightBlue,
            //                     width: 1,
            //                   ),
            //                 ),
            //               ),
            //               child: const Padding(
            //                 padding: EdgeInsets.all(25.0),
            //                 child: TransitionAnimation(),
            //               )),
            //     )),
          ],
        ),
      ),
    );
  }
}
