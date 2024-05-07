import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/configs/text.dart';
import 'package:vloo/app/data/utils/static_assets.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/widgets/custom_buttons.dart';
import 'package:vloo/app/data/widgets/primary_appbar.dart';
import 'package:vloo/app/modules/subscriptions/controllers/subscriptions_controller.dart';

class PaymentSubscriptionScreenView extends GetView<SubscriptionsController> {
  const PaymentSubscriptionScreenView({super.key});

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
        margin: const EdgeInsets.only(top: 50),
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(Strings.youHaveSelectedThePlan, style: CustomTextStyle.font20R.copyWith(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
              Text('${controller.count} ${Strings.screens}', style: CustomTextStyle.font20R.copyWith(fontWeight: FontWeight.bold, color: AppColor.secondaryColor), textAlign: TextAlign.center),
              SizedBox(
                height: 20.h,
              ),
              Image.asset(
                StaticAssets.imgDongle,
                width: 90,
                height: 90,
              ),
              SizedBox(
                height: 30.h,
              ),
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: AppColor.appLightBlue),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(child: Text(Strings.subscriptionCaps, style: CustomTextStyle.font20R.copyWith(fontWeight: FontWeight.w700))),
                              Text(
                                  '${controller.getUpdatedPrice()}€',
                                style: CustomTextStyle.font20R.copyWith(fontWeight: FontWeight.w700, color: AppColor.secondaryColor),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(child: Text(Strings.oneMonth, style: CustomTextStyle.font16R)),
                              Text(
                                '${'${controller.getUpdatedPrice()}€' ?? '20€'}/month' ,
                                style: CustomTextStyle.font16R,
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Text(
                            Strings.planWithoutRenewableCommitmentAutomatically,
                            style: CustomTextStyle.font14R,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40.h,
              ),
              CustomButton(
                buttonName: Strings.chooseThisPlan,
                borderColor: Colors.transparent,
                backgroundColor: AppColor.appSkyBlue,
                width: 250.w,
                height: 60.h,
                isbold: true,
                onPressed: () {

                  controller.planID = 3;         // TODO: Change to dynamic afterwards Now For classic plan

                  controller.orderScreenPlan();
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                  Strings.recurringPaymentSubscriptionMessage,
                  textAlign: TextAlign.start,
                  style: CustomTextStyle.font20R.copyWith(fontSize: 11)),
            ],
          ),
        ),
      ),
    );
  }
}
