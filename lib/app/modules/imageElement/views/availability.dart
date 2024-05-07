import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/configs/text.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/modules/imageElement/controllers/image_element_controller.dart';

class Availability extends GetView<ImageElementController> {
  const Availability({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Builder(builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(Strings.changeAvailability,
                    style: CustomTextStyle.font12R
                        .copyWith(fontWeight: FontWeight.w500, fontSize: 11.sp),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      Obx(() => Switch(
                        inactiveTrackColor: AppColor.statusRed,
                        activeTrackColor: AppColor.statusGreen,
                        thumbColor: MaterialStateColor.resolveWith((states){
                            return AppColor.white;
                          }),
                            value: controller.isSwitched.value,
                            onChanged: controller.toggleSwitch,
                          )),
                      Obx(() => Text(
                            controller.isSwitched.value
                                ? Strings.inStock
                                : Strings.outStock,
                            style: CustomTextStyle.font12R.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                    ],
                  ),
                ],
              ),
            ),
            Obx(
                  () => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Wrap(
                                    alignment: WrapAlignment.center,
                                    runAlignment: WrapAlignment.center,
                                    runSpacing: 10,
                                    spacing: 10,
                                    children: [
                    ...controller.stickersList.asMap().entries.map(
                          (e) {
                        return GestureDetector(
                          onTap: () {
                            if(controller.isSwitched.value== false){
                              if(controller.selectedSticker?.value == e.value['image']){
                                controller.selectedSticker?.value = '';
                              }
                              else{
                                controller.selectedSticker?.value = e.value['image']??'';
                              }
                            }

                          },
                          child:     Opacity(
                            opacity: controller.isSwitched.value== false? 1  : 0.4 ,
                            child: Container(
                              height: 100.h,
                              width: 180.w,
                              padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 10.h),
                              decoration: BoxDecoration(
                                color: controller.selectedSticker?.value == e.value['image']? AppColor.appSkyBlue : AppColor.appIconBackgound,
                                borderRadius: BorderRadius.circular(10.0)),
                              child: SvgPicture.asset(e.value['image']??'',
                              )),
                          ),

                        );
                      },
                    ),
                                    ],
                                  ),
                  ),
            ),
            // GestureDetector(
            //   onTap: () {
            //     Get.back();
            //   },
            //   child: const Text(
            //     Strings.cancel,
            //     style: TextStyle(
            //       fontSize: 16,
            //       fontWeight: FontWeight.bold,
            //       decoration: TextDecoration.none,
            //       color: Colors.white,
            //     ),
            //   ),
            // ),
          ],
        );
      }),
    );
  }
}
