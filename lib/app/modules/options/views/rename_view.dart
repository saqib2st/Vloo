import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/text.dart';
import 'package:vloo/app/data/models/media/MediaModel.dart';
import 'package:vloo/app/data/models/screens/ScreenModel.dart';
import 'package:vloo/app/data/models/template/Template.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/widgets/primary_appbar.dart';
import 'package:vloo/app/modules/options/controllers/options_controller.dart';
import 'package:vloo/app/modules/templates/controllers/templates_controller.dart';

class RenameView extends GetView<OptionsController> {
  final ScreenModel? selectedScreenModel;
  final MediaModel? selectedMediaModel;
  final Template? templateModel;
  final String? comingFrom;

  const RenameView(
      {super.key,
      this.comingFrom,
      this.templateModel,
      this.selectedScreenModel,
      this.selectedMediaModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: PrimaryAppbar(
        title: Strings.rename,
        text: Strings.confirm,
        onPressed: () {
          controller.title = templateModel?.title ?? Strings.dummyProjectName;
          Get.back();
        },
        onPressed2: () async {
          if (comingFrom == Strings.editTemplate) {
            if (templateModel != null) {
              controller.updateMyScreenTitle(
                  Strings.template, templateModel?.id ?? 0, controller.title);
            } else if (selectedMediaModel == null) {
              controller.updateMyScreenTitle(Strings.screens,
                  selectedScreenModel?.id ?? 0, controller.title);
            } else {
              await controller.updateMyScreenTitle(Strings.medias,
                  selectedMediaModel?.id ?? 0, selectedMediaModel?.name);
            }
          } else {
            Get.back();
          }
        },
      ),
      body: Container(
          alignment: Alignment.center,
          child: TextFormField(
            textAlign: TextAlign.center,
            style: CustomTextStyle.font22R,
            initialValue: (templateModel != null)
                ? templateModel?.title ?? ""
                : (selectedMediaModel != null)
                    ? selectedMediaModel?.name ?? ""
                    : (selectedScreenModel != null)
                        ? selectedScreenModel?.title ?? ""
                        : (controller.title.isNotEmpty)
                            ? controller.title
                            : Strings.dummyProjectName,
            onChanged: (value) {
              controller.title =
                  value.isEmpty ? Strings.dummyProjectName : value;
            },
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: Strings.writeProjectName,
                hintStyle: CustomTextStyle.font22R),
          )),
    );
  }
}
