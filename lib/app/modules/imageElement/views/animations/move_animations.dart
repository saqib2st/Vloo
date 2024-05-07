import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/configs/text.dart';
import 'package:vloo/app/data/utils/static_assets.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/modules/imageElement/controllers/image_element_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/configs/text.dart';
import 'package:vloo/app/data/utils/static_assets.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/modules/imageElement/controllers/image_element_controller.dart';
import 'package:vloo/app/modules/textEditing/controllers/title_editing_controller.dart';

class MoveAnimation extends GetView<ImageElementController> {
  const MoveAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Builder(builder: (context) {
        return Column(
          children: [
            Wrap(
              spacing: 9,
              runSpacing: 11,
              children: controller.movesItemList
                  .asMap()
                  .entries
                  .map(
                    (e) => e.value.text == 'None'
                        ? GestureDetector(
                            onTap: () {
                              controller.imageMove.value =
                                  ImageTransitionsAndMoves.none;
                              Get.forceAppUpdate();
                            },
                            child: Container(
                              height: 70,
                              width: 180.w,
                              decoration: BoxDecoration(
                                color: AppColor.appIconBackgound,
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                  width: 3,
                                  color: controller
                                              .imageMove.value ==
                                          e.value.imageTransitionsAndMoves
                                      ? AppColor.appSkyBlue
                                      : AppColor.appIconBackgound,
                                ),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      e.value.imagePath ?? '',
                                    ),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    Text(
                                      e.value.text ?? '---',
                                      style: CustomTextStyle.font14R,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              controller. imageMove.value =
                                  e.value.imageTransitionsAndMoves ??
                                      ImageTransitionsAndMoves.none;
                              Get.forceAppUpdate();
                            },
                            child: Container(
                              padding: EdgeInsets.fromLTRB(35.w,1.h,35.w,6.h),
                              width: 180.w,
                              decoration: BoxDecoration(
                                color: AppColor.appIconBackgound,
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                  width: 3,
                                  color: controller
                                              .imageMove.value ==
                                          e.value.imageTransitionsAndMoves
                                      ? AppColor.appSkyBlue
                                      : AppColor.appIconBackgound,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    e.value.imagePath ?? '',
                                    height: 40,
                                    width: 60,
                                    fit: BoxFit.cover,
                                  ),
                                  Text(
                                    e.value.text ?? '---',
                                    style: CustomTextStyle.font14R,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                  )
                  .toList(),
            ),
            //),
          ],
        );
      }),
    );
  }
}


// class MoveAnimation extends GetView<ImageElementController> {
//   const MoveAnimation({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Builder(builder: (context) {
//         return Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SizedBox(
//               height: 20.h,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     controller.selectedTransition.value = TransitionType.none;
//                   },
//                   child: Container(
//                     height: 100.h,
//                     width: 180.w,
//                     decoration: BoxDecoration(
//                       color: AppColor.appIconBackgound,
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                     child: Center(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           SvgPicture.asset(
//                             StaticAssets.noneIcon,
//                           ),
//                           const SizedBox(
//                             width: 7,
//                           ),
//                           Text(
//                             Strings.none,
//                             style: CustomTextStyle.font14R,
//                             textAlign: TextAlign.center,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   width: 10.w,
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     controller.isAnimationActivate.toggle();
//                     controller.selectedTransition.value = TransitionType.scale;
//                     controller.selectedAnimation.value =
//                         AnimationDirection.pulse;
//                     controller.isAnimationActivate.value
//                         ? controller.startAnimations()
//                         : controller.endAnimation();
//                   },
//                   child: Container(
//                     height: 100.h,
//                     width: 180.w,
//                     decoration: BoxDecoration(
//                       color: AppColor.appIconBackgound,
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Image.asset(
//                               'assets/images/pulse.gif',
//                               height: 40,
//                               width: 60,
//                               fit: BoxFit.cover,
//                             )),
//                         Text(
//                           Strings.pulse,
//                           style: CustomTextStyle.font14R,
//                           textAlign: TextAlign.center,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     controller.isAnimationActivate.toggle();
//                     controller.selectedTransition.value = TransitionType.slide;
//                     controller.selectedAnimation.value =
//                         AnimationDirection.positionH;
//                     controller.isAnimationActivate.value
//                         ? controller.startAnimations()
//                         : controller.endAnimation();
//                   },
//                   child: Container(
//                     height: 100.h,
//                     width: 180.w,
//                     decoration: BoxDecoration(
//                       color: AppColor.appIconBackgound,
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Image.asset(
//                               'assets/images/position_left_right.gif',
//                               height: 40,
//                               width: 60,
//                               fit: BoxFit.cover,
//                             )),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               Strings.position,
//                               style: CustomTextStyle.font14R,
//                               textAlign: TextAlign.center,
//                             ),
//                             SvgPicture.asset(
//                               StaticAssets.horizontalMoveIcon,
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   width: 10.w,
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     controller.isAnimationActivate.toggle();
//                     controller.selectedTransition.value = TransitionType.slide;
//                     controller.selectedAnimation.value =
//                         AnimationDirection.positionV;
//                     controller.isAnimationActivate.value
//                         ? controller.startAnimations()
//                         : controller.endAnimation();
//                   },
//                   child: Container(
//                     height: 100.h,
//                     width: 180.w,
//                     decoration: BoxDecoration(
//                       color: AppColor.appIconBackgound,
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Image.asset(
//                               'assets/images/position_up_down.gif',
//                               height: 40,
//                               width: 60,
//                               fit: BoxFit.cover,
//                             )),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               Strings.position,
//                               style: CustomTextStyle.font14R,
//                               textAlign: TextAlign.center,
//                             ),
//                             SvgPicture.asset(
//                               StaticAssets.verticalMoveIcon,
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     controller.isAnimationActivate.toggle();
//                     controller.selectedTransition.value =
//                         TransitionType.rotaion;
//                     controller.selectedAnimation.value =
//                         AnimationDirection.wiggle;
//                     controller.isAnimationActivate.value
//                         ? controller.startAnimations()
//                         : controller.endAnimation();
//                   },
//                   child: Container(
//                     height: 100.h,
//                     width: 180.w,
//                     decoration: BoxDecoration(
//                       color: AppColor.appIconBackgound,
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Image.asset(
//                               'assets/images/wiggle.gif',
//                               height: 40,
//                               width: 60,
//                               fit: BoxFit.cover,
//                             )),
//                         Text(
//                           Strings.wiggle,
//                           style: CustomTextStyle.font14R,
//                           textAlign: TextAlign.center,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   width: 10.w,
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     controller.isAnimationActivate.toggle();
//                     controller.selectedTransition.value =
//                         TransitionType.rotaion;
//                     controller.selectedAnimation.value =
//                         AnimationDirection.shaking;
//                     controller.isAnimationActivate.value
//                         ? controller.startAnimations()
//                         : controller.endAnimation();
//                   },
//                   child: Container(
//                     height: 100.h,
//                     width: 180.w,
//                     decoration: BoxDecoration(
//                       color: AppColor.appIconBackgound,
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Image.asset(
//                               'assets/images/shaking.gif',
//                               height: 40,
//                               width: 60,
//                               fit: BoxFit.cover,
//                             )),
//                         Text(
//                           Strings.shaking,
//                           style: CustomTextStyle.font14R,
//                           textAlign: TextAlign.center,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             // const SizedBox(
//             //   height: 30,
//             // ),
//             // GestureDetector(
//             //   onTap: () {
//             //     Get.back();
//             //   },
//             //   child: const Text(
//             //     Strings.cancel,
//             //     style: TextStyle(
//             //       fontSize: 16,
//             //       fontWeight: FontWeight.bold,
//             //       decoration: TextDecoration.none,
//             //       color: Colors.white,
//             //     ),
//             //   ),
//             // ),
//           ],
//         );
//       }),
//     );
//   }
// }
