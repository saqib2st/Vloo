import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/configs/text.dart';
import 'package:vloo/app/data/models/media/MediaModel.dart';
import 'package:vloo/app/data/utils/static_assets.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/utils/utils.dart';
import 'package:vloo/app/data/widgets/primary_appbar.dart';
import 'package:vloo/app/modules/MyMedia/controllers/my_media_controller.dart';
import 'package:vloo/app/modules/options/controllers/options_controller.dart';
import 'package:vloo/app/modules/options/views/currency_view.dart';
import 'package:vloo/app/modules/options/views/rename_view.dart';
import '../../../data/widgets/custom_rich_text.dart';
import '../../../data/widgets/option_tile.dart';

class OptionsViewMedia extends GetView<MyMediaController> {
  final MediaModel mediaModel;
  const OptionsViewMedia({Key? key, required this.mediaModel }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: PrimaryAppbar(
        title: Strings.optionsMedia,
        text: Strings.confirm,
        onPressed: () {
          Get.back();
        },
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04, vertical: Get.height * 0.01),
          child: Obx(
            () => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Center(
                child: Stack(alignment: Alignment.center, children: [
                  //Image.asset(StaticAssets.imgDummyVerticalIcon, width: 100.w, height: 150.h, fit: BoxFit.fitHeight),
                 // Utils.getNetworkImage(controller.mediaDetailsModel.value.url ?? "", BoxFit.fitHeight, 100, 150),           // Commenting since it is not playing video mp4
                  Utils.getNetworkImage(controller.mediaDetailsModel.value.thumbnail ?? "", BoxFit.fitHeight, 100, 150),
                 /* if (controller.mediaDetailsModel.value.format?.contains("Video") == true)
                    SvgPicture.asset(StaticAssets.icPlay, width: 40.w, height: 40.h,placeholderBuilder: (BuildContext context) => Container(
                        padding: const EdgeInsets.all(30.0),
                        child: const CircularProgressIndicator()),)
                  else
                    SvgPicture.asset(StaticAssets.icEye, width: 40.w, height: 40.h,placeholderBuilder: (BuildContext context) => Container(
                        padding: const EdgeInsets.all(30.0),
                        child: const CircularProgressIndicator()),),*/
                ]),
              ),
              SizedBox(height: 20.h),
              const Text(Strings.diffusion, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColor.appSkyBlue)),
              CustomRichText(textStyle2: CustomTextStyle.font16R, textStyle: CustomTextStyle.font16R.copyWith(fontWeight: FontWeight.bold), title: Strings.statusColon, discription: controller.mediaDetailsModel.value.status ?? ""),
              CustomRichText(textStyle2: CustomTextStyle.font16R, textStyle: CustomTextStyle.font16R.copyWith(fontWeight: FontWeight.bold), title: Strings.contentBroadcastOnColon, discription: controller.fetchMediaListScreen() ?? ''),
              const SizedBox(height: 20),
              const Divider(color: AppColor.appIconBackgound, thickness: 1),
              const SizedBox(height: 20),
              const Text(Strings.informations, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColor.appSkyBlue)),
              OptionTile(
                titleText: Strings.nameColon,
                title: controller.mediaDetailsModel.value.name ?? "",
                textStyle: CustomTextStyle.font16R,
                myIcon: '',
                arrowText: Strings.edit,
                arrowRight: Icons.keyboard_arrow_right,
                onPressed: () async {
                  Get.put<OptionsController>(OptionsController());
                  await Get.to(RenameView(
                    selectedMediaModel: mediaModel,
                  ));
                  await controller.getMyMediaDetailsList(mediaModel.id.toString());
                },
              ),
              CustomRichText(textStyle2: CustomTextStyle.font16R, textStyle: CustomTextStyle.font16R.copyWith(fontWeight: FontWeight.bold), title: Strings.sizeColon, discription: controller.mediaDetailsModel.value.size ?? ""),
/*              CustomRichText(textStyle2: CustomTextStyle.font16R, textStyle: CustomTextStyle.font16R.copyWith(fontWeight: FontWeight.bold), title: Strings.createdAtColon, discription: '19/01/2024'),
              CustomRichText(textStyle2: CustomTextStyle.font16R, textStyle: CustomTextStyle.font16R.copyWith(fontWeight: FontWeight.bold), title: Strings.modifiedAtColon, discription: '19/01/2024 at 20h23'),*/
              CustomRichText(textStyle2: CustomTextStyle.font16R, textStyle: CustomTextStyle.font16R.copyWith(fontWeight: FontWeight.bold), title: Strings.addTheColon, discription: controller.mediaDetailsModel.value.addthe ?? ""),
              CustomRichText(textStyle2: CustomTextStyle.font16R, textStyle: CustomTextStyle.font16R.copyWith(fontWeight: FontWeight.bold), title: Strings.formatColon, discription: controller.mediaDetailsModel.value.format ?? ""),
              SizedBox(height: 20.h),
              GestureDetector(
                  onTap: () {
                    Utils.confirmationAlert(
                        context: context,
                        description: Strings.deleteMediaConfirmationMessage,
                        positiveText: Strings.delete,
                        negativeText: Strings.cancel,
                        onPressedPositive: () {
                          Get.back();
                          controller.deleteMyMedia(mediaModel.id.toString());
                        },
                        onPressedNegative: () {
                          Get.back();
                        });
                  },
                  child: OptionTile(title: Strings.deleteMedia, textStyle: CustomTextStyle.font16R.copyWith(color: AppColor.red), myIcon: StaticAssets.trash)),
            ]),
          ),
        ),
      ),
    );
  }
}
