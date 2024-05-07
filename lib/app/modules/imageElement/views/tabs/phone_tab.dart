import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/utils/static_assets.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/utils/utils.dart';
import 'package:vloo/app/data/widgets/icon_text.dart';
import 'package:vloo/app/modules/imageElement/controllers/image_element_controller.dart';
import 'package:vloo/app/modules/imageElement/views/add_image_transition_screen.dart';
import 'package:vloo/app/modules/imageElement/views/image_screen.dart';

class PhoneTab extends GetView<ImageElementController> {
  String comingFrom;

   PhoneTab({super.key,required this.comingFrom});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 30.w),
        child: Column(
          children: [
            SizedBox(height: 40.h),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    controller.onRefresh();
                  },
                  child: const IconText(
                    iconPath: StaticAssets.dropDownIcon,
                    text: Strings.recents,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () async {
                    Utils.confirmationAlert(context: context,description: 'Select image from',negativeText: 'Gallery',positiveText: 'Camera',
                        negativeColor:AppColor.appLightBlue,
                        onPressedNegative: ()async{
                        Get.back();//for closing the Dialog
                          File? pickedFile = await controller.selectImageFromGallery();
                          if (pickedFile?.path.isNotEmpty==true) {
                            String? selectedImagePath = await controller.uploadImageAPIToServer(pickedFile);
                            if (comingFrom == 'add') {
                              if (selectedImagePath != null) {
                                controller.imageUrl.value = selectedImagePath;
                                Get.to(() => const AddImageTransitionScreen());
                              }
                            }
                            else {
                              if (selectedImagePath != null) {
                                controller.imageUrl.value = selectedImagePath;
                                controller.onGoingBackFromImage();
                              }
                            }
                          }
                        },
                        onPressedPositive: ()async{
                          Get.back();//for closing the Dialog
                          File? pickedFile = await controller.selectImageFromCamera();
                          if (pickedFile?.path.isNotEmpty==true) {
                            String? selectedImagePath = await controller.uploadImageAPIToServer(pickedFile); // converting file to url
                            if (comingFrom == 'add') {
                              if (selectedImagePath != null) {
                                controller.imageUrl.value = selectedImagePath;
                                Get.to(() => const AddImageTransitionScreen());
                              }
                            }
                            else {
                              if (selectedImagePath != null) {
                                controller.imageUrl.value = selectedImagePath;
                                controller.onGoingBackFromImage();
                              }
                            }
                          }});
                  },
                  child: const SizedBox(
                    height: 20,
                    child: IconText(
                      iconPath: StaticAssets.cameraIcon,
                      text: Strings.takePicture,
                      height: 20,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            Expanded(
              child: SmartRefresher(
                controller: controller.phoneTabRefreshController,
                onRefresh: ()=>controller.onRefresh(),
                child: GridView.count(
                  crossAxisCount: 3,
                  children: List.generate(controller.recentLibraryImages?.length ?? 0, (index) {
                    return InkWell(
                        onTap: (){
                          if (comingFrom == 'add') {
                            if (controller.recentLibraryImages?[index].mediaFile != null) {
                              controller.imageUrl.value = controller.recentLibraryImages?[index].mediaFile ??'';
                              Get.to(() => const AddImageTransitionScreen());
                            }
                          }
                          else {
                            if (controller.recentLibraryImages?[index].mediaFile != null) {
                              controller.imageUrl.value = controller.recentLibraryImages?[index].mediaFile ??'';
                              controller.onGoingBackFromImage();
                            }
                          }
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: AppColor.white,
                                    width: 1
                                )
                            ),
                            child: Utils.getNetworkImage(controller.recentLibraryImages?[index].mediaFile ?? '',BoxFit.fill,100.w,200.h)));
                  }),
                )
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
