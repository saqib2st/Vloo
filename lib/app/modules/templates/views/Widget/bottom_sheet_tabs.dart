import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/utils/static_assets.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/widgets/cutom_tabs_column.dart';
import 'package:vloo/app/modules/imageElement/controllers/image_element_controller.dart';
import 'package:vloo/app/modules/templates/controllers/templates_controller.dart';
import 'package:vloo/app/modules/textEditing/controllers/title_editing_controller.dart';
import 'package:vloo/custom_icons.dart';

class BottomSheetTabs extends GetView<TemplatesController> {
  final String? comingFrom;
  final int? index;
  final String? orientation;

  const BottomSheetTabs({super.key, this.comingFrom, this.index, this.orientation});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
            margin: const EdgeInsets.only(top: 20.0, right: 10.0),
            height: 120.h,
            width: Get.width,
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
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: tabsList(orientation ?? Strings.portrait, comingFrom ?? '', controller, index ?? 0, context))),
        Positioned(
            right: 40.0,
            child: GestureDetector(
                onTap: () {
                  if (comingFrom == Strings.title) {
                    controller.singleItemList[index!].tabsIndex = 0;
                    Navigator.pop(context);
                    Get.delete<TitleEditingController>();
                    controller.toTitleElementView(orientation ?? Strings.portrait, Strings.editElementTitle, index);
                  } else if (comingFrom == Strings.description) {
                    controller.singleItemList[index!].tabsIndex = 0;
                    Navigator.pop(context);
                    Get.delete<TitleEditingController>();
                    controller.toDescriptionElementView(orientation ?? Strings.portrait, Strings.editElementDescription, index);
                  } else if (comingFrom == Strings.price) {
                    controller.singleItemList[index!].tabsIndex = 0;
                    Navigator.pop(context);
                    Get.delete<TitleEditingController>();
                    controller.toPriceElementView(orientation ?? Strings.portrait, Strings.editElementPrice, index);
                  } else if (comingFrom == Strings.image) {
                    controller.singleItemList[index!].tabsIndex = 0;
                    Get.delete<ImageElementController>();
                    controller.toEditImageElementView(orientation ?? Strings.portrait, Strings.editElementImage, index ?? 0);
                  }
                },
                child: SvgPicture.asset(StaticAssets.topButton)))
      ],
    );
  }
}

List<Widget> tabsList(String orientation, String comingFrom, TemplatesController controller, int index, BuildContext context) {
  var tabsList;
  switch (comingFrom) {
    case Strings.price:
      return [
        GestureDetector(
            onTap: () {
              Navigator.pop(context);
              controller.singleItemList[index].tabsIndex = 0;
              Get.delete<TitleEditingController>();
              controller.toPriceElementView(orientation, Strings.editElementPrice, index);
            },
            child: CustomTabColumn(
                icon: SvgPicture.asset(StaticAssets.icPencilTabs, colorFilter: const ColorFilter.mode(AppColor.white, BlendMode.srcIn), width: 27.w, height: 22.h), text: Strings.edit)),
        GestureDetector(
            onTap: () {
              Navigator.pop(context);
              controller.singleItemList[index].tabsIndex = 1;
              Get.delete<TitleEditingController>();
              controller.toPriceElementView(orientation, Strings.editElementPrice, index);
            },
            child: CustomTabColumn(icon: Icon(FlutterCustomIcons.transitions_icon, color: AppColor.white, size: 22.h), text: Strings.transitions)),
        GestureDetector(
            onTap: () {
              Navigator.pop(context);
              controller.singleItemList[index].tabsIndex = 2;
              Get.delete<TitleEditingController>();
              controller.toPriceElementView(orientation, Strings.editElementPrice, index);
            },
            child: CustomTabColumn(icon: Icon(Icons.local_offer_outlined, color: AppColor.white, size: 22.h), text: Strings.themes)),
        GestureDetector(
            onTap: () {
              Navigator.pop(context);
              controller.singleItemList[index].tabsIndex = 3;
              Get.delete<TitleEditingController>();
              controller.toPriceElementView(orientation, Strings.editElementPrice, index);
            },
            child: CustomTabColumn(icon: Icon(Icons.water_drop_outlined, color: AppColor.white, size: 22.h), text: Strings.color)),
        GestureDetector(
            onTap: () {
              Navigator.pop(context);
              controller.singleItemList[index].tabsIndex = 4;
              Get.delete<TitleEditingController>();
              controller.toPriceElementView(orientation, Strings.editElementPrice, index);
            },
            child: CustomTabColumn(icon: Icon(Icons.tune_sharp, color: AppColor.white, size: 22.h), text: Strings.options))
      ];
    case Strings.title:
      return [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            controller.singleItemList[index].tabsIndex = 0;
            Get.delete<TitleEditingController>();
            controller.toTitleElementView(orientation, Strings.editElementTitle, index);
          },
          child: CustomTabColumn(
              icon: SvgPicture.asset(
                StaticAssets.icPencilTabs,
                colorFilter: const ColorFilter.mode(AppColor.white, BlendMode.srcIn),
                width: 20.w,
                height: 20.h,
              ),
              text: Strings.edit),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            controller.singleItemList[index].tabsIndex = 1;
            Get.delete<TitleEditingController>();
            controller.toTitleElementView(orientation, Strings.editElementTitle, index);
          },
          child: CustomTabColumn(
              icon: SvgPicture.asset(StaticAssets.icAnimationTabs, colorFilter: const ColorFilter.mode(AppColor.white, BlendMode.srcIn), width: 20.w, height: 20.h), text: Strings.animations),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            controller.singleItemList[index].tabsIndex = 2;
            Get.delete<TitleEditingController>();
            controller.toTitleElementView(orientation, Strings.editElementTitle, index);
          },
          child: CustomTabColumn(
              icon: SvgPicture.asset(
                StaticAssets.icFontTabs,
                colorFilter: const ColorFilter.mode(AppColor.white, BlendMode.srcIn),
                width: 20.w,
                height: 20.h,
              ),
              text: Strings.font),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            controller.singleItemList[index].tabsIndex = 3;
            Get.delete<TitleEditingController>();
            controller.toTitleElementView(orientation, Strings.editElementTitle, index);
          },
          child: CustomTabColumn(
              icon: SvgPicture.asset(
                StaticAssets.icColorTabs,
                colorFilter: const ColorFilter.mode(AppColor.white, BlendMode.srcIn),
                width: 20.w,
                height: 20.h,
              ),
              text: Strings.color),
        ),
      ];
    case Strings.description:
      return [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            controller.singleItemList[index].tabsIndex = 0;
            Get.delete<TitleEditingController>();
            controller.toDescriptionElementView(orientation, Strings.editElementDescription, index);
          },
          child: CustomTabColumn(
              icon: SvgPicture.asset(
                StaticAssets.icPencilTabs,
                colorFilter: const ColorFilter.mode(AppColor.white, BlendMode.srcIn),
                width: 20.w,
                height: 20.h,
              ),
              text: Strings.edit),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            controller.singleItemList[index].tabsIndex = 1;
            Get.delete<TitleEditingController>();
            controller.toDescriptionElementView(orientation, Strings.editElementDescription, index);
          },
          child: CustomTabColumn(
              icon: SvgPicture.asset(
                StaticAssets.icFontTabs,
                colorFilter: const ColorFilter.mode(AppColor.white, BlendMode.srcIn),
                width: 20.w,
                height: 20.h,
              ),
              text: Strings.font),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            controller.singleItemList[index].tabsIndex = 2;
            Get.delete<TitleEditingController>();
            controller.toDescriptionElementView(orientation, Strings.editElementDescription, index);
          },
          child: CustomTabColumn(
              icon: SvgPicture.asset(
                StaticAssets.icColorTabs,
                colorFilter: const ColorFilter.mode(AppColor.white, BlendMode.srcIn),
                width: 20.w,
                height: 20.h,
              ),
              text: Strings.color),
        ),
      ];
    case Strings.image:
      return [
        GestureDetector(
          onTap: () {
            controller.singleItemList[index].tabsIndex = 0;
            Get.delete<ImageElementController>();
            controller.toEditImageElementView(orientation, Strings.editElementImage, index);
          },
          child: CustomTabColumn(icon: Icon(FlutterCustomIcons.transitions_icon, color: AppColor.white, size: 22.h), text: Strings.transitions),
        ),
        GestureDetector(
          onTap: () {
            controller.singleItemList[index].tabsIndex = 1;
            Get.delete<ImageElementController>();
            controller.toEditImageElementView(orientation, Strings.editElementImage, index);
          },
          child: CustomTabColumn(
              icon: SvgPicture.asset(
                StaticAssets.moveIcon,
                colorFilter: const ColorFilter.mode(AppColor.white, BlendMode.srcIn),
                width: 20.w,
                height: 20.h,
              ),
              text: Strings.moves),
        ),
        GestureDetector(
          onTap: () {
            controller.singleItemList[index].tabsIndex = 2;
            Get.delete<ImageElementController>();
            controller.toImageElementView(orientation, Strings.editElementImage, index);
          },
          child: CustomTabColumn(
              icon: SvgPicture.asset(
                StaticAssets.replaceBgIcon,
                colorFilter: const ColorFilter.mode(AppColor.white, BlendMode.srcIn),
                width: 20.w,
                height: 20.h,
              ),
              text: Strings.replace),
        ),
        GestureDetector(
          onTap: () {
            controller.singleItemList[index].tabsIndex = 3;
            Get.delete<ImageElementController>();
            controller.toEditImageElementView(orientation, Strings.editElementImage, index);
          },
          child: CustomTabColumn(
              icon: SvgPicture.asset(
                StaticAssets.cubeIcon,
                colorFilter: const ColorFilter.mode(AppColor.white, BlendMode.srcIn),
                width: 20.w,
                height: 20.h,
              ),
              text: Strings.availability),
        ),
      ];
  }
  return tabsList;
}
