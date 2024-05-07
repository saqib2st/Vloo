import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screen_recorder/screen_recorder.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/widgets/primary_appbar.dart';
import 'package:vloo/app/modules/templates/controllers/templates_controller.dart';
import 'package:vloo/app/modules/templates/views/Widget/resize.dart';

class PreviewTemplateView extends GetView<TemplatesController> {
  final String? comingFrom;
  final double aspectRatio;
  final int? noOfClose;

  const PreviewTemplateView(
      {super.key, required this.aspectRatio, this.comingFrom, this.noOfClose});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: PrimaryAppbar(
        title: Strings.previewOfProject,
        text: '',
        onPressed: () {
          controller.transformationController.value = Matrix4.identity();
          controller.screenRecordController.exporter.clear();
          Get.close(noOfClose ?? 1);
        },
        onPressed2: () {
          //TODO: Handle broadcast code here.
        },
      ),
      body: IgnorePointer(
        child: SingleChildScrollView(
          child: Obx(
            () => Column(
              children: [
                SizedBox(height: comingFrom == Strings.landscape? Get.height* 0.16 : 0),
                InteractiveViewer(
                  transformationController: controller.transformationController,
                  maxScale: controller.maxScale.value,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: AspectRatio(
                      aspectRatio: aspectRatio,
                      child: LayoutBuilder(
                        builder:
                            (BuildContext context, BoxConstraints constraints) {
                          return ScreenRecorder(
                            height: constraints.maxHeight,
                            width: constraints.maxWidth,
                            background: Colors.white,
                            controller: controller.screenRecordController,
                            child: DragAndResizeWidget(
                                singleItemList: controller.singleItemList,
                                startDragOffset: controller.startDragOffset,
                                backgroundImage: controller.backgroundImage.value,
                                isAnimEnabled: true,
                                isBottomSheetLocked: false,
                                selectedTemplateBackGroundColor: controller.currentTemplateBackgroundColor.value,
                                orientation: Strings.landscape,
                                callBack: (list) {
                                  // controller.sendDataToServer(list);
                                }),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
