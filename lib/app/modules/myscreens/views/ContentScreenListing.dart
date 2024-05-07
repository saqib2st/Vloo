import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/configs/text.dart';
import 'package:vloo/app/data/models/template/Template.dart';
import 'package:vloo/app/data/utils/static_assets.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/utils/utils.dart';
import 'package:vloo/app/data/widgets/custom_content_screen_list.dart';
import 'package:vloo/app/data/widgets/primary_appbar.dart';
import 'package:vloo/app/modules/myscreens/controllers/myscreens_controller.dart';
import 'package:vloo/app/modules/myscreens/views/chooseProjectBroadcast.dart';
import 'package:vloo/app/modules/templates/controllers/templates_controller.dart';

import 'previewMedia.dart';
import 'previewProject.dart';

class ContentScreenListing extends GetView<MyscreensController> {
  const ContentScreenListing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: PrimaryAppbar(
        title: Strings.contentOfTheScreen,
        text: Strings.confirm,
        onPressed: () {
          Get.back();
        },
        onPressed2: () {
          //TODO: Add sorting API call here for media sorting
        },
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Center(
          child: Text(
            Strings.broadcastContent,
            style: CustomTextStyle.font20R.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Text(
            Strings.dragDropContentMessage,
            style: CustomTextStyle.font16R,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        GestureDetector(
          onTap: () {
            Get.to( ()=> const ChooseProjectBroadcast());
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                border: Border.all(
                  color: AppColor.appSkyBlue,
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  StaticAssets.icPlus,
                  fit: BoxFit.none,
                ),
                Text(
                  Strings.addContentToStream,
                  style: CustomTextStyle.font16R.copyWith(fontWeight: FontWeight.bold, color: AppColor.appSkyBlue),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 25.h,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Obx(() => SlidableAutoCloseBehavior(
              closeWhenOpened: true,
              closeWhenTapped: true,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: controller.selectedScreenModel.value.uploadMedias?.length,
                itemBuilder: (BuildContext context, int index) => GestureDetector(
                  onTap: () async {
                    if(controller.selectedScreenModel.value.uploadMedias?[index].isTemplate == true){
                      Template? template;
                      if (!Get.isRegistered<TemplatesController>()) {
                        Get.put<TemplatesController>(TemplatesController());
                      }
                       if (controller.selectedScreenModel.value.orientation?.split(' ').first.toLowerCase()==Strings.portrait) {
                         controller.fetchFilteredList("Portrait")?.forEach((element) {
                           template = controller.fetchFilteredList("Portrait")?.where((element) => element.id == controller.selectedScreenModel.value.uploadMedias?[index].id).first;
                         });
                         Get.find<TemplatesController>().toCreateTemplateView(OrientationType.Portrait.name, Strings.editTemplate,template);
                         await Future.delayed(Duration.zero);
                         Get.find<TemplatesController>().toPreviewTemplates((9.w/16.h), Strings.portrait,noOfClose: 2);
                       }else{
                         controller.fetchFilteredList("Landscape")?.forEach((element) {
                           template = controller.fetchFilteredList("Landscape")?.where((element) => element.id == controller.selectedScreenModel.value.uploadMedias?[index].id).first;
                         });
                         Get.find<TemplatesController>().toCreateTemplateViewLandScape(OrientationType.Landscape.name, Strings.editTemplate,template);
                         await Future.delayed(Duration.zero);
                         Get.find<TemplatesController>().toPreviewTemplates(16.h/9.w, Strings.landscape,noOfClose: 2);
                       }
                    }else {
                      controller.selectedScreenModel.value.uploadMedias?[index].type == "Video" ? Get.to(()=>PreviewProject(mediaModel: controller.selectedScreenModel.value.uploadMedias?[index])) : Get.to(()=>PreviewMedia(mediaModel: controller.selectedScreenModel.value.uploadMedias?[index]));
                    }
                  },
                  child: Slidable(
                    controller: index==0?controller.slidableController:null,
                    endActionPane: ActionPane(
                      motion: const StretchMotion(),
                      children: [
                        SlidableAction(
                          borderRadius: BorderRadius.circular(20.w),
                          onPressed: (context)async{
                            await Future.delayed(const Duration(milliseconds: 100));
                            Utils.confirmationAlert(context: context,
                                onPressedPositive: (){
                                  // if templateId is coming the APii will detach template from the screen else detach Media
                                        if(controller.selectedScreenModel.value.uploadMedias?[index]?.isTemplate==false) {
                                          controller.removeMyScreenContent(mediaID: controller.selectedScreenModel.value.uploadMedias?[index].id);
                                        }else {
                                          controller.removeMyScreenContent(templateId: controller.selectedScreenModel.value.uploadMedias?[index].id);
                                        }
                                        Get.close(2);
                                },
                                onPressedNegative: ()=>Get.back(),
                                description: Strings.areYouSureYouWantDelete,
                                positiveText: Strings.delete,
                              negativeText: Strings.cancel

                            );
                          },
                          backgroundColor: AppColor.secondaryColor,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Detach',
                          spacing: 4,
                        ),
                      ],
                    ),
                    child: Container(
                        margin: const EdgeInsets.all(5.0),
                        padding: EdgeInsets.only(left: 22.w, right: 22.w, top: 20.h),
                        decoration: BoxDecoration(border: Border.all(color: AppColor.appLightBlue), borderRadius: BorderRadius.circular(20)),
                        child: CustomContentScreenList(
                          mediaModel: controller.selectedScreenModel.value.uploadMedias?[index],
                          index: index.toString(),
                        )),
                  ),
                ),
              ),
            )),
          ),
        ),
      ]),
    );
  }
}
