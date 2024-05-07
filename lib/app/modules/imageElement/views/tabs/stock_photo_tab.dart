import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/utils/utils.dart';
import 'package:vloo/app/data/widgets/loading_widget.dart';
import 'package:vloo/app/modules/imageElement/controllers/image_element_controller.dart';
import 'package:vloo/app/modules/imageElement/views/add_image_transition_screen.dart';
import 'package:vloo/app/modules/imageElement/views/image_screen.dart';

class StockPhoto extends GetView<ImageElementController> {
  String comingFrom;

  StockPhoto({super.key, required this.comingFrom});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
          child: SizedBox(
            height: 55.h,
            child: TextField(
              onSubmitted: (value){
                controller.stockImagesApi(value, 1.toString());
              },
              onChanged: (value){
                if(controller.debounce?.isActive??false){
                  controller.debounce?.cancel();
                }else{
                  controller.debounce = Timer(const Duration(milliseconds: 500), () {
                    controller.stockImagesApi(value, 1.toString());

                  });
                }
              },
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                hintText: Strings.search,
                hintStyle: const TextStyle(color: Colors.white),
                filled: true,
                fillColor: AppColor.primaryColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: AppColor.appLightBlue,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: AppColor.appLightBlue,
                  ),
                ),
                focusedBorder:OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColor.appSkyBlue, width: 1.0),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        Obx(
          () => Expanded(
            child: LoadingWidget(
              widget: GridView(
                shrinkWrap: true,
                padding: const EdgeInsets.fromLTRB(20, 20, 10, 20),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.2,
                ),
                children: <Widget>[
                  ...List.generate(controller.stockPhotosList.value?.length ?? 0, (index) {
                    return GestureDetector(
                        onTap: () async {
                          if (controller.stockPhotosList.value != null) {
                            //String? selectedImagePath = await controller.downloadImage(controller.stockPhotosList.value![index].src?.medium, controller.stockPhotosList.value![index].id);   // converting file to url
                            String? selectedImagePath = controller.stockPhotosList.value![index].src?.original;     // url for original pic size

                            // if (selectedImagePath != null) {
                            //   controller.imageUrl.value = selectedImagePath;
                            //   Get.to(() =>  const ImageScreen());
                            // }
                              if(comingFrom == 'add'){
                              if (selectedImagePath != null) {
                              controller.imageUrl.value = selectedImagePath;
                              Get.to(() => const AddImageTransitionScreen());
                              }
                              } else{
                              if (selectedImagePath != null) {
                              controller.imageUrl.value = selectedImagePath;
                              controller.onGoingBackFromImage();
                              }
                          }
                        }
                        },
                        child: Utils.getNetworkImage(controller.stockPhotosList.value?[index].src?.medium ?? "", BoxFit.cover, 250.w, 100.h));
                  })
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
