import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/configs/text.dart';
import 'package:vloo/app/data/utils/static_assets.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/widgets/custom_buttons.dart';
import 'package:vloo/app/data/widgets/primary_appbar.dart';
import 'package:vloo/app/modules/addScreen/controllers/add_screen_controller.dart';
import 'package:vloo/main.dart';

import 'payment_success_add_screen.dart';

class DetailOfOrder extends GetView<AddScreenController> {
  const DetailOfOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: PrimaryAppbar(
          title: Strings.detailOfTheOrder,
          onPressed: () {
            Get.back();
          }),
      body: SingleChildScrollView(
        child: Obx(() => Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.only(top: 15.h),
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding:  EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
                width: 330.w,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColor.appLightBlue)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding:  EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                      width: 80.w,
                      height: 80.h,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: AppColor.appIconBackgound),
                      child: Image.asset(
                        StaticAssets.imgDongle,
                        width: 30.w,
                        height: 30.h,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(Strings.vlooDongleTV, style: CustomTextStyle.font16R.copyWith(fontWeight: FontWeight.bold)),
                        Text(controller.donglePlanResult?.plan?.description ?? Strings.oneMonthSubscriptionRenewable, textAlign: TextAlign.start, style: CustomTextStyle.font12R.copyWith(color: AppColor.grey)),
                      ],
                    ),
                    Text(
                      '${controller.donglePlanResult?.plan?.fee}${controller.donglePlanResult?.plan?.currency}' ?? Strings.amount,
                      style: CustomTextStyle.font16R.copyWith(fontWeight: FontWeight.bold, color: AppColor.appSkyBlue),
                    )
                  ],
                ),
              ),
              Visibility(
                visible: true,
                child: Obx(
                  () => Container(
                    margin:  EdgeInsets.only(top: 20.h ),
                    padding:  EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
                    width: 330.w,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColor.appLightBlue)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding:  EdgeInsets.all(15.w),
                          width: 80.w,
                          height: 80.h,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: AppColor.appIconBackgound),
                          child: Image.asset(
                            StaticAssets.imgVlooDongle,
                            width: 30.w,
                            height: 30.h,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(Strings.vlooDongleTV, textAlign: TextAlign.start, style: CustomTextStyle.font16R.copyWith(fontWeight: FontWeight.bold)),
                            Text(Strings.singlePayment, textAlign: TextAlign.start, style: CustomTextStyle.font12R.copyWith(color: AppColor.grey)),
                            Row(
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      controller.count.value == 0 ? controller.count.value = 0 : controller.decrement();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                      child: SvgPicture.asset(StaticAssets.ic_minus),
                                    )),
                                Text(
                                  controller.count.value.toString(),
                                  style: CustomTextStyle.font16R.copyWith(fontWeight: FontWeight.bold, color: AppColor.appSkyBlue),
                                ),
                                GestureDetector(
                                    onTap: () {
                                      controller.increment();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                      child: SvgPicture.asset(StaticAssets.ic_positive),
                                    )),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          '${controller.calculateDonglePrice()} ${controller.donglePlanResult?.plan?.currency}' ?? Strings.amount,
                          style: CustomTextStyle.font16R.copyWith(fontWeight: FontWeight.bold, color: AppColor.appSkyBlue),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: true,
                child: Container(
                  margin:  EdgeInsets.only(top: 20.h ),
                  padding:  EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
                  width: 330.w,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColor.appLightBlue)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(Strings.delivery, style: CustomTextStyle.font16R.copyWith(fontWeight: FontWeight.bold)),
                          Text('${Strings.deliveryIn} ${controller.donglePlanResult?.deliveryTime}', textAlign: TextAlign.center, style: CustomTextStyle.font12R.copyWith(color: AppColor.grey)),
                          SizedBox(height: 10.h),
                          SizedBox(width: 150.w, child: Text(controller.fetchAddressString(), textAlign: TextAlign.start, style: CustomTextStyle.font12R.copyWith(color: AppColor.appLightBlue))),
                        ],
                      ),
                      Text(
                        '${controller.donglePlanResult?.deliveryFee}${controller.donglePlanResult?.plan?.currency}' ?? Strings.free,
                        style: CustomTextStyle.font16R.copyWith(fontWeight: FontWeight.bold, color: AppColor.appSkyBlue),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
                child: Text(Strings.fromTheTakingOfTheOrder, style: CustomTextStyle.font12R.copyWith(color: AppColor.grey),),
              ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 30.w),
                child: Divider(
                  thickness: 1.h,
                  color: AppColor.appSkyBlue,
                ),
              ),
              SizedBox(height: 15.h),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 12.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(Strings.totalToPay, style: CustomTextStyle.font16R.copyWith(fontWeight: FontWeight.bold, color: AppColor.appSkyBlue)),
                        Text('${Strings.including} ${controller.donglePlanResult?.vat}${controller.donglePlanResult?.plan?.currency} VAT ', textAlign: TextAlign.center, style: CustomTextStyle.font12R.copyWith(color: AppColor.grey)),
                      ],
                    ),
                    Text(
                      '${controller.calculateTotalPrice()}${controller.donglePlanResult?.plan?.currency}',
                      style: CustomTextStyle.font16R.copyWith(fontWeight: FontWeight.bold, color: AppColor.appSkyBlue),
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  Theme(
                    data: ThemeData(
                      unselectedWidgetColor: AppColor.appLightBlue,
                    ),
                    child: Transform.scale(
                      scale: 1.0.sp,
                      child: Checkbox(
                        value: controller.isChecked.value,
                        onChanged: (bool? value) {
                          controller.isChecked.value = value ?? false;
                        },
                        activeColor: AppColor.appLightBlue,
                        checkColor: Colors.black,
                      ),
                    ),
                  ),

                  Text(
                    Strings.termsOfSales,
                    style: CustomTextStyle.font14R.copyWith(
                      color: AppColor.appLightBlue,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.h),
              CustomButton(
                buttonName: Strings.order,
                backgroundColor:controller.isChecked.value? AppColor.appSkyBlue : AppColor.disableColor,
                borderColor: Colors.transparent,
                width: 260.w,
                height: 60.h,
                isbold: true,
                textSize: 12.sp,
                onPressed: () {
                  controller.isChecked.value?
                  controller.deliveryAddressAPI():
                  scaffoldKey.currentState?.showSnackBar(const SnackBar(content: Text(Strings.selectTermsOfSales)));
                },
              ),

            ],
          ),
        )),
      ),
    ).paddingOnly(bottom: 20.h);
  }
}
