import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/configs/text.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/utils/utils.dart';
import 'package:vloo/app/modules/imageElement/controllers/image_element_controller.dart';
import 'package:vloo/app/modules/templates/controllers/templates_controller.dart';

class BgVlooLibrary extends GetView<TemplatesController> {
  const BgVlooLibrary({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => (controller.imageFolderCategoryList.value?.isEmpty ==
              true) // List empty
          ? Container(
              color: AppColor.appIconBackgound,
            )
          : (controller.imageFolderCategoryList.value?.length == 1)
              ? GridView(
                  controller: controller.scrollController,
                  shrinkWrap: true,
                  padding: const EdgeInsets.fromLTRB(20, 20, 10, 20),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.2,
                  ),
                  children: <Widget>[
                    ...List.generate(
                        controller.vlooLibraryPhotosList.value?.length ?? 1,
                        (index) {
                      return GestureDetector(
                          onTap: () async {
                            if (controller.vlooLibraryPhotosList.value !=
                                null) {
                              String? selectedImagePath = controller
                                  .vlooLibraryPhotosList
                                  .value![index]
                                  .mediaFile;

                              // String? selectedImagePath = await controller.downloadImage(controller.vlooLibraryPhotosList.value![index].mediaFile, controller.vlooLibraryPhotosList.value![index].id as int?);
                              if (selectedImagePath != null) {
                                controller.backgroundImage.value =
                                    selectedImagePath;
                                Get.back();
                              }
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Utils.getNetworkImage(
                                controller.vlooLibraryPhotosList.value?[index]
                                        .mediaFile ??
                                    "",
                                BoxFit.cover,
                                250.w,
                                100.h),
                          ));
                    })
                  ],
                )
              : DefaultTabController(
                  length: controller.imageFolderCategoryList.value?.length ?? 1,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 50.w, vertical: 30.h),
                        child: TextField(
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                            hintText: Strings.search,
                            hintStyle: const TextStyle(color: Colors.white),
                            filled: true,
                            fillColor: AppColor.primaryColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: AppColor.appLightBlue,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: AppColor.appLightBlue,
                              ),
                            ),
                          ),
                          onChanged: (value) {
                            controller.searchString =
                                value.isNotEmpty ? value : "";
                          },
                          onSubmitted: (value) {
                            controller.getVlooLibraryImages(
                                ImageCategoryType.BACKGROUND.name,
                                "",
                                controller.searchString,
                                controller.currentPageIndex);
                          },
                        ),
                      ),
                      SizedBox(height: 8.h),
                      TabBar(
                        dividerColor: AppColor.transparent,
                        isScrollable: true,
                        controller: controller.libraryBackgroundTabController,
                        tabs: List.generate(
                            controller.imageFolderCategoryList.value?.length ??
                                1,
                            (index) => Tab(
                                text: controller.imageFolderCategoryList
                                        .value?[index].title ??
                                    Strings.background)),
                        indicatorColor: AppColor.appSkyBlue,
                        unselectedLabelColor: AppColor.unselectedTab,
                        labelColor: AppColor.appSkyBlue,
                        labelStyle: CustomTextStyle.font12R,
                      ),
                      SizedBox(height: 8.h),
                      Flexible(
                        child: TabBarView(
                          physics: const NeverScrollableScrollPhysics(),
                          children: List.generate(
                            controller.imageFolderCategoryList.value?.length ??
                                1,
                            (index) => GridView(
                              controller: controller.scrollController,
                              shrinkWrap: true,
                              padding:
                                  const EdgeInsets.fromLTRB(20, 20, 10, 20),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1.2,
                              ),
                              children: <Widget>[
                                ...List.generate(
                                    controller.vlooLibraryPhotosList.value
                                            ?.length ??
                                        1, (innerIndex) {
                                  return GestureDetector(
                                      onTap: () async {
                                        if (controller
                                                .vlooLibraryPhotosList.value !=
                                            null) {
                                          String? selectedImagePath = controller
                                              .vlooLibraryPhotosList
                                              .value![innerIndex]
                                              .mediaFile;
                                          //String? selectedImagePath = await controller.downloadImage(controller.vlooLibraryPhotosList.value![innerIndex].mediaFile, controller.vlooLibraryPhotosList.value![innerIndex].id as int?);
                                          if (selectedImagePath != null) {
                                            controller.backgroundImage.value =
                                                selectedImagePath;
                                            Get.back();
                                          }
                                        }
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                            decoration: BoxDecoration(
                                                color:
                                                    AppColor.appIconBackgound,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.0)),
                                            child: Utils.getNetworkImage(
                                                controller
                                                        .vlooLibraryPhotosList
                                                        .value?[innerIndex]
                                                        .mediaFile ??
                                                    "",
                                                BoxFit.contain,
                                                250.w,
                                                250.w)),
                                      ));
                                })
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
