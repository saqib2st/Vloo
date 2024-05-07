import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/utils/static_assets.dart';
import 'package:vloo/app/modules/MyMedia/controllers/my_media_controller.dart';
import 'package:vloo/app/modules/MyMedia/views/my_media_view.dart';
import 'package:vloo/app/modules/myscreens/controllers/myscreens_controller.dart';
import 'package:vloo/app/modules/myscreens/views/myscreens_view.dart';
import 'package:vloo/app/modules/profile/controllers/profile_controller.dart';
import 'package:vloo/app/modules/profile/views/my_profile_view.dart';
import 'package:vloo/app/modules/templates/controllers/templates_controller.dart';
import 'package:vloo/app/modules/templates/views/my_projects_view.dart';
import 'package:vloo/app/modules/templates/views/templates_view.dart';

class BottomNavController extends GetxController {
  var currentIndex = 0.obs;
  Future<void> fetchData() async {
    await Future.delayed(const Duration(milliseconds: 10 )).then((value) =>Get.find<TemplatesController>().getPreDefinedTemplateList() );
    // or a small duration
  }


  void changeTab(int index) {
    if (index == 0) {
      currentIndex.value==index;
      Get.put<TemplatesController>(TemplatesController());
      if (Get.isRegistered<TemplatesController>()) {
        fetchData();
      }

    } else if (index == 1) {
      currentIndex.value==index;
      Get.find<TemplatesController>().getTemplateList();
    } else if (index == 2) {
        Get.put<MyscreensController>(MyscreensController());
    } else if (index == 3) {
      if (!Get.isRegistered<MyMediaController>()) {
        Get.put<MyMediaController>(MyMediaController());
      }
    } else if (index == 4) {
      if (!Get.isRegistered<ProfileController>()) {
        Get.put<ProfileController>(ProfileController());
      }
    }
    currentIndex.value = index;
  }

  List<Widget Function(bool isSelected)> icons = [
    (isSelected) => SvgPicture.asset(
          isSelected
              ? StaticAssets.selectedTemplatesIcon
              : StaticAssets.templatesIcon,
          width: Get.mediaQuery.orientation == Orientation.portrait ? 20.w : 40.w,
          height: Get.mediaQuery.orientation == Orientation.portrait ? 20.h : 40.h,
          placeholderBuilder: (BuildContext context) => Container(
              padding: const EdgeInsets.all(30.0),
              child: const CircularProgressIndicator()),
        ),
    (isSelected) => SvgPicture.asset(
          isSelected
              ? StaticAssets.selectedProjectsIcon
              : StaticAssets.projectsIcon,
          width: Get.mediaQuery.orientation == Orientation.portrait ? 20.w : 40.w,
          height: Get.mediaQuery.orientation == Orientation.portrait ? 20.h : 40.h,
        ),
    (isSelected) => SvgPicture.asset(
          isSelected
              ? StaticAssets.selectedScreensIcon
              : StaticAssets.screensIcon,
          width: Get.mediaQuery.orientation == Orientation.portrait ? 20.w : 40.w,
          height: Get.mediaQuery.orientation == Orientation.portrait ? 20.h : 40.h,
        ),
    (isSelected) => SvgPicture.asset(
          isSelected ? StaticAssets.selectedMediaIcon : StaticAssets.mediaIcon,
          width: Get.mediaQuery.orientation == Orientation.portrait ? 20.w : 40.w,
          height: Get.mediaQuery.orientation == Orientation.portrait ? 20.h : 40.h,
        ),
    (isSelected) => SvgPicture.asset(
          isSelected
              ? StaticAssets.selectedProfileIcon
              : StaticAssets.profileIcon,
          width: Get.mediaQuery.orientation == Orientation.portrait ? 20.w : 40.w,
          height: Get.mediaQuery.orientation == Orientation.portrait ? 20.h : 40.h,
          placeholderBuilder: (BuildContext context) => Container(
              padding: const EdgeInsets.all(30.0),
              child: const CircularProgressIndicator()),
        ),
  ];

  final List<Widget> screens = const [
    TemplatesView(),
    MyProjectView(),
    MyScreensView(),
    MyMediaView(),
    MyProfileView(),
  ];

  final List<String> titles = [
    'Templates',
    'My projects',
    'My screens',
    'Media',
    'Profile',
  ];

  List<Widget Function(bool isSelected)> getIconList() {
    return icons;
  }

  List<String> getTitleList() {
    return titles;
  }

  int getMenuCount() {
    return screens.length;
  }

  @override
  void onInit() {
    super.onInit();

    changeTab(Get.parameters['index'] != null
        ? int.parse(Get.parameters['index'] ?? "0")
        : 0);
    //  Get.put<TemplatesController>(TemplatesController());
  }
}
