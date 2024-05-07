import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/configs/text.dart';
import 'package:vloo/app/data/models/template/Template.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/utils/utils.dart';
import 'package:vloo/app/modules/myscreens/controllers/myscreens_controller.dart';

class SubMyProjectView extends GetView<MyscreensController> {
  const SubMyProjectView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / (controller.selectedScreenModel.value.orientation?.split(' ').first.toLowerCase()==Strings.portrait?2:4);
    final double itemWidth = size.width / (controller.selectedScreenModel.value.orientation?.split(' ').first.toLowerCase()==Strings.portrait?1.8:1.4);
    return Column(
      children: [
        Center(
          child: Text(
            'chooseTheProjectToBroadcast'.tr,
            style: CustomTextStyle.font20R.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 8.h),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 90),
            child: Text(
              controller.selectedScreenModel.value.orientation?.split(' ').first.toLowerCase()==Strings.portrait?
              'This Screen Only Accepts Projects In Vertical Mode'.tr:
              'This Screen Only Accepts Projects In Horizontal Mode'.tr,
              style: CustomTextStyle.font14R,
              textAlign: TextAlign.center,
              softWrap: true,
            ),
          ),
        ),
        SizedBox(
          height: 30.h,
        ),
        if (controller.fetchFilteredList(controller.selectedScreenModel.value.orientation?.split(' ').first ?? "Portrait") != null && controller.fetchFilteredList(controller.selectedScreenModel.value.orientation?.split(' ').first ?? "Portrait")!.isNotEmpty) ...[
          Expanded(
            child: GridView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: controller.selectedScreenModel.value.orientation?.split(' ').first.toLowerCase()==Strings.portrait?2:1,
                childAspectRatio: (itemWidth / itemHeight),
              ),
              children: <Widget>[
                ...List.generate(controller.fetchFilteredList(controller.selectedScreenModel.value.orientation?.split(' ').first ?? "Portrait")!.length, (index) {
                  return GestureDetector(
                    onTap: () async{
                      controller.selectedTemplate.value = controller.fetchFilteredList(controller.selectedScreenModel.value.orientation?.split(' ').first ?? "Portrait")?[index] ?? Template();
                      await Future.delayed(const Duration(milliseconds: 150));
                      controller.addMyScreenContent(templateId: controller.fetchFilteredList(controller.selectedScreenModel.value.orientation?.split(' ').first ?? "Portrait")?[index].id ?? 0);
                    },
                    child: Obx(()=>Container(
                      margin: EdgeInsets.fromLTRB(10.w, 0, 10.w, 20.h),
                      decoration: BoxDecoration(border: Border.all(
                          color:
                          controller.selectedTemplate.value==controller.fetchFilteredList(controller.selectedScreenModel.value.orientation?.split(' ').first ?? "Portrait")![index]?
                          AppColor.appSkyBlue:
                          AppColor.appLightBlue)),
                      child: Utils.getNetworkImage(controller.fetchFilteredList(controller.selectedScreenModel.value.orientation?.split(' ').first ?? "Portrait")?[index].featureImg as String, BoxFit.cover),
                    )),
                  );
                })
              ],
            ),
          )
        ] else ...[
          Expanded(
            child: Center(
              child: Text(
                controller.selectedScreenModel.value.orientation?.split(' ').first.toLowerCase()==Strings.portrait?
                Strings.noPortraitTemplateYet:Strings.noLandscapeTemplateYet,
                style: CustomTextStyle.font20R.copyWith(
                  color: AppColor.red,
                ),
              ),
            ),
          )
        ]
      ],
    );
  }
}
