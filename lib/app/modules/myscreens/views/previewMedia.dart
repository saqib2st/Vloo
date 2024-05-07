import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/configs/text.dart';
import 'package:vloo/app/data/models/media/MediaModel.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/utils/utils.dart';
import 'package:vloo/app/data/widgets/primary_appbar.dart';
import 'package:vloo/app/modules/myscreens/controllers/myscreens_controller.dart';

class PreviewMedia extends GetView<MyscreensController> {
  final MediaModel? mediaModel;

  const PreviewMedia({super.key, this.mediaModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: PrimaryAppbar(
        title: Strings.previewOfMedia,
        text: Strings.confirm,
        onPressed: () {
          Get.back();
        },
        onPressed2: () {
          // TODO: Enter time API for images
        },
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Center(
            child: Container(
              width: 355.w,
              height: 650.h,
              decoration: BoxDecoration(border: Border.all(color: AppColor.appLightBlue)),
              child: Utils.getNetworkImage(mediaModel?.thumbnail ?? "", BoxFit.cover, 100.w, 100.h),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            Strings.changeTheDurationOfTheImage,
            style: CustomTextStyle.font18R.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10.h,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(
                () => Container(
                  margin: EdgeInsets.symmetric(horizontal: 120.w),
                  decoration: BoxDecoration(border: Border.all(color: AppColor.appLightBlue), borderRadius: BorderRadius.circular(30)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DropdownButton<String>(
                          menuMaxHeight: 300.h,
                          underline: const SizedBox(),
                          dropdownColor: AppColor.primaryColor,
                          value: controller.dropdownMinvalue.value,
                          style: CustomTextStyle.font12R,
                          onChanged: (String? newValue) {
                            controller.dropdownMinvalue.value = newValue ?? '1';
                          },
                          items: List.generate(
                              controller.min.length,
                              (index) => DropdownMenuItem<String>(
                                    value: controller.min[index].toString(),
                                    child: Text("${controller.min[index]} ${Strings.min}"),
                                  ))),
                      const SizedBox(
                        width: 10,
                      ),
                      DropdownButton<String>(
                          underline: const SizedBox(),
                          dropdownColor: AppColor.primaryColor,
                          value: controller.dropdownSecvalue.value,
                          style: CustomTextStyle.font12R,
                          onChanged: (String? newValue) {
                            controller.dropdownSecvalue.value = newValue ?? '10';
                          },
                          items: List.generate(
                              controller.sec.length,
                              (index) => DropdownMenuItem<String>(
                                    value: controller.sec[index].toString(),
                                    child: Text('${controller.sec[index]} ${Strings.sec}'),
                                  ))),
                    ],
                  ),
                ),
              )
            ],
          ),
        ]),
      ),
    );
  }
}
