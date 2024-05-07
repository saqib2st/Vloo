import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/configs/text.dart';
import 'package:vloo/app/data/utils/static_assets.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/modules/myprojects/controllers/myprojects_controller.dart';
import 'package:vloo/app/modules/myprojects/views/myprojects_view.dart';

class CreateNewProject extends GetView<MyprojectsController> {
  const CreateNewProject({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.primaryColor,
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          title: Padding(
            padding: EdgeInsets.only(top: 50.h),
            child: Text(
              Strings.myProjects,
              style:
                  CustomTextStyle.font22R.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          backgroundColor: AppColor.primaryColor,
          centerTitle: true,
          elevation: 0,
          toolbarHeight: 120.h,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50),
          child: Column(
            children: [
              Image.asset(
                StaticAssets.icMyProject,
                fit: BoxFit.none,
              ),
              SizedBox(
                height: 35.h,
              ),
              Text(
                Strings.createFirstMenuBoard,
                style: CustomTextStyle.font20R
                    .copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 35.h,
              ),
              Text(
                Strings.createNewProject,
                style: CustomTextStyle.font16R,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 35.h,
              ),
              GestureDetector(
                onTap: () {
                  controller.toBlankTemplate();
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColor.appSkyBlue,
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        StaticAssets.icPlus,
                        fit: BoxFit.none,
                      ),
                      Text(
                        Strings.newProject,
                        style: CustomTextStyle.font16R.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColor.appSkyBlue),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
