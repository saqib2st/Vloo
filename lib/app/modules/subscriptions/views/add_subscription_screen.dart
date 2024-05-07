import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/configs/text.dart';
import 'package:vloo/app/data/utils/static_assets.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/widgets/custom_buttons.dart';
import 'package:vloo/app/data/widgets/primary_appbar.dart';
import 'package:vloo/app/modules/addScreen/views/payment_success_add_screen.dart';
import 'package:vloo/app/modules/subscriptions/controllers/subscriptions_controller.dart';
import 'package:vloo/app/modules/subscriptions/views/payment_subscription_screen.dart';
import 'package:vloo/app/modules/subscriptions/views/payment_success_subscription_screen.dart';

class AddSubscriptionScreenView extends GetView<SubscriptionsController> {
  const AddSubscriptionScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: PrimaryAppbar(
          title: Strings.screenPlan,
          onPressed: () {
            Get.back();
          }),
      body: Container(
        margin: const EdgeInsets.only(top: 75),
        padding: EdgeInsets.symmetric(horizontal: 50.w),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(Strings.subscriptionPlanHeading, style: CustomTextStyle.font20R.copyWith(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
              Text(' 3 screens', style: CustomTextStyle.font20R.copyWith(fontWeight: FontWeight.bold, color: AppColor.secondaryColor), textAlign: TextAlign.center),
              SizedBox(
                height: 50.h,
              ),
              Image.asset(StaticAssets.imgDongle),
              SizedBox(
                height: 30.h,
              ),
              Text(Strings.subscriptionPlanHeading2, style: CustomTextStyle.font20R.copyWith(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () {
                        controller.count.value <= 0 ? controller.count.value = 0 : controller.decrement();
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Icon(
                          Icons.do_not_disturb_on_outlined,
                          size: 25,
                          color: AppColor.appLightBlue,
                        ),
                      )),
                  Text(
                    controller.count.value.toString(),
                    style: CustomTextStyle.font35M.copyWith(fontSize: 50.sp, fontWeight: FontWeight.bold, color: AppColor.appSkyBlue),
                  ),
                  GestureDetector(
                      onTap: () {
                        if (controller.count < 10) controller.increment();
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Icon(
                          Icons.add_circle_outline,
                          size: 25,
                          color: AppColor.appLightBlue,
                        ),
                      )),
                ],
              ),
              Expanded(
                child: (controller.count >= 3)
                    ? (controller.count >= 10)
                        ? Text(Strings.subscriptionPlanDescription2,
                            style: CustomTextStyle.font16R.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColor.appLightBlue,
                            ),
                            textAlign: TextAlign.center)
                        : SizedBox(
                            height: 80.h,
                          )
                    : Text(Strings.subscriptionPlanDescription,
                        style: CustomTextStyle.font16R.copyWith(
                          fontWeight: FontWeight.w400,
                          color: AppColor.red,
                        ),
                        textAlign: TextAlign.center),
              ),
              CustomButton(
                buttonName: (controller.count < 10) ? Strings.confirmMyChoice : Strings.contactUs,
                borderColor: Colors.transparent,
                backgroundColor: AppColor.appSkyBlue,
                width: 250.w,
                height: 60.h,
                isbold: true,
                onPressed: () async {

                  if (controller.count < 10) {
                    Get.to(const PaymentSubscriptionScreenView());

                  } else {
                    var url = '';
                    if (!await launchUrl(Uri.parse(url ?? ""))) {
                      throw Exception('Could not launch $url');
                    }
                  }
                },
              ),
              SizedBox(
                height: 80.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
