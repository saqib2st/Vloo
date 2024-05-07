import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/text.dart';
import 'package:vloo/app/data/models/template/Template.dart';
import 'package:vloo/app/data/utils/static_assets.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/utils/utils.dart';
import 'package:vloo/app/data/widgets/primary_appbar.dart';
import 'package:vloo/app/modules/options/views/currency_view.dart';
import 'package:vloo/app/modules/options/views/duplicate_view.dart';
import 'package:vloo/app/modules/options/views/rename_view.dart';
import 'package:vloo/app/modules/templates/controllers/templates_controller.dart';
import 'package:vloo/app/modules/textEditing/controllers/title_editing_controller.dart';
import '../../../data/widgets/custom_rich_text.dart';
import '../../../data/widgets/option_tile.dart';
import '../controllers/options_controller.dart';

class OptionsView extends GetView<OptionsController> {
  final Template? templateModel;
  final String? comingFrom;
  final String? orientation;

  const OptionsView({
    super.key,
    this.comingFrom,
    this.templateModel,
    this.orientation,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: PrimaryAppbar(
        title: Strings.optionsCaps,
        onPressed: () {
          Get.back(result: controller.title);
        },
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04, vertical: Get.width * 0.15),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(Strings.modifications, style: CustomTextStyle.font16R.copyWith(fontWeight: FontWeight.bold, color: AppColor.appSkyBlue)),
            OptionTile(
              title: Strings.changeProjectName,
              textStyle: CustomTextStyle.font16R,
              myIcon: StaticAssets.pencil,
              arrowRight: Icons.keyboard_arrow_right,
              onPressed: () async {
                await Get.to(()=>RenameView(
                  templateModel: templateModel,
                  comingFrom: comingFrom,
                ));
                templateModel?.title = controller.title;
                Get.forceAppUpdate();
              },
            ),
            OptionTile(
              title: Strings.duplicateProject,
              textStyle: CustomTextStyle.font16R.copyWith(color: (comingFrom == Strings.editTemplate) ? AppColor.appLightBlue : AppColor.grey),
              myIcon: (comingFrom == Strings.editTemplate) ? StaticAssets.duplicate : StaticAssets.duplicateDisabled,
              arrowRight: Icons.keyboard_arrow_right,
              onPressed: () async {
                if (comingFrom == Strings.editTemplate) {
                  Utils.confirmationAlert(
                      context: context,
                      positiveText: Strings.confirm,
                      description: Strings.duplicateProjectConfirmationMessage,
                      negativeText: Strings.cancel,
                      onPressedPositive: () async {
                        Get.back();
                        await controller.duplicateTemplate(templateModel?.id.toString() ?? "0");
                        if (!Get.isRegistered<TemplatesController>()) {
                          Get.put<TemplatesController>(TemplatesController());
                        }
                        Get.to(()=> DuplicateView(orientation: orientation??OrientationType.Portrait.name));
                      },
                      onPressedNegative: () {
                        Get.back();
                      });

                }
              },
            ),
            OptionTile(
              title: Strings.changePriceCurrency,
              textStyle: CustomTextStyle.font16R,
              myIcon: StaticAssets.dollar,
              arrowRight: Icons.keyboard_arrow_right,
              onPressed: () async {
                Get.put<TitleEditingController>(TitleEditingController());
                if (Get.find<TemplatesController>().tempSingleItemList.any((element) => element.type=='Price')) {
                  Get.find<TitleEditingController>().findMostUsedCurrencySymbol(Get.find<TemplatesController>().tempSingleItemList);
                }
                Get.to(() => const CurrencyView());
              },
            ),
            OptionTile(
              title: Strings.deleteProject,
              textStyle: CustomTextStyle.font16R.copyWith(color: (comingFrom == Strings.editTemplate) ? AppColor.red : AppColor.grey),
              myIcon: (comingFrom == Strings.editTemplate) ? StaticAssets.trash : StaticAssets.trashDisabled,
              onPressed: () {
                if (comingFrom == Strings.editTemplate) {
                  Utils.confirmationAlert(
                      context: context,
                      positiveText: Strings.delete,
                      description: Strings.deleteProjectConfirmationMessage,
                      negativeText: Strings.cancel,
                      onPressedPositive: () {
                        controller.deleteTemplate(templateModel?.id.toString() ?? "0");
                      },
                      onPressedNegative: () {
                        Get.back();
                      });
                }
              },
            ),
            const SizedBox(height: 20),
            const Divider(color: AppColor.appIconBackgound, thickness: 1),
            const SizedBox(height: 20),
            Text(
              Strings.projectInformation,
              style: CustomTextStyle.font16R.copyWith(fontWeight: FontWeight.bold, color: AppColor.appSkyBlue),
            ),
            CustomRichText(
              textStyle2: CustomTextStyle.font16R,
              textStyle: CustomTextStyle.font16R.copyWith(fontWeight: FontWeight.bold),
              title: Strings.nameColon,
              discription: templateModel?.title != null && templateModel!.title!.isNotEmpty
                  ? templateModel?.title
                  : (controller.title.isNotEmpty)
                      ? controller.title
                      : Strings.dummyProjectName,
            ),
            CustomRichText(
              textStyle2: CustomTextStyle.font16R,
              textStyle: CustomTextStyle.font16R.copyWith(fontWeight: FontWeight.bold),
              title: Strings.createdTheColon,
              discription: Utils.getDateInFormat(templateModel?.createdAt ?? "", "yyyy-MM-ddThh:mm:ss.000000Z", "dd/MM/yyyy"),
            ),
            CustomRichText(
              textStyle2: CustomTextStyle.font16R,
              textStyle: CustomTextStyle.font16R.copyWith(fontWeight: FontWeight.bold),
              title: Strings.modifiedColon,
              discription: "${Utils.getDateInFormat(templateModel?.updatedAt ?? "", "yyyy-MM-ddThh:mm:ss.000000Z", "dd/MM/yyyy")} at ${Utils.getDateInFormat(templateModel?.updatedAt ?? "", "yyyy-MM-ddThh:mm:ss.000000Z", "hh:mm")}",
            ),
            CustomRichText(
              textStyle2: CustomTextStyle.font16R,
              textStyle: CustomTextStyle.font16R.copyWith(fontWeight: FontWeight.bold),
              title: Strings.format,
              discription: templateModel?.orientation ?? 'Vertical(Portrait)',
            ),
          ]),
        ),
      ),
    );
  }
}
