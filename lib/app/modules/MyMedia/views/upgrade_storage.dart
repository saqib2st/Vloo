import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/configs/text.dart';
import 'package:vloo/app/data/utils/static_assets.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/utils/utils.dart';
import 'package:vloo/app/data/widgets/custom_buttons.dart';
import 'package:vloo/app/data/widgets/primary_appbar.dart';
import 'package:vloo/app/modules/MyMedia/controllers/my_media_controller.dart';
import 'package:vloo/app/modules/stripeIntegrations/controllers/stripe_integrations_controller.dart';
import 'package:vloo/main.dart';

class UpgradeStorageView extends GetView<MyMediaController> {
  const UpgradeStorageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: PrimaryAppbar(
          title: Strings.upgradeStorage,
          onPressed: () {
            Get.back();
          }),
      body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(StaticAssets.icServer, width: 100.w, height: 100.h),
                Text(Strings.selectPlan, style: CustomTextStyle.font16R.copyWith(fontWeight: FontWeight.bold)),
                SizedBox(height: 10.h),
                Text(
                  Strings.planWithoutRenewable,
                  style: CustomTextStyle.font14R,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30.h),
                Obx(
                  () => SizedBox(
                    height: 170.h,
                    child: controller.storagePlanList.value.isEmpty
                        ? SizedBox(
                            height: 280.h,
                            child: Center(
                              child: Text(
                                Strings.noStoragePlanFound,
                                style: CustomTextStyle.font20R.copyWith(
                                  color: AppColor.red,
                                ),
                              ),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.storagePlanList.length,
                            itemBuilder: (BuildContext context, int index) => GestureDetector(
                              onTap: () {
                                controller.selectedStorage.value = controller.storagePlanList[index];
                                Get.forceAppUpdate();
                              },
                              child: Container(
                                  width: 120.w,
                                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                                  decoration: BoxDecoration(color: controller.selectedStorage.value.title == controller.storagePlanList[index].title ? AppColor.appSkyBlue : Colors.transparent, border: Border.all(color: AppColor.appSkyBlue), borderRadius: BorderRadius.circular(15)),
                                  child: Column(children: [
                                    Row(
                                      children: [
                                        CustomButton(
                                          buttonName: controller.storagePlanList[index].title ?? '',
                                          height: 20.h,
                                          width: 60.w,
                                          color: controller.selectedStorage.value.title == controller.storagePlanList[index].title ? AppColor.appSkyBlue : AppColor.primaryColor,
                                          textSize: 12.sp,
                                          isbold: true,
                                          borderRadius: 8,
                                          backgroundColor: controller.selectedStorage.value.title == controller.storagePlanList[index].title ? AppColor.primaryColor : AppColor.appSkyBlue,
                                          onPressed: () {},
                                        ),
                                        Expanded(child: SizedBox(width: 10.w)),
                                        Visibility(visible: controller.selectedStorage.value.title == controller.storagePlanList[index].title ? true : false, child: const Icon(Icons.check_circle))
                                      ],
                                    ),
                                    SizedBox(height: 30.h),
                                    Text(
                                      "${controller.storagePlanList[index].fee}/${controller.storagePlanList[index].duration}",
                                      style: CustomTextStyle.font14R.copyWith(color: controller.selectedStorage.value.title == controller.storagePlanList[index].title ? AppColor.primaryColor : AppColor.appLightBlue, fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 10.h),
                                    Text(
                                      controller.storagePlanList[index].description ?? "",
                                      style: CustomTextStyle.font14R.copyWith(color: controller.selectedStorage.value.title == controller.storagePlanList[index].title ? AppColor.primaryColor : AppColor.appLightBlue),
                                      textAlign: TextAlign.center,
                                    )
                                  ])),
                            ),
                          ),
                  ),
                ),
                SizedBox(height: 50.h),
                CustomButton(
                  buttonName: Strings.updatePlan,
                  backgroundColor: /*controller.selectedStorage.value == '2 GB' ? AppColor.disableColor : */ AppColor.appSkyBlue,
                  borderColor: Colors.transparent,
                  width: 300.w,
                  height: 60.h,
                  isbold: true,
                  onPressed: () async {
                    if (controller.selectedStorage.value.title == null) {
                      scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(1, Strings.firstSelectStoragePlan));
                    } else {
                      controller.orderStoragePlan();
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
                  child: Text(Strings.selectedStorage, style: CustomTextStyle.font12R.copyWith(fontStyle: FontStyle.italic), textAlign: TextAlign.start),
                )
              ],
            ),
          ),
        ),

    );
  }
}
