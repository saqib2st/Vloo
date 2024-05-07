import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/widgets/custom_buttons.dart';
import 'package:vloo/app/data/widgets/primary_appbar.dart';
import 'package:vloo/app/modules/templates/controllers/templates_controller.dart';

class VideoRecorderPreview extends StatelessWidget {
  final List<int> videoGifData;
  final String orientation;

  const VideoRecorderPreview({
    Key? key,
    required this.videoGifData, required this.orientation,
  }) : super(key: key);

  /* Showing data for recorded GIF file from templates screen. This is preview screen*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppbar(
        title: Strings.videoExport,
        text: '',
        onPressed: () {
          Get.back();
        },
        onPressed2: () {},
      ),
      backgroundColor: AppColor.primaryDarkColor,
      body: SingleChildScrollView(
        child: AspectRatio(
          aspectRatio:orientation == Strings.landscape? 9.w / 9.h : 9.w / 16.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.memory(fit: BoxFit.contain, Uint8List.fromList(videoGifData)),
              SizedBox(height: 20.h),
              CustomButton(
                buttonName: Strings.saveVideo,
                borderColor: AppColor.appSkyBlue,
                color: AppColor.appSkyBlue,
                width: 200,
                type: ButtonVariant.filled,
                isbold: true,
                textSize: 12.sp,
                textColor: AppColor.primaryDarkColor,
                onPressed: () async {
                  Directory? storageDir = await getTemporaryDirectory();
                  String tempFilePath = '${storageDir.path}/screenshot.gif';
        
                  TemplatesController controller = Get.put(TemplatesController());
                  await controller.uploadMediaToServer(await File(tempFilePath).writeAsBytes(Uint8List.fromList(videoGifData)));
        
                  Get.back();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
