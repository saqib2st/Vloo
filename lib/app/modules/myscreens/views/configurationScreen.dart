import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/configs/text.dart';
import 'package:vloo/app/data/utils/singleton.dart';
import 'package:vloo/app/data/utils/static_assets.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/utils/utils.dart';
import 'package:vloo/app/data/widgets/custom_rich_text.dart';
import 'package:vloo/app/data/widgets/loading_widget.dart';
import 'package:vloo/app/data/widgets/option_tile.dart';
import 'package:vloo/app/data/widgets/primary_appbar.dart';
import 'package:vloo/app/modules/myscreens/controllers/myscreens_controller.dart';
import 'package:vloo/app/modules/myscreens/views/ContentScreenListing.dart';
import 'package:vloo/app/modules/options/controllers/options_controller.dart';
import 'package:vloo/app/modules/options/views/rename_view.dart';
import 'package:vloo/app/modules/templates/views/Widget/app_loader.dart';

class ConfigurationScreen extends GetView<MyscreensController> {
  const ConfigurationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: PrimaryAppbar(
        title: 'configurationOfTHeScreen'.tr,
        /* text: Strings.confirm,*/ // No need for this after implementing API
        onPressed: () {
          Get.back();
        },
        /*onPressed2: () {},*/
      ),
      body:  SingleChildScrollView(
          child: Obx(
            () => Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Center(
                child: Text(
                  'screenContents'.tr,
                  style: CustomTextStyle.font20R.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (controller.selectedScreenModel.value.uploadMedias != null && controller.selectedScreenModel.value.uploadMedias!.isNotEmpty) ...[
                    Utils.getNetworkImage(controller.selectedScreenModel.value.uploadMedias?[0].thumbnail ?? "", BoxFit.cover, 100, 150),
                    if (controller.selectedScreenModel.value.uploadMedias!.length > 1) ...[
                      SizedBox(
                        width: 5.w,
                      ),
                      Utils.getNetworkImage(controller.selectedScreenModel.value.uploadMedias?[1].thumbnail ?? "", BoxFit.cover, 100, 150),
                      if (controller.selectedScreenModel.value.uploadMedias!.length > 2) ...[
                        SizedBox(
                          width: 5.w,
                        ),
                        SizedBox(
                          width: 100.w,
                          height: 60.h,
                          child: Text(
                            '${(controller.selectedScreenModel.value.uploadMedias!.length - 2)} ${Strings.othersContents}',
                            style: CustomTextStyle.font18R,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ]
                  ] else ...[
                    Image.asset(
                      width: 100.w,
                      height: 150.h,
                      StaticAssets.noImageIcon,
                      fit: BoxFit.cover,
                    ),
                  ],
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              GestureDetector(
                onTap: () async{
                  await controller.getMyScreenDetails();
                  Get.to(()=>const ContentScreenListing());
                  await Future.delayed(const Duration(milliseconds: 1000));
                  controller.slidableController?.openEndActionPane(
                      duration:const  Duration(milliseconds: 500)
                  );
                  await Future.delayed(const Duration(milliseconds: 1000));
                  controller.slidableController?.close(
                    duration: const Duration(milliseconds: 1000)
                  );
                },
                child: Container(
                    alignment: Alignment.center,
                    width: 286.w,
                    height: 90.h,
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColor.appSkyBlue,
                          width: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      'editContentsToBroadcast'.tr,
                      style: CustomTextStyle.font16R.copyWith(color: AppColor.appSkyBlue),
                      textAlign: TextAlign.center,
                    )),
              ),
              SizedBox(
                height: 30.h,
              ),
              const Divider(color: AppColor.appSkyBlue),
              SizedBox(
                height: 30.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text(
                    Strings.informationColon,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColor.appSkyBlue),
                  ),
                  CustomRichText(
                    textStyle2: CustomTextStyle.font16R.copyWith(color: AppColor.primaryGreen),
                    textStyle: CustomTextStyle.font16R.copyWith(fontWeight: FontWeight.bold),
                    title: Strings.statusColon,
                    discription: controller.selectedScreenModel.value.status ?? "",
                  ),
                  CustomRichText(
                    textStyle2: CustomTextStyle.font16R.copyWith(color: AppColor.lightGreen),
                    textStyle: CustomTextStyle.font16R.copyWith(fontWeight: FontWeight.bold),
                    title: Strings.dateOf1stConnectionColon,
                    discription: controller.selectedScreenModel.value.dateOfFirstConnection ?? "",
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  const Text(
                    Strings.modifications,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColor.appSkyBlue),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  GestureDetector(
                    onTap: () async {
                      Get.put<OptionsController>(OptionsController());
                      await Get.to(()=>RenameView(
                        selectedScreenModel: controller.selectedScreenModel.value,
                      ));
                      AppLoader.showLoader();
                      await controller.getMyScreenDetails();
                    },
                    child: Row(
                      children: [
                        Expanded(child: RichText(text: TextSpan(text: Strings.nameColon, style: CustomTextStyle.font16R.copyWith(fontWeight: FontWeight.bold), children: [TextSpan(text: controller.selectedScreenModel.value.title, style: CustomTextStyle.font16R)]))),
                        const Icon(
                          Icons.keyboard_arrow_right,
                          color: AppColor.appLightBlue,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      Utils.showOrientationAlert(context, controller.selectedScreenModel.value);
                    },
                    child: Row(
                      children: [
                        Expanded(child: RichText(text: TextSpan(text: Strings.orientationColon, style: CustomTextStyle.font16R.copyWith(fontWeight: FontWeight.bold), children: [TextSpan(text: controller.selectedScreenModel.value.orientation, style: CustomTextStyle.font16R)]))),
                        const Icon(
                          Icons.keyboard_arrow_right,
                          color: AppColor.appLightBlue,
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Utils.confirmationAlert(
                          context: context,
                          description: Strings.deleteConfirmationMessage,
                          positiveText: Strings.delete,
                          negativeText: Strings.cancel,
                          onPressedPositive: () {
                            Get.back();
                            controller.deleteMyScreen(controller.selectedScreenModel.value.id ?? 0);
                          },
                          onPressedNegative: () {
                            Get.back();
                          });
                    },
                    child: OptionTile(
                      title: Strings.deleteProject,
                      textStyle: CustomTextStyle.font16R.copyWith(color: AppColor.red),
                      myIcon: StaticAssets.trash,
                    ),
                  ),
                ]),
              ),
            ]),
          ),
        ),

    );
  }
}
