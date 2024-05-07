import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/utils/static_assets.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/utils/utils.dart';
import 'package:vloo/app/data/widgets/custom_column_icon.dart';
import 'package:vloo/app/data/widgets/custom_row_template.dart';
import 'package:vloo/app/data/widgets/secomdary_appbar.dart';
import 'package:vloo/app/modules/options/controllers/options_controller.dart';
import 'package:vloo/app/modules/options/views/options_view.dart';
import 'package:vloo/app/modules/templates/controllers/templates_controller.dart';
import 'package:vloo/app/modules/templates/views/Widget/app_loader.dart';
import 'package:vloo/app/modules/templates/views/Widget/bg_color_edit_bottom_sheet.dart';
import 'package:vloo/app/modules/templates/views/Widget/resize.dart';
import 'package:vloo/app/modules/textEditing/controllers/title_editing_controller.dart';
import 'package:vloo/app/routes/app_pages.dart';
import '../../../../main.dart';
import '../../bottomNav/controllers/bottom_nav_controller.dart';

class DragAndResizeView extends GetView<TemplatesController> {
  final String? comingFrom;

  const DragAndResizeView({super.key, this.comingFrom});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: AppColor.primaryColor,
        appBar: SecondaryAppbar(
          isVisible: controller.isAppBarVisible?.value,
          isEyeEnabled: controller.isUnLock?.value == false && controller.recording.value == false ,
          isBroadcastEnabled: controller.isUnLock?.value == false ,
          isUndoEnabled: controller.historySingleItemList.isNotEmpty && controller.historyIndexCount > 0,
          isRedoEnabled: controller.historySingleItemList.isNotEmpty && controller.historyIndexCount < controller.historySingleItemList.length - 1,
          broadcastButtonText: /*controller.isUnLock?.value == false ? (controller.recording.value ? Strings.stop : Strings.record) : Strings.next*/
              Strings.broadcast,
          onBroadcastPressed: () async {
            if (controller.singleItemList.isNotEmpty) {
              if (controller.editTemplateModel?.id == null) {
                Utils.confirmationAlert(
                    context: context,
                    positiveText: Strings.confirm,
                    description: Strings.templateIsNotSavedYetConfirmationMessage,
                    negativeText: Strings.cancel,
                    onPressedPositive: () async {
                      controller.deSelectAllExceptLastNEntries(0);
                      controller.screenRecordController.exporter.clear();
                      AppLoader.showLoader();
                      if (
                      await controller.createCanvaTemplateAPI(Strings.portrait, controller.editTemplateModel?.id ?? 0,resetTemplate: false)) {
                        var isSaved = await controller.takeScreenshot();
                        if (isSaved) {
                          AppLoader.hideLoader();
                          Get.back();
                        } else {
                          AppLoader.hideLoader();
                          Get.back();
                        }
                      } else {
                        AppLoader.hideLoader();
                      }
                      await controller.templateListUpdate();
                      controller.editTemplateModel = controller.templateList[0];
                     await Future.delayed(Duration.zero);
                      controller.getUserSubscriptionPlan(Strings.portrait);
                    },
                    onPressedNegative: () {
                      Get.back();
                    });

              }else {
                await controller.getUserSubscriptionPlan(Strings.portrait);
              }
            }
          },
          onUndoPressed: () async {
            if (controller.historySingleItemList.isNotEmpty && controller.historyIndexCount > 0) {
              controller.historyIndexCount = controller.historyIndexCount - 1;
              controller.singleItemList.value = controller.historySingleItemList[controller.historyIndexCount];
            }
            Get.forceAppUpdate();
          },
          onRedoPressed: () {
            if (controller.historySingleItemList.isNotEmpty && controller.historyIndexCount < controller.historySingleItemList.length - 1) {
              controller.historyIndexCount = controller.historyIndexCount + 1;
              controller.singleItemList.value = controller.historySingleItemList[controller.historyIndexCount];
            }
            Get.forceAppUpdate();
          },
          onEyePressed: () async {
            if (controller.singleItemList.isNotEmpty) {
              controller.deSelectAllExceptLastNEntries(0);
              controller.toPreviewTemplates(9.w / 16.h,Strings.portrait);
            }
          },
          onBackPressed: () async => {
            if (controller.singleItemList.isNotEmpty && controller.historySingleItemList.length > 1)
              {
                controller.deSelectAllExceptLastNEntries(0),
                Utils.confirmationAlert(
                    context: context,
                    description: Strings.saveChangesLeave,
                    negativeText: Strings.saveLeave,
                    positiveText: Strings.saveWithoutLeave,
                    onPressedPositive: () {
                      controller.screenRecordController.exporter.clear();
                      Get.back();
                      controller.resetCanvaTemplate(1);
                      Get.back();
                    },
                    onPressedNegative: () async {
                      Get.back();
                      controller.screenRecordController.exporter.clear();
                      AppLoader.showLoader();
                      if (
                      await controller.createCanvaTemplateAPI(Strings.portrait, controller.editTemplateModel?.id ?? 0)) {
                        var isSaved = await controller.takeScreenshot();
                        if (isSaved) {
                          controller.resetCanvaTemplate(comingFrom?.contains('edit') == true ? 0 : 1);
                          AppLoader.hideLoader();
                          Get.back();
                        } else {
                          AppLoader.hideLoader();
                          Get.back();
                        }
                      } else {
                        AppLoader.hideLoader();
                      }
                      Get.back();
                      Get.find<BottomNavController>().currentIndex.value = 1;

                    })
              }
            else {
              await Get.offAllNamed(Routes.bottomNav),
              await Future.delayed(Duration.zero),
              Get.find<BottomNavController>().currentIndex.value = 1,
              controller.resetEmptyCanvaTemplate()

              }
          },
        ),
        body: Obx(
          ()  => Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    if (controller.isAppBarVisible?.value == false) SizedBox(height: Get.height * 0.13),
                    InteractiveViewer(
                      transformationController: controller.transformationController,
                      minScale: 1,
                      maxScale: controller.maxScale.value,
                      child: RepaintBoundary(
                        key: controller.myThumbnailGlobalKey,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: AspectRatio(
                            aspectRatio: 9.w / 16.h,
                            child: DragAndResizeWidget(
                                singleItemList: controller.singleItemList,
                                startDragOffset: controller.startDragOffset,
                                backgroundImage: controller.backgroundImage.value,
                                isAnimEnabled: false,
                                isBottomSheetLocked: controller.isBottomSheetLocked.value,
                                selectedTemplateBackGroundColor: controller.currentTemplateBackgroundColor.value,
                                orientation: Strings.portrait,
                                callBack: (list) {
                                  // controller.sendDataToServer(list);
                                }),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 25.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.showNewView.value = true;
                              controller.isAppBarVisible?.value = false;
                            },
                            child: CustomIcon(
                              text: 'element'.tr,
                              logoAsset: StaticAssets.elementIcon,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => controller.toTemplateLayers(context),
                            child: CustomIcon(
                              text: 'layers'.tr,
                              logoAsset: StaticAssets.layerIcon,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (!Get.isRegistered<TemplatesController>()) {
                                Get.put<TemplatesController>(TemplatesController());
                              }
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: const Color.fromARGB(0, 255, 0, 0),
                                builder: (context) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                          decoration: BoxDecoration(
                                              color: AppColor.primaryDarkColor,
                                              border: const Border(
                                                top: BorderSide(
                                                    width: 2.0,
                                                    color: AppColor.appSkyBlue), // Top border
                                                right: BorderSide.none, // No border on the right
                                                bottom: BorderSide.none, // No border on the bottom
                                                left: BorderSide.none, // No border on the left
                                              ),
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20.sp),
                                                topRight: Radius.circular(20.sp),
                                              )),
                                          child: const BgColorEditView()),
                                    ],
                                  );
                                },
                              );
                            },
                            child: CustomIcon(
                              text: 'background'.tr,
                              logoAsset: StaticAssets.backgroundIcon,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (controller.singleItemList.isEmpty) {
                                scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(3, Strings.addElementsTemplateFirst));
                              } else {
                                controller.isBottomSheetLocked.toggle();
                                controller.maxScale.value == 1 ? controller.maxScale.value = 3.0 : controller.maxScale.value = 1;
                                controller.isUnLock?.value = !controller.isUnLock!.value;
                                controller.isEyeBlinkerEnabled.value = controller.isUnLock?.value == false;
                                controller.screenLock(); // deselect all selected widget
                              }
                            },
                            child: CustomIcon(
                              text: controller.isUnLock?.value == true ? 'lock'.tr : 'unlock'.tr,
                              textColor: controller.isUnLock?.value == true ? AppColor.appLightBlue : AppColor.red,
                              logoAsset: controller.isUnLock?.value == true ? StaticAssets.unlockIcon : StaticAssets.icLock,
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (!Get.isRegistered<OptionsController>()) {
                                Get.put<OptionsController>(OptionsController());
                              }
                              controller.title.value = await Get.to(()=>OptionsView(
                                templateModel: controller.editTemplateModel,
                                comingFrom: comingFrom,
                                orientation: OrientationType.Portrait.name,
                              ))??'';
                            },
                            child: const CustomIcon(
                              text: Strings.options,
                              logoAsset: StaticAssets.optionIcon,
                            ),
                          ),
                          // SizedBox(
                          //   width: 30.w,
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Obx(
                () => Visibility(
                  visible: controller.showNewView.value,
                  child: Container(
                    color: const Color.fromARGB(255, 3, 14, 21).withOpacity(0.80),
                    child: Center(
                      child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(20.w, 0, 0, 90),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () => controller.toImageElementView(Strings.portrait, Strings.addElementImage, 0),
                                      child: CustomRowTemplate(
                                        text: 'image'.tr,
                                        logoAsset: StaticAssets.imageIcon,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 32.h,
                                    ),
                                    GestureDetector(
                                      onTap: () => controller.toAddTitleElementView(Strings.portrait, Strings.addElementTitle, 0),
                                      child: CustomRowTemplate(
                                        text: 'title'.tr,
                                        logoAsset: StaticAssets.titleIcon,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 32.h,
                                    ),
                                    GestureDetector(
                                      onTap: () => controller.toDescriptionElementView(Strings.portrait, Strings.addElementDescription, 0),
                                      child: CustomRowTemplate(
                                        text: 'description'.tr,
                                        logoAsset: StaticAssets.descriptionIcon,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 32.h,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (!Get.isRegistered<TitleEditingController>()) {
                                          Get.put(TitleEditingController());
                                        }
                                        Get.find<TitleEditingController>().addDefaultCurrency();
                                        controller.toPriceElementView(Strings.portrait, Strings.addElementPrice, 0);
                                      },
                                      child: CustomRowTemplate(
                                        text: 'price'.tr,
                                        logoAsset: StaticAssets.priceIcon,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 32.h,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        controller.toggleNewView();
                                        controller.isAppBarVisible?.value = true;
                                      },
                                      child: CustomRowTemplate(
                                        text: 'close'.tr,
                                        logoAsset: StaticAssets.downButton,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
