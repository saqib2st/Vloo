import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/configs/text.dart';
import 'package:vloo/app/data/utils/Responsive.dart';
import 'package:vloo/app/data/utils/singleton.dart';
import 'package:vloo/app/data/utils/static_assets.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/routes/app_pages.dart';
import '../../../data/widgets/custom_buttons.dart';
import '../controllers/splash_controller.dart';



class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.only(top:controller.storage.read(Strings.token) != null?50.h:0),
      alignment: Alignment.center,
        color: AppColor.primaryColor,
        child: GestureDetector(
          onTap: (){
            Get.offAllNamed(Routes.introduction);
          },
          child: Visibility(
              visible: controller.storage.read(Strings.token) != null,
              replacement: AnimatedBuilder(
                  animation: controller.slideAnimationPositionUpDownPadding,
                  builder: (context,child) {
                    return AnimatedPadding(
                      duration:const Duration(seconds: 0),
                      padding: EdgeInsets.only(
                        bottom: controller.isScaleUp.value?controller.scaleControllerPadding.value*400.h:0.0,
                        left: controller.isScaleUp.value?controller.scaleControllerPadding.value*110.w:0.0,
                        right: controller.isScaleUp.value?controller.scaleControllerPadding.value*110.w:0.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedBuilder(
                            animation: controller.slideAnimationPositionUpDown,
                            builder: (context,child){
                              return
                                Column(
                                  children: [
                                    Transform.translate(
                                      offset: Offset(0.0, controller.logoVisible.value==false ? -controller.scaleController.value*100.h:0.0),
                                      child: AnimatedOpacity(
                                        opacity:controller.isVisible.value? 1.0:0.0,
                                        duration:const Duration(milliseconds: 900),
                                        onEnd: (){
                                          controller.logoVisible.value =false;
                                        },
                                        child: SvgPicture.asset(
                                          StaticAssets.vlooLogo,
                                          width: 80.w,
                                          height: 80.h,
                                          placeholderBuilder: (BuildContext context) => Container(
                                              padding: const EdgeInsets.all(30.0),
                                              child: const CircularProgressIndicator()),
                                        ),
                                      ),
                                    ),
                                    Transform.translate(
                                      offset: Offset(0.0, controller.logoVisible.value==false  && controller.isScaleUp.value? -controller.scaleController.value*100.h:-68.h),
                                      child: AnimatedOpacity(
                                        opacity:!controller.logoVisible.value? 1.0:0.0,
                                        duration:const Duration(milliseconds: 600),
                                        onEnd: (){
                                          controller.openBottomSheetAfterDelay(
                                              Container(
                                                color: AppColor.primaryColor,
                                                width: double.infinity,
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Responsive(
                                                      mobile: SizedBox(
                                                        height: 184.h,
                                                        width: 249.w,
                                                        child: Image.asset('assets/images/splash_image.png'),
                                                      ),
                                                      tablet: SizedBox(
                                                        height: 220.h,
                                                        width: 400.w,
                                                        child: Image.asset('assets/images/splash_image.png',
                                                          height: 200.h,
                                                          width: 350.w,
                                                          fit: BoxFit.fitHeight,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 30.h,
                                                    ),
                                                    Text(
                                                      Strings.welcomeToVloo,
                                                      style: CustomTextStyle.font22R.copyWith(
                                                          color: AppColor.appLightBlue,
                                                          fontSize: 24.sp,
                                                          fontWeight: FontWeight.w600),
                                                    ),
                                                    Text(
                                                      Strings.createDisplayMenuBoards,
                                                      style: CustomTextStyle.font20R
                                                          .copyWith(color: AppColor.appLightBlue),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                    SizedBox(
                                                      height: 35.h,
                                                    ),
                                                    CustomButton(
                                                      buttonName: Strings.start,
                                                      height: 58.h,
                                                      width: 288.w,
                                                      textColor: AppColor.primaryColor,
                                                      isbold: true,
                                                      backgroundColor: AppColor.secondaryColor,
                                                      onPressed: controller.toSignup,
                                                    ),
                                                    SizedBox(
                                                      height: 20.h,
                                                    ),
                                                    CustomButton(
                                                      buttonName: Strings.alreadyHaveAccount,
                                                      height: 58.h,
                                                      width: 288.w,
                                                      color: AppColor.appLightBlue,
                                                      onPressed: controller.toLogin,
                                                    ),
                                                    SizedBox(
                                                      height: Get.height*0.2,
                                                    ),
                                                  ],
                                                ),
                                              )
                                          );
                                        },
                                        child: SvgPicture.asset(
                                          StaticAssets.icSlogan,
                                          width: 40.w,
                                          height: 40.h,
                                          placeholderBuilder: (BuildContext context) => Container(
                                              padding: const EdgeInsets.all(30.0),
                                              child: const CircularProgressIndicator()),),
                                      ),
                                    ),
                                  ],
                                );},
                          ),
                        ],
                      ),
                    );
                  }
              ),
              child:AnimatedBuilder(
                animation: controller.slideAnimationPositionUpDown,
                builder: (context,child){
                  return
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Transform.translate(
                          offset: Offset(0.0, controller.logoVisible.value==false ? -controller.scaleController.value*70:0.0),
                          child: AnimatedOpacity(
                            opacity:controller.isVisible.value? 1.0:0.0,
                            duration:const Duration(milliseconds: 900),
                            onEnd: (){
                              controller.logoVisible.value =false;
                            },
                            child: SvgPicture.asset(
                              StaticAssets.vlooLogo,
                              width: 80.w,
                              height: 80.h,
                              placeholderBuilder: (BuildContext context) => Container(
                                  padding: const EdgeInsets.all(30.0),
                                  child: const CircularProgressIndicator()),
                            ),
                          ),
                        ),
                        Transform.translate(
                          offset: Offset(0.0, controller.logoVisible.value==false ? -70.h:0.0),
                          child: AnimatedOpacity(
                            opacity:!controller.logoVisible.value? 1.0:0.0,
                            duration:const Duration(milliseconds: 900),
                            onEnd: ()async{
                               await Future.delayed(Duration(milliseconds: 100));
                                Singleton.token = controller.storage.read(Strings.token);
                                Singleton.currency?.value = controller.storage.read(Strings.currency) ?? "\$";
                                Get.offAllNamed(Routes.bottomNav);
                            },
                            child: SvgPicture.asset(
                              StaticAssets.icSlogan,
                              width: 40.w,
                              height: 40.h,
                              placeholderBuilder: (BuildContext context) => Container(
                                  padding: const EdgeInsets.all(30.0),
                                  child: const CircularProgressIndicator()),),
                          ),
                        ),
                      ],
                    );},
              ),
          ),
        )
    );
  }
}
