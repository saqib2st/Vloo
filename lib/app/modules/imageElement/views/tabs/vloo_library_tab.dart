import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/configs/text.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/utils/utils.dart';
import 'package:vloo/app/data/widgets/loading_widget.dart';
import 'package:vloo/app/modules/imageElement/controllers/image_element_controller.dart';
import 'package:vloo/app/modules/imageElement/views/add_image_transition_screen.dart';
import 'package:vloo/app/modules/imageElement/views/image_screen.dart';

class VlooLibrary extends GetView<ImageElementController> {
  String comingFrom;

  VlooLibrary({super.key, required this.comingFrom});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => (controller.imageFolderCategoryList.value?.isEmpty == true)
          ? Container(
              color: AppColor.appIconBackgound,
            )
          : (controller.imageFolderCategoryList.value?.length == 1)
              ? GridView(
                  controller: controller.scrollController,
                  shrinkWrap: true,
                  padding: EdgeInsets.fromLTRB(20.w, 20.h, 10.w, 20.h),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.2,
                  ),
                  children: <Widget>[
                    ...List.generate(controller.vlooLibraryPhotosList.value?.length ?? 1, (index) {
                      return GestureDetector(
                          onTap: () async {
                            if (controller.vlooLibraryPhotosList.value != null) {
                              String? selectedImagePath = controller.vlooLibraryPhotosList.value![index].mediaFile;
                              // String? selectedImagePath =
                              //     await controller.downloadImage(
                              //         controller.vlooLibraryPhotosList
                              //             .value![index].mediaFile,
                              //         controller.vlooLibraryPhotosList
                              //             .value![index].id as int?);
                              if(comingFrom == 'add'){
                                if (selectedImagePath != null) {
                                  controller.imageUrl.value = selectedImagePath;
                                  Get.to(() => const AddImageTransitionScreen());
                                  print('sasasasasa  $comingFrom');
                                }
                              } else{
                                if (selectedImagePath != null) {
                                  controller.imageUrl.value = selectedImagePath;
                                  controller.onGoingBackFromImage();
                                }
                              }
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Utils.getNetworkImage(controller.vlooLibraryPhotosList.value?[index].mediaFile ?? "", BoxFit.contain, 250.w, 100.h),
                          ));
                    })
                  ],
                )
              : DefaultTabController(
                  length: controller.imageFolderCategoryList.value?.length ?? 1,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 20.h),
                        child: SizedBox(
                          height: 55.h,
                          child: TextField(
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Colors.white,
                              ),
                              hintText: Strings.search,
                              hintStyle: const TextStyle(color: Colors.white),
                              filled: true,
                              fillColor: AppColor.primaryDarkColor,
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
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: AppColor.appSkyBlue, width: 1.0),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onChanged: (value) {
                              controller.searchString = value.isNotEmpty ? value : "";
                            },
                            onSubmitted: (value) {
                              controller.getVlooLibraryImages(ImageCategoryType.IMAGE.name, "", controller.searchString, controller.currentPageIndex);
                            },
                          ),
                        ),
                      ),
                      TabBar(
                        isScrollable: true,
                        controller: controller.libraryImagesTabController,
                        tabs: List.generate(
                            controller.imageFolderCategoryList.value?.length ?? 1, (index) => Tab(height: 28.h, text: controller.imageFolderCategoryList.value?[index].title ?? Strings.image)),
                        indicatorColor: AppColor.appSkyBlue,
                        unselectedLabelColor: AppColor.unselectedTab,
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelStyle: CustomTextStyle.font14R,
                        unselectedLabelStyle: CustomTextStyle.font14R,
                        labelColor: AppColor.appSkyBlue,
                        dividerColor: AppColor.transparent,
                        indicatorWeight: 1,
                      ),
                      SizedBox(height: 8.h),
                      Flexible(
                        child: TabBarView(
                          physics: const NeverScrollableScrollPhysics(),
                          children: List.generate(
                            controller.imageFolderCategoryList.value?.length ?? 1,
                            (index) => GridView(
                              controller: controller.scrollController,
                              shrinkWrap: true,
                              padding: const EdgeInsets.fromLTRB(20, 20, 10, 20),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1.2,
                              ),
                              children: <Widget>[
                                ...List.generate(controller.vlooLibraryPhotosList.value?.length ?? 0, (innerIndex) {
                                  return GestureDetector(
                                      onTap: () async {
                                        if (controller.vlooLibraryPhotosList.value != null) {
                                          String? selectedImagePath = controller.vlooLibraryPhotosList.value![innerIndex].mediaFile;
                                          // String? selectedImagePath =
                                          //     await controller.downloadImage(
                                          //         controller
                                          //             .vlooLibraryPhotosList
                                          //             .value![
                                          //                 innerIndex]
                                          //             .mediaFile,
                                          //         controller
                                          //             .vlooLibraryPhotosList
                                          //             .value![
                                          //                 innerIndex]
                                          //             .id as int?);

                                         if(comingFrom == 'add'){
                                           if (selectedImagePath != null) {
                                             controller.imageUrl.value = selectedImagePath;
                                             Get.to(() => const AddImageTransitionScreen());
                                             print('sasasasasa  $comingFrom');
                                           }
                                         } else{
                                           if (selectedImagePath != null) {
                                             controller.imageUrl.value = selectedImagePath;
                                             controller.onGoingBackFromImage();

                                           }
                                         }
                                        }
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0.h),
                                        child: Container(
                                            decoration: BoxDecoration(color: AppColor.appIconBackgound, borderRadius: BorderRadius.circular(10.0)),
                                            child: Utils.getNetworkImage(controller.vlooLibraryPhotosList.value?[innerIndex].mediaFile ?? "", BoxFit.contain, 250.w, 250.w)),
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
