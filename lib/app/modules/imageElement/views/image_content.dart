import 'package:animate_do/animate_do.dart';
import 'package:animated_flutter_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/configs/text.dart';
import 'package:vloo/app/data/models/template/template_single_item_model.dart';
import 'package:vloo/app/data/utils/static_assets.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/utils/utils.dart';
import 'package:vloo/app/modules/imageElement/controllers/image_element_controller.dart';

class ImageContent extends GetView<ImageElementController> {
  final bool isAnimEnabled;

  const ImageContent({
    super.key,
    required this.isAnimEnabled,
  });

  Widget imageWidget() {
    return Obx(() => Stack(
      alignment: Alignment.center,
          children: [
            controller.isBackgroundRemoved.value ? Image.memory(controller.processedImageBytes.value!, height: 150.h, width: 200.w, fit: BoxFit.contain) : Utils.getNetworkImage(controller.imageUrl.value, BoxFit.contain, 150, 150),
            // Image.file(File(controller.image.value),
            //     height: 150, width: 200, fit: BoxFit.contain),
            controller.selectedSticker!.value == ''
                ? const SizedBox()
                : SvgPicture.asset(controller.selectedSticker!.value, height: 80.h, width: 80.w, fit: BoxFit.contain),
          ],
        ));
  }

  Widget appliedAnimationImageWidget(TemplateSingleItemModel templateSingleItemModel) {
    if (isAnimEnabled) {
      switch (templateSingleItemModel.animation) {
        case "ImageTransitionsAndMoves.none":
          return appliedMoveAnimationWidget(templateSingleItemModel, imageWidget());
        case "ImageTransitionsAndMoves.appear":
          return EaseInAnimation(child: appliedMoveAnimationWidget(templateSingleItemModel, imageWidget()));
        case "ImageTransitionsAndMoves.left":
          return SlideInLeft(animate: true, duration: const Duration(seconds: 1), child: appliedMoveAnimationWidget(templateSingleItemModel, imageWidget()));
        case "ImageTransitionsAndMoves.right":
          return SlideInRight(animate: true, duration: const Duration(seconds: 1), child: appliedMoveAnimationWidget(templateSingleItemModel, imageWidget()));

        case "ImageTransitionsAndMoves.top":
          return SlideInUp(animate: true, duration: const Duration(seconds: 1), child: appliedMoveAnimationWidget(templateSingleItemModel, imageWidget()));
        case "ImageTransitionsAndMoves.down":
          return SlideInDown(animate: true, duration: const Duration(seconds: 1), child: appliedMoveAnimationWidget(templateSingleItemModel, imageWidget()));
      }
    }
    return imageWidget();
  }

  Widget appliedMoveAnimationWidget(TemplateSingleItemModel templateSingleItemModel, Widget child) {
    if (isAnimEnabled) {
      switch (templateSingleItemModel.effect) {
        case "ImageTransitionsAndMoves.none":
          return child;
        case "ImageTransitionsAndMoves.pulse":
          return Pulse(infinite: true, child: child);
        case "ImageTransitionsAndMoves.positionH":
          return ShakeX(infinite: true, child: child);
        case "ImageTransitionsAndMoves.positionV":
          return ShakeY(infinite: true, child: child);
        case "ImageTransitionsAndMoves.wiggle":
          return Swing(infinite: true, child: child);
        case "ImageTransitionsAndMoves.shaking":
          return ShakeAnimation(child: child);
      }
    }
    return child;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              appliedAnimationImageWidget(TemplateSingleItemModel(
                effect: controller.imageMove.value.toString(),
                animation: controller.imageTransition.value.toString(),
              )),
              SizedBox(
                height: 27.h,
              ),
              GestureDetector(
                onTap: () async {
                  await controller.removeBgApi(controller.imageUrl.value);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      StaticAssets.bgRemoverIcon,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Obx(
                      () => Text(
                        controller.isBackgroundRemoved.value ? Strings.returnToOriginal : Strings.removeBackground,
                        style: CustomTextStyle.font16R,
                      ),
                    )
                  ],
                ),
              ),
              if (controller.errorMessage.value != null)
                Obx(() => Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              controller.errorMessage.value!,
                              style: const TextStyle(color: Colors.red),
                            ),
                            SizedBox(height: 20.h),
                            ElevatedButton(
                              onPressed: () {
                                controller.errorMessage.value = null;
                              },
                              child: const Text(Strings.ok),
                            ),
                            SizedBox(height: 100.h),
                          ],
                        ),
                      ),
                    ))
            ],
          ),
        )
      ],
    );
  }
}
