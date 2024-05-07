import 'dart:math' as math;
import 'dart:math';
import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_box_transform/flutter_box_transform.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glitcheffect/glitcheffect.dart';
import 'package:neon_widgets/neon_widgets.dart';
import 'package:spring/spring.dart';
import 'package:text_neon_widget/text_neon_widget.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/configs/text.dart';
import 'package:vloo/app/data/models/template/template_single_item_model.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/utils/utils.dart';
import 'package:vloo/app/modules/imageElement/controllers/image_element_controller.dart';
import 'package:vloo/app/modules/templates/controllers/templates_controller.dart';
import 'package:vloo/app/modules/templates/views/Widget/app_loader.dart';
import 'package:vloo/app/modules/templates/views/Widget/bottom_sheet_tabs.dart';
import 'package:vloo/app/modules/textEditing/controllers/title_editing_controller.dart';
import 'package:vloo/app/modules/textEditing/views/editing/circular_label.dart';
import 'package:vloo/app/modules/textEditing/views/editing/rectangle_label.dart';
import 'package:vloo/app/modules/textEditing/views/editing/rectangle_label_rounded.dart';
import 'package:vloo/app/routes/app_pages.dart';
import '../../../../data/utils/static_assets.dart';
// ignore: must_be_immutable
class DragAndResizeWidget extends StatefulWidget {
  TemplatesController templatesController = Get.find<TemplatesController>();

  final List<TemplateSingleItemModel> singleItemList;
  final bool isAnimEnabled;
  final bool isBottomSheetLocked;

  List<Offset>? startDragOffset = [];
  final Function(List<TemplateSingleItemModel>) callBack;
  String? backgroundImage = '';
  String orientation = '';
  Color? selectedTemplateBackGroundColor = Colors.transparent;

  DragAndResizeWidget(
      {super.key,
      required this.isBottomSheetLocked,
      required this.isAnimEnabled,
      required this.singleItemList,
      required this.callBack,
      this.backgroundImage,
      this.selectedTemplateBackGroundColor,
      required this.orientation,
      this.startDragOffset});

  @override
  State<DragAndResizeWidget> createState() => _DragAndResizeWidgetState();
}

class _DragAndResizeWidgetState extends State<DragAndResizeWidget> {
  bool isDraggable = true;
  late IconData iconData;
  double resizeElement =  2.0;

  Text textWidget(TemplateSingleItemModel templateSingleItemModel) {
    return Text(templateSingleItemModel.valueLocal ?? '',
        textAlign: templateSingleItemModel.selectedAlignment == 0
            ? TextAlign.start
            : templateSingleItemModel.selectedAlignment == 1
                ? TextAlign.center
                : TextAlign.end,
        style: TextStyle(
          height: 1.0,
          fontFamily: templateSingleItemModel.fontFamily,
          fontSize: setFontSize(templateSingleItemModel.fontSize ?? 10),
          color: Utils.fetchColorFromStringColor(templateSingleItemModel.textColor),
          backgroundColor: Utils.fetchColorFromStringColor(templateSingleItemModel.backgroundColor),
        ));
  }

  double setFontSize(double fontSize) {
    if (fontSize > 80) {
      return 80;
    } else if (fontSize < 5) {
      return 5;
    } else {
      return fontSize;
    }
  }

  Widget appliedEffectWidget(TemplateSingleItemModel templateSingleItemModel) {
    SpringController springControllerFade = SpringController(initialAnim: Motion.mirror);
    SpringController springControllerBlink = SpringController(initialAnim: Motion.mirror);
    if (widget.isAnimEnabled) {
      // Show all this effects only on preview screen
      switch (templateSingleItemModel.effect) {
        case StaticAssets.noneIcon:
          return textWidget(templateSingleItemModel);
        case StaticAssets.effectNeon:
          return PTTextNeon(
            text: templateSingleItemModel.valueLocal ?? "",
            color: Utils.fetchMaterialColorFromStringColor(templateSingleItemModel.textColor),
            font: templateSingleItemModel.fontFamily,
            shine: true,
            fontSize: templateSingleItemModel.fontSize,
            strokeWidthTextHigh: 3,
            blurRadius: 5,
            strokeWidthTextLow: 1,
            backgroundColor: Utils.fetchMaterialColorFromStringColor(templateSingleItemModel.backgroundColor),
          );
        case StaticAssets.effectGlitch:
          return GlitchEffect(
            child: textWidget(templateSingleItemModel),
          );
        case StaticAssets.effectFade:
          if(templateSingleItemModel.animation != 'None'){
            return Text(
              templateSingleItemModel.valueLocal ?? "",
              style: TextStyle(
                fontFamily: templateSingleItemModel.fontFamily,
                fontSize: setFontSize(templateSingleItemModel.fontSize ?? 15),
                color: Utils.fetchColorFromStringColor(templateSingleItemModel.textColor),
                shadows: [Shadow(color: Utils.fetchColorFromStringColor(templateSingleItemModel.backgroundColor), blurRadius: 30, offset: Offset.zero)],
              ),
            );
          }else{
            return Spring.fadeOut(
                springController: springControllerFade,
                delay: const Duration(milliseconds: 1000),
                animDuration: const Duration(milliseconds: 4000),
                child: Text(
                  templateSingleItemModel.valueLocal ?? "",
                  style: TextStyle(
                    fontFamily: templateSingleItemModel.fontFamily,
                    fontSize: setFontSize(templateSingleItemModel.fontSize ?? 15),
                    color: Utils.fetchColorFromStringColor(templateSingleItemModel.textColor),
                    shadows: [Shadow(color: Utils.fetchColorFromStringColor(templateSingleItemModel.backgroundColor), blurRadius: 30, offset: Offset.zero)],
                  ),
                ));
          }
        case StaticAssets.effectCut:
          return Spring.blink(
            springController: springControllerBlink,
            startOpacity: 0.1, //default=0.0
            endOpacity: 0.9,
            animDuration:const Duration(milliseconds: 1500),
            child: Text(templateSingleItemModel.valueLocal ?? '',
            style: CustomTextStyle.font22R.copyWith(color: Colors.white),
            ),
          );
        case StaticAssets.effectBlink:
          return FlickerNeonText(
            fontFamily: templateSingleItemModel.fontFamily,
            textColor: Utils.fetchColorFromStringColor(templateSingleItemModel.textColor),
            textAlign: templateSingleItemModel.selectedAlignment == 0
                ? TextAlign.start
                : templateSingleItemModel.selectedAlignment == 1
                    ? TextAlign.center
                    : TextAlign.end,
            text: templateSingleItemModel.valueLocal ?? "",
            flickerTimeInMilliSeconds: 1200,
            spreadColor: Utils.fetchColorFromStringColor(templateSingleItemModel.backgroundColor),
            blurRadius: 20,
            textSize: setFontSize(templateSingleItemModel.fontSize ?? 15),
          );
      }
    }
    return textWidget(templateSingleItemModel);
  }

  Widget appliedAnimationTextWidget(TemplateSingleItemModel templateSingleItemModel) {
    SpringController springControllerFade = SpringController(initialAnim: Motion.mirror);
    final SpringController springControllerLeft = SpringController(initialAnim: Motion.mirror);
    final SpringController springControllerRight = SpringController(initialAnim: Motion.mirror);
    final SpringController springControllerUp = SpringController(initialAnim: Motion.mirror);
    final SpringController springControllerBottom = SpringController(initialAnim: Motion.mirror);
    if (widget.isAnimEnabled) {
      // Show all this animation only on preview screen
      switch (templateSingleItemModel.animation) {
        case 'None':
          return appliedEffectWidget(templateSingleItemModel);
        case 'Appear':
          return Spring.fadeOut(
              springController: springControllerFade,
              delay: const Duration(milliseconds: 1000),
              animDuration: const Duration(milliseconds: 4000),
              child: Text(
                templateSingleItemModel.valueLocal ?? "",
                style: TextStyle(
                  fontFamily: templateSingleItemModel.fontFamily,
                  fontSize: setFontSize(templateSingleItemModel.fontSize ?? 15),
                  color: Utils.fetchColorFromStringColor(templateSingleItemModel.textColor),
                  shadows: [Shadow(color: Utils.fetchColorFromStringColor(templateSingleItemModel.backgroundColor), blurRadius: 30, offset: Offset.zero)],
                ),
              ));

        //FadedScaleAnimation(scaleDuration: const Duration(milliseconds: 1500), child: appliedEffectWidget(templateSingleItemModel));
        case 'Left':
          return Spring.slide(
      springController: springControllerLeft,
      slideType: SlideType.slide_out_left,
      animDuration: const Duration(seconds: 3),
      withFade:templateSingleItemModel.effect == StaticAssets.effectFade,
      delay: const Duration(seconds: 2),
      cutomTweenOffset: Tween<Offset>(begin: const Offset(0,0),end:const Offset(-100, 0) ),
      child: appliedEffectWidget(templateSingleItemModel));
          case 'Right':
      return Spring.slide(
      springController: springControllerRight,
      slideType: SlideType.slide_out_right,
      animDuration: const Duration(seconds: 3),
      withFade: templateSingleItemModel.effect == StaticAssets.effectFade,
      delay: const Duration(seconds: 2),
      cutomTweenOffset: Tween<Offset>(begin: const Offset(0,0),end:const Offset(100, 0) ),
      child: appliedEffectWidget(templateSingleItemModel));
        case 'Top':
          return Spring.slide(
              springController: springControllerUp,
              slideType: SlideType.slide_out_bottom,
              animDuration: const Duration(seconds: 3),
              withFade: templateSingleItemModel.effect == StaticAssets.effectFade,
              delay: const Duration(seconds: 2),
              cutomTweenOffset: Tween<Offset>(begin: const Offset(0,0),end:const Offset(0, -50) ),
              child: appliedEffectWidget(templateSingleItemModel));

        case 'Down':
          return Spring.slide(
              springController: springControllerBottom,
              slideType: SlideType.slide_out_top,
              animDuration: const Duration(seconds: 3),
              withFade: templateSingleItemModel.effect == StaticAssets.effectFade,
              delay: const Duration(seconds: 2),
              cutomTweenOffset: Tween<Offset>(begin: const Offset(0,0),end:const Offset(0, 50) ),
              child: appliedEffectWidget(templateSingleItemModel));
      }
    }
    return appliedEffectWidget(templateSingleItemModel);
  }

  Widget imageWidget(TemplateSingleItemModel templateSingleItemModel) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Utils.getNetworkImage(templateSingleItemModel.valueLocal ?? '', BoxFit.cover, templateSingleItemModel.width, templateSingleItemModel.height),
        templateSingleItemModel.availability == ''
            ? const SizedBox()
            : Center(
                child: SvgPicture.asset(
                  templateSingleItemModel.availability ?? '',
                  height: templateSingleItemModel.height!.toDouble() * 0.45,
                  fit: BoxFit.contain,
                ),
              ),
      ],
    );
  }

  Widget appliedAnimationImageWidget(TemplateSingleItemModel templateSingleItemModel, Widget child) {
    final SpringController springControllerOpacity = SpringController(initialAnim: Motion.mirror);
    final SpringController springControllerLeft = SpringController(initialAnim: Motion.mirror);
    final SpringController springControllerRight = SpringController(initialAnim: Motion.mirror);
    final SpringController springControllerUp = SpringController(initialAnim: Motion.mirror);
    final SpringController springControllerBottom = SpringController(initialAnim: Motion.mirror);
    if (widget.isAnimEnabled) {
      // Show all this effects only on preview screen
      switch (templateSingleItemModel.animation) {
        case "ImageTransitionsAndMoves.none":
          return child;
        case "ImageTransitionsAndMoves.appear":
           return Spring.opacity(
              springController: springControllerOpacity,
              startOpacity: 1.0,
              endOpacity: 0.0,
              animDuration: const Duration(seconds: 3),
              delay: const Duration(seconds: 1),
              child: child);
        case "ImageTransitionsAndMoves.left":
          return Spring.slide(
              springController: springControllerLeft,
              slideType: SlideType.slide_out_left,
              animDuration: const Duration(seconds: 3),
              withFade: true,
              delay: const Duration(seconds: 2),
              cutomTweenOffset: Tween<Offset>(begin: const Offset(0,0),end:const Offset(-100, 0) ),
              child: child);
        case "ImageTransitionsAndMoves.right":
          return Spring.slide(
              springController: springControllerRight,
              slideType: SlideType.slide_out_right,
              animDuration: const Duration(seconds: 3),
              withFade: true,
              delay: const Duration(seconds: 2),
              cutomTweenOffset: Tween<Offset>(begin: const Offset(0,0),end:const Offset(100, 0) ),
              child: child);
        case "ImageTransitionsAndMoves.top":
          return Spring.slide(
              springController: springControllerUp,
              slideType: SlideType.slide_out_bottom,
              animDuration: const Duration(seconds: 3),
              withFade: true,
              delay: const Duration(seconds: 2),
              cutomTweenOffset: Tween<Offset>(begin: const Offset(0,0),end:const Offset(0, -50) ),
              child: child);
        case "ImageTransitionsAndMoves.down":
         return Spring.slide(
              springController: springControllerBottom,
              slideType: SlideType.slide_out_top,
              animDuration: const Duration(seconds: 3),
              withFade: true,
              delay: const Duration(seconds: 2),
              cutomTweenOffset: Tween<Offset>(begin: const Offset(0,0),end:const Offset(0, 50) ),
              child: child);
      }
    }
    return imageWidget(templateSingleItemModel);
  }

  Widget appliedAnimationPriceWidget(TemplateSingleItemModel templateSingleItemModel, Widget child) {
    final SpringController springControllerOpacity = SpringController(initialAnim: Motion.mirror);
    final SpringController springControllerLeft = SpringController(initialAnim: Motion.mirror);
    final SpringController springControllerRight = SpringController(initialAnim: Motion.mirror);
    final SpringController springControllerUp = SpringController(initialAnim: Motion.mirror);
    final SpringController springControllerBottom = SpringController(initialAnim: Motion.mirror);
    if (widget.isAnimEnabled) {
      // Show all this effects only on preview screen
      switch (templateSingleItemModel.animation) {
        case "None":
          return child;
        case "Appear":
          return Spring.opacity(
              springController: springControllerOpacity,
              startOpacity: 1.0,
              endOpacity: 0.0,
              animDuration: const Duration(seconds: 3),
              delay: const Duration(seconds: 1),
              child: child);
        case "Left":
          return Spring.slide(
              springController: springControllerLeft,
              slideType: SlideType.slide_out_left,
              animDuration: const Duration(seconds: 3),
              delay: const Duration(seconds: 2),
              cutomTweenOffset: Tween<Offset>(begin: const Offset(0,0),end:const Offset(-100, 0) ),
              child: child);
        case "Right":
          return Spring.slide(
              springController: springControllerRight,
              slideType: SlideType.slide_out_right,
              animDuration: const Duration(seconds: 3),
              delay: const Duration(seconds: 2),
              cutomTweenOffset: Tween<Offset>(begin: const Offset(0,0),end:const Offset(100, 0) ),
              child: child);
        case "Top":
          return Spring.slide(
              springController: springControllerUp,
              slideType: SlideType.slide_out_bottom,
              animDuration: const Duration(seconds: 3),
              delay: const Duration(seconds: 2),
              cutomTweenOffset: Tween<Offset>(begin: const Offset(0,0),end:const Offset(0, -50) ),
              child: child);
        case "Down":
          return Spring.slide(
              springController: springControllerBottom,
              slideType: SlideType.slide_out_top,
              animDuration: const Duration(seconds: 3),
              delay: const Duration(seconds: 2),
              cutomTweenOffset: Tween<Offset>(begin: const Offset(0,0),end:const Offset(0, 50) ),
              child: child);
      }
    }
    return child;
  }

  Widget setPriceTheme(int index, TemplateSingleItemModel templateSingleItemModel) {
    if (templateSingleItemModel.valueLocal!.isNotEmpty) {
      switch (templateSingleItemModel.theme) {
        case StaticAssets.priceTheme3Icon:
          return RectangleLabel(
              text: templateSingleItemModel.valueLocal?.obs ??''.obs,
              textColor: Utils.fetchColorFromStringColor(templateSingleItemModel.textColor),
              bgColor: Utils.fetchColorFromStringColor(templateSingleItemModel.backgroundColor),
              templateSingleItemModel: templateSingleItemModel,
              backgroundImage: StaticAssets.rectangular);
        case StaticAssets.priceTheme2Icon:
          return CircularLabel(
              text: templateSingleItemModel.valueLocal?.obs ??''.obs,
              textColor: Utils.fetchColorFromStringColor(templateSingleItemModel.textColor),
              bgColor: Utils.fetchColorFromStringColor(templateSingleItemModel.backgroundColor),
              templateSingleItemModel: templateSingleItemModel,
              backgroundImage: StaticAssets.circular);
        case StaticAssets.priceTheme1Icon:
          return RectangleLabelRounded(
              text: templateSingleItemModel.valueLocal?.obs ??''.obs,
              textColor: Utils.fetchColorFromStringColor(templateSingleItemModel.textColor),
              bgColor: Utils.fetchColorFromStringColor(templateSingleItemModel.backgroundColor),
              templateSingleItemModel: templateSingleItemModel,
              backgroundImage: StaticAssets.rectangularRounded);
      }
    }
    return const SizedBox();
  }

  Widget appliedMoveAnimationWidget(TemplateSingleItemModel templateSingleItemModel, Widget child) {
    final SpringController springController = SpringController(initialAnim: Motion.mirror);
    final SpringController springControllerScale = SpringController(initialAnim: Motion.mirror);
    final SpringController springControllerPositionUp = SpringController(initialAnim: Motion.mirror);
    Duration duration = const Duration(milliseconds: 2000);

    if (widget.isAnimEnabled) {
      // Show all this effects only on preview screen
      switch (templateSingleItemModel.effect) {
        case "ImageTransitionsAndMoves.none":
          return child;
        case "ImageTransitionsAndMoves.pulse":
          return Pulse(duration: const Duration(seconds: 4), infinite: true, child: child);
        case "ImageTransitionsAndMoves.positionH":
          return ShakeX(
              duration: const Duration(seconds: 4),
              infinite: true, child: child);
        case "ImageTransitionsAndMoves.positionV":
          return Spring.translate(
            springController: springControllerPositionUp,
            beginOffset: const Offset(0, 0),
            endOffset: const Offset(0, -25),
              animDuration: const Duration(seconds: 3),
               child: child);
        case "ImageTransitionsAndMoves.wiggle":
          return Spring.rotate(
            springController: springController,
            alignment: Alignment.center, //def=center
            startAngle:-2, //def=0
            endAngle: 2, //def=360
            delay: const Duration(milliseconds: 0),
            animDuration: duration, //def=1s
            animStatus: (AnimStatus status) {},
            curve: Curves.easeInOutBack, //def=Curves.easInOut
            child: Spring.scale(
                springController: springControllerScale,
                start: 1, end: 0.987, child: child),
          );
        case "ImageTransitionsAndMoves.shaking":
          return Spring.rotate(
            springController: springController,
            alignment: Alignment.center, //def=center
            startAngle:-6, //def=0
            endAngle: 6, //def=360
            delay: const Duration(milliseconds: 0),
            animDuration: duration, //def=1s
            animStatus: (AnimStatus status) {},
            curve: Curves.easeInOutBack, //def=Curves.easInOut
            child: child,
          );
      }
    }
    return child;
  }

  Widget setData(TemplateSingleItemModel templateSingleItemModel, int index) {
    if (templateSingleItemModel.theme == null || templateSingleItemModel.theme == '' || templateSingleItemModel.theme == StaticAssets.none) {
      if (templateSingleItemModel.comingFrom == Strings.addElementImage || templateSingleItemModel.comingFrom == Strings.editElementImage) {
        return Transform.rotate(
            angle: double.tryParse(templateSingleItemModel.rotation ?? "0.0") ?? 0.0,
            child: appliedAnimationImageWidget(templateSingleItemModel, appliedMoveAnimationWidget(templateSingleItemModel, imageWidget(templateSingleItemModel))));
      } else {
        return Transform.rotate(
          angle: double.tryParse(templateSingleItemModel.rotation ?? "0.0") ?? 0.0,
          child: appliedAnimationTextWidget(templateSingleItemModel),
        );
      }
    } else {
      return Transform.rotate(
          angle: double.tryParse(templateSingleItemModel.rotation ?? "0.0") ?? 0.0, child: appliedAnimationPriceWidget(templateSingleItemModel, setPriceTheme(index, templateSingleItemModel)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async  {
        widget.templatesController.transformationController.value = Matrix4.identity();
        widget.templatesController.showNewView.value = false;
        setState(() {
          for (var element in widget.singleItemList) {
            element.isSelected = false;
          }
        });
        if (widget.templatesController.singleItemList.isNotEmpty && widget.templatesController.historySingleItemList.length > 1) {
          Utils.confirmationAlert(
              context: context,
              description: Strings.saveChangesLeave,
              negativeText: Strings.saveLeave,
              positiveText: Strings.saveWithoutLeave,
              onPressedPositive: () {
                Get.back();
                // widget.templatesController.resetCanvaTemplate(widget.singleItemList.isNotEmpty && widget.singleItemList[0].comingFrom?.contains('edit') == true ? 0 : 1);
                widget.templatesController.resetCanvaTemplate(1);
                Get.back();
              },
              onPressedNegative: () async {
                if (await widget.templatesController.createCanvaTemplateAPI(Strings.portrait, widget.templatesController.editTemplateModel?.id ?? 0)) {
                  var isSaved = await widget.templatesController.takeScreenshot();
                  if (isSaved) {
                    widget.templatesController.resetCanvaTemplate(widget.singleItemList.isNotEmpty && widget.singleItemList[0].comingFrom?.contains('edit') == true ? 0 : 1);
                    AppLoader.hideLoader();
                    Get.offAllNamed(Routes.bottomNav);
                  } else {
                    AppLoader.hideLoader();
                    Get.back();
                  }
                }
              });
        } else {
          Get.back();
          widget.templatesController.resetEmptyCanvaTemplate();
        }
        return true;
        },
      child: Scaffold(
        backgroundColor: AppColor.primaryColor,
        body: Center(
          child: GestureDetector(
            onTap: () {
              widget.callBack(widget.singleItemList);
              setState(() {
                for (var element in widget.singleItemList) {
                  element.isSelected = false;
                }
              });
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: widget.templatesController.isUnLock?.value == true ? AppColor.appLightBlue : AppColor.red, width: 0.5),
                  image: widget.backgroundImage == "" ? null : DecorationImage(image: NetworkImage(widget.backgroundImage ?? ''), fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(widget.selectedTemplateBackGroundColor ?? Colors.transparent
                      , BlendMode.srcATop)
                  )),
              child: widget.singleItemList.isNotEmpty
                  ? Stack(
                      children: List.generate(
                      widget.singleItemList.length,
                      (index) => TransformableBox(
                        allowContentFlipping: false,
                        debugPaintHandleBounds: true,
                        resizable: widget.singleItemList[index].isSelected ?? false,
                        draggable: widget.singleItemList[index].isSelected ?? true,
                        rect: widget.singleItemList[index].rect,
                        enabledHandles: const {HandlePosition.bottomRight},
                        visibleHandles: const {
                          ...HandlePosition.values,
                        },
                        onChanged: (result, event) {
                          setState(() {
                            widget.singleItemList[index].rect = result.rect;
                            widget.singleItemList[index].xaxis = result.rect.left;
                            widget.singleItemList[index].yaxis = result.rect.top;
                            widget.singleItemList[index].height = result.rect.height;
                            widget.singleItemList[index].width = result.rect.width;

                            //  widget.templatesController.onUpdateHistoryStack();  // TODO: Changes for position updates are not saved for undo redo
                          });
                        },
                        contentBuilder: (BuildContext context, Rect rect, Flip flip) {
                          return GestureDetector(
                              onTap: () {
                                if (widget.isBottomSheetLocked) {
                                  // this is preview screen case. Do not allow modifications here.
                                  widget.templatesController.deSelectAllExceptLastNEntries(0);
                                } else {
                                  showModalBottomSheet(
                                    context: context,
                                    backgroundColor: AppColor.transparent,
                                    builder: (context) {
                                      return BottomSheetTabs(
                                          orientation: widget.orientation,
                                          index: index,
                                          comingFrom: (widget.singleItemList[index].comingFrom == Strings.addElementTitle || widget.singleItemList[index].comingFrom == Strings.editElementTitle)
                                              ? Strings.title
                                              : (widget.singleItemList[index].comingFrom == Strings.addElementDescription || widget.singleItemList[index].comingFrom == Strings.editElementDescription)
                                                  ? Strings.description
                                                  : (widget.singleItemList[index].comingFrom == Strings.addElementPrice || widget.singleItemList[index].comingFrom == Strings.editElementPrice)
                                                      ? Strings.price
                                                      : Strings.image);
                                    },
                                  );
                                  // For edit case on second tap
                                  if (widget.singleItemList[index].isSelected == true) {
                                    //editing
                                    if (widget.singleItemList[index].comingFrom == Strings.addElementTitle || widget.singleItemList[index].comingFrom == Strings.editElementTitle) {
                                      widget.singleItemList[index].tabsIndex = 0;
                                      Navigator.pop(context);
                                      Get.delete<TitleEditingController>();
                                      widget.templatesController.toTitleElementView(widget.orientation, Strings.editElementTitle, index);
                                    } else if (widget.singleItemList[index].comingFrom == Strings.addElementDescription || widget.singleItemList[index].comingFrom == Strings.editElementDescription) {
                                      widget.singleItemList[index].tabsIndex = 0;
                                      Navigator.pop(context);
                                      Get.delete<TitleEditingController>();
                                      widget.templatesController.toDescriptionElementView(widget.orientation, Strings.editElementDescription, index);
                                    } else if (widget.singleItemList[index].comingFrom == Strings.addElementPrice || widget.singleItemList[index].comingFrom == Strings.editElementPrice) {
                                      widget.singleItemList[index].tabsIndex = 0;
                                      Navigator.pop(context);
                                      Get.delete<TitleEditingController>();
                                      widget.templatesController.toPriceElementView(widget.orientation, Strings.editElementPrice, index);
                                    } else if (widget.singleItemList[index].comingFrom == Strings.addElementImage || widget.singleItemList[index].comingFrom == Strings.editElementImage) {
                                      widget.singleItemList[index].tabsIndex = 0;
                                      Get.delete<ImageElementController>();
                                      widget.templatesController.toEditImageElementView(widget.orientation, Strings.editElementImage, index);
                                    }
                                  } else {
                                    //make it selected on first tap
                                    if (widget.templatesController.isUnLock?.value == true) {
                                      setState(() {
                                        for (var element in widget.singleItemList) {
                                          element.isSelected = false;
                                        }
                                        widget.singleItemList[index].isSelected = true;
                                      });
                                    } else {
                                      // scaffoldKey.currentState?.showSnackBar(const SnackBar(content: Text(Strings.unLockTemplateFirst)));
                                    }
                                  }
                                }
                              },
                              child: Container(
                                  alignment: widget.singleItemList[index].comingFrom == Strings.addElementImage ? null : Alignment.center,
                                  decoration: BoxDecoration(
                                    border: widget.singleItemList[index].isSelected == true ? Border.all(color: AppColor.appSkyBlue, width: 2) : null,
                                  ),
                                  child: setData(widget.singleItemList[index], index)));
                        },
                        cornerHandleBuilder: (context, handle) {
                          if (handle == HandlePosition.topLeft) {
                            iconData = Icons.delete;
                          } else if (handle == HandlePosition.topRight) {
                            iconData = Icons.copy;
                          } else if (handle == HandlePosition.bottomLeft) {
                            iconData = Icons.rotate_right;
                          } else if (handle == HandlePosition.bottomRight) {
                            iconData = Icons.transform;
                          }
                          return GestureDetector(
                            onTap: () {
                              switch (handle) {
                                case HandlePosition.topLeft: // delete case
                                  setState(() {
                                    if (widget.singleItemList[index].id != null) {
                                      widget.templatesController.deletedElementList.add(widget.singleItemList[index].id!.toInt());
                                    }
                                    widget.singleItemList.removeAt(index);
                                    widget.templatesController.onUpdateHistoryStack();
                                  });

                                  break;
                                case HandlePosition.topRight: // Copy/duplicate case
                                  setState(() {
                                    String type = "";
                                    String value = "";
                                    TextStyle style = const TextStyle();

                                    void setDuplicateElementData(int index, String elementComingFrom) {
                                      value = widget.singleItemList[index].valueLocal ?? '';
                                      style = TextStyle(
                                        fontFamily: widget.singleItemList[index].fontFamily,
                                        fontSize: widget.singleItemList[index].fontSize,
                                        color: Utils.fetchColorFromStringColor(widget.singleItemList[index].textColor),
                                        backgroundColor: Utils.fetchColorFromStringColor(widget.singleItemList[index].backgroundColor),
                                      );
                                    }

                                    if (widget.singleItemList[index].comingFrom == Strings.addElementTitle || widget.singleItemList[index].comingFrom == Strings.editElementTitle) {
                                      type = "Title";
                                      setDuplicateElementData(index, widget.singleItemList[index].comingFrom ?? '');
                                    } else if (widget.singleItemList[index].comingFrom == Strings.addElementDescription || widget.singleItemList[index].comingFrom == Strings.editElementDescription) {
                                      type = "Description";
                                      setDuplicateElementData(index, widget.singleItemList[index].comingFrom ?? '');
                                    } else if (widget.singleItemList[index].comingFrom == Strings.addElementPrice || widget.singleItemList[index].comingFrom == Strings.editElementPrice) {
                                      type = "Price";
                                      setDuplicateElementData(index, widget.singleItemList[index].comingFrom ?? '');
                                    } else if (widget.singleItemList[index].comingFrom == Strings.addElementImage || widget.singleItemList[index].comingFrom == Strings.editElementImage) {
                                      type = "Image";
                                      value = widget.singleItemList[index].valueLocal ?? '';
                                    }

                                    widget.singleItemList.add(
                                      TemplateSingleItemModel(
                                        id: null,
                                        type: type,
                                        value: value,
                                        valueLocal: value,
                                        xaxis: widget.singleItemList[index].xaxis,
                                        yaxis: widget.singleItemList[index].yaxis,
                                        height: widget.singleItemList[index].height,
                                        width: widget.singleItemList[index].width,
                                        currency: widget.singleItemList[index].currency,
                                        fontFamily: style.fontFamily,
                                        fontSize: style.fontSize,
                                        textColor: style.color?.value.toRadixString(16),
                                        rotation: widget.singleItemList[index].rotation,
                                        animation: widget.singleItemList[index].animation,
                                        effect: widget.singleItemList[index].effect,
                                        label: widget.singleItemList[index].label,
                                        theme: widget.singleItemList[index].theme,
                                        availability: widget.singleItemList[index].availability,
                                        backgroundImage: widget.singleItemList[index].backgroundImage,
                                        backgroundColor: widget.singleItemList[index].backgroundColor,
                                        fontOpacity: widget.singleItemList[index].fontOpacity,
                                        backgroundOpacity: widget.singleItemList[index].backgroundOpacity,
                                        isSelected: true,
                                        selectedAlignment: widget.singleItemList[index].selectedAlignment,
                                        comingFrom: widget.singleItemList[index].comingFrom,
                                        rect: Rect.fromLTWH(widget.singleItemList[index].rect!.left + 5.0, widget.singleItemList[index].rect!.top + 5.0, widget.singleItemList[index].width!,
                                            widget.singleItemList[index].height!),
                                      ),
                                    );

                                    // scaffoldKey.currentState?.showSnackBar(const SnackBar(content: Text(Strings.elementDuplicated)));
                                    widget.templatesController.initializeRotationList();

                                    widget.templatesController.onUpdateHistoryStack();
                                  });
                                  break;
                                case HandlePosition.none:
                                  break;
                                case HandlePosition.left:
                                  break;
                                case HandlePosition.top:
                                  break;
                                case HandlePosition.right:
                                  break;
                                case HandlePosition.bottom:
                                  break;
                                case HandlePosition.bottomLeft:
                                  break;
                                case HandlePosition.bottomRight:
                                  break;
                              }
                            },
                            onPanUpdate: (details) {
                              switch (handle) {
                                case HandlePosition.bottomLeft: // Rotate case
                                  final currentDragOffset = details.localPosition;
                                  final delta = currentDragOffset - widget.startDragOffset![index];
                                  final angle = delta.direction;
                                  setState(() {
                                    widget.singleItemList[index].rotation = angle.toString();
                                  });
                                  break;
                                case HandlePosition.bottomRight: // Expand/text increase decrease case
                                  setState(() {
                                    final mid = (details.delta.dx + (details.delta.dy * 1)) / 2;
                                    final newHeight = math.max(widget.singleItemList[index].height! + (2 * mid), 0.0);
                                    final newWidth = math.max(widget.singleItemList[index].width! + (2 * mid), 0.0);
                                    final updatedSize = Size(newWidth, newHeight);
                                    if (updatedSize > const Size(50, 50)) {
                                      widget.singleItemList[index].width = updatedSize.width;
                                      widget.singleItemList[index].height = updatedSize.height;
                                      widget.singleItemList[index].rect = Rect.fromLTWH(
                                          widget.singleItemList[index].rect!.left, widget.singleItemList[index].rect!.top, widget.singleItemList[index].width!, widget.singleItemList[index].height!);

                                      var overallScale = widget.singleItemList[index].height! * 0.01;
                                      widget.singleItemList[index].fontSize = 16.0 * overallScale;
                                      widget.singleItemList[index].availabilityStickerSize = (40 * overallScale).toInt();
                                      widget.callBack(widget.singleItemList);
                                    } else {
                                      widget.singleItemList[index].width = widget.singleItemList[index].width! + 1;
                                      widget.singleItemList[index].height = widget.singleItemList[index].height! + 1;
                                    }
                                  });
                                  break;
                                case HandlePosition.none:
                                  break;
                                case HandlePosition.left:
                                  break;
                                case HandlePosition.top:
                                  break;
                                case HandlePosition.right:
                                  break;
                                case HandlePosition.bottom:
                                  break;
                                case HandlePosition.topLeft:
                                  break;
                                case HandlePosition.topRight:
                                  break;
                              }
                            },
                            onPanEnd: (details) {
                              // widget.templatesController.onUpdateHistoryStack();    // TODO: Will do history update when drag
                            },
                            child: widget.singleItemList[index].isSelected == true
                                ? Container(
                                    decoration: const BoxDecoration(
                                      color: AppColor.appSkyBlue,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      iconData,
                                      color: AppColor.appIconBackgound,
                                      size: 12,
                                    ),
                                  )
                                : null,
                          );
                        },
                        sideHandleBuilder: (context, handle) {
                          if (handle == HandlePosition.left) {
                            iconData = Icons.arrow_left;
                          } else if (handle == HandlePosition.right) {
                            iconData = Icons.arrow_right;
                          } else if (handle == HandlePosition.top) {
                            iconData = Icons.drag_handle;
                          } else if (handle == HandlePosition.bottom) {
                            iconData = Icons.drag_handle;
                          }
                          return GestureDetector(
                            onTap: () {},
                            onPanUpdate: (details) {
                              switch (handle) {
                                case HandlePosition.right:
                                  setState(() {
                                    final mid = (details.delta.dx + (details.delta.dy * 1)) / 2;
                                    final newHeight = math.max(widget.singleItemList[index].height!, 0.0);
                                    final newWidth = math.max(widget.singleItemList[index].width! + (2 * mid), 0.0);
                                    final updatedSize = Size(newWidth, newHeight);

                                    if (updatedSize > const Size(50, 50)) {
                                      widget.singleItemList[index].width = updatedSize.width;
                                      widget.singleItemList[index].height = updatedSize.height;
                                      widget.singleItemList[index].rect = Rect.fromLTWH(
                                          widget.singleItemList[index].rect!.left, widget.singleItemList[index].rect!.top, widget.singleItemList[index].width!, widget.singleItemList[index].height!);

                                      /* var overallScale = widget.singleItemList[index].height! * 0.01;
                                      widget.singleItemList[index].fontSize = 16.0 * overallScale;
                                      widget.singleItemList[index].availabilityStickerSize = (40 * overallScale).toInt();*/
                                      widget.callBack(widget.singleItemList);
                                    }
                                  });
                                  break;
                                case HandlePosition.bottom:
                                  setState(() {
                                    final mid = (details.delta.dx + (details.delta.dy * 1)) / 2;
                                    final newHeight = math.max(widget.singleItemList[index].height! + (2 * mid), 0.0);
                                    final newWidth = math.max(widget.singleItemList[index].width!, 0.0);
                                    final updatedSize = Size(newWidth, newHeight);

                                    if (updatedSize > const Size(50, 50)) {
                                      widget.singleItemList[index].width = updatedSize.width;
                                      widget.singleItemList[index].height = updatedSize.height;
                                      widget.singleItemList[index].rect = Rect.fromLTWH(
                                          widget.singleItemList[index].rect!.left, widget.singleItemList[index].rect!.top, widget.singleItemList[index].width!, widget.singleItemList[index].height!);

                                      /*var overallScale = widget.singleItemList[index].height! * 0.01;
                                      widget.singleItemList[index].fontSize = 16.0 * overallScale;
                                      widget.singleItemList[index].availabilityStickerSize = (40 * overallScale).toInt();*/
                                      widget.callBack(widget.singleItemList);
                                    }
                                  });
                                  break;
                                case HandlePosition.top:
                                // Handle resizing towards top
                                  setState(() {
                                    // Calculate new height based on the delta value
                                    final newHeight = max(widget.singleItemList[index].height! - details.delta.dy, 0.0);
                                    if (newHeight > 50) {
                                      // Update height if it's greater than the minimum threshold
                                      final newTop = widget.singleItemList[index].rect!.top + (widget.singleItemList[index].height! - newHeight);
                                      widget.singleItemList[index].height = newHeight;
                                      widget.singleItemList[index].rect = Rect.fromLTWH(
                                        widget.singleItemList[index].rect!.left,
                                        newTop,
                                        widget.singleItemList[index].width!,
                                        widget.singleItemList[index].height!,
                                      );
                                      widget.callBack(widget.singleItemList);
                                    }
                                  });
                                  break;
                                case HandlePosition.left:
                                // Handle resizing towards left
                                  setState(() {
                                    // Calculate new width based on the delta value
                                    final newWidth = max(widget.singleItemList[index].width! - details.delta.dx, 0.0);
                                    if (newWidth > 50) {
                                      // Update width if it's greater than the minimum threshold
                                      final newLeft = widget.singleItemList[index].rect!.left + (widget.singleItemList[index].width! - newWidth);
                                      widget.singleItemList[index].width = newWidth;
                                      widget.singleItemList[index].rect = Rect.fromLTWH(
                                        newLeft,
                                        widget.singleItemList[index].rect!.top,
                                        widget.singleItemList[index].width!,
                                        widget.singleItemList[index].height!,
                                      );
                                      widget.callBack(widget.singleItemList);
                                    }
                                  });
                                  break;
                                default:
                                // Other cases can be handled similarly
                                  break;
                              }
                            },
                            child: widget.singleItemList[index].isSelected == true
                                ? Icon(
                                    iconData,
                                    color: AppColor.white,
                                    size: 20,
                                  )
                                : null,
                          );
                        },
                      ),
                    ))
                  : Center(
                      child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 100.w),
                      child: Text(
                        Strings.addAnElement,
                        style: CustomTextStyle.font16R,
                        textAlign: TextAlign.center,
                      ),
                    )),
            ),
          ),
        ),
      ),
    );
  }
}
