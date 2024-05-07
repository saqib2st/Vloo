import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/configs/text.dart';
import 'package:vloo/app/data/models/media/MediaModel.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/widgets/primary_appbar.dart';
import 'package:vloo/app/modules/myscreens/controllers/myscreens_controller.dart';

class PreviewProject extends StatefulWidget {
  final MediaModel? mediaModel;

  const PreviewProject({super.key, this.mediaModel});

  @override
  State<PreviewProject> createState() => _PreviewProjectState();
}

class _PreviewProjectState extends State<PreviewProject> {
  late VideoPlayerController videoController;
  double currentPosition = 0.0;
  bool buttonVisible = true;

  @override
  void initState() {
    videoController = VideoPlayerController.networkUrl(Uri.parse(widget.mediaModel?.url ?? ""))
      ..initialize().then((_) {
        setState(() {});
      });
    videoController.addListener(() {
      if (videoController.value.isPlaying) {
        currentPosition = videoController.value.position.inSeconds.toDouble();
        setState(() {});
      }
    });
    super.initState();
  }

  void playOrPause() {
    if (videoController.value.isPlaying) {
      videoController.pause();
    } else {
      videoController.play();
    }
    setState(() {});
  }

  void seekTo(double seconds) {
    videoController.seekTo(Duration(seconds: seconds.toInt()));
  }

  @override
  void dispose() {
    videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: PrimaryAppbar(
        title: Strings.previewOfProject,
        text: Strings.confirm,
        onPressed: () {
          Get.back();
        },
        onPressed2: () {
          Get.back();
        },
      ),
      body: Column(                        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Center(
                child: GetBuilder<MyscreensController>(
                  init: MyscreensController(), // Initialize the controller
                  builder: (controller) {
                    if (videoController.value.isInitialized) {
                      return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                buttonVisible = true;
                              },
                              child: Container(

                                decoration: BoxDecoration(border: Border.all(color: AppColor.appLightBlue)),
                                child: AspectRatio(
                                  aspectRatio: videoController.value.aspectRatio.w / videoController.value.aspectRatio.h,
                                  child: VideoPlayer(videoController),
                                ),
                              ),
                            ),
                            Slider(
                              value: currentPosition,
                              min: 0.0,
                              max: videoController.value.duration.inSeconds.toDouble(),
                              onChanged: (value) {
                                currentPosition = value;
                                seekTo(value);
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40.w),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      '${currentPosition.toInt()} ${Strings.sec}',
                                      style: CustomTextStyle.font12R,
                                    ),
                                  ),
                                  Text(
                                    '${videoController.value.duration.inSeconds} ${Strings.sec}',
                                    style: CustomTextStyle.font12R,
                                  )
                                ],
                              ),
                            )
                          ],
                        );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
              ),
              Visibility(
                  visible: videoController.value.isPlaying ? buttonVisible : buttonVisible,
                  child: GetBuilder<MyscreensController>(
                    builder: (controller) {
                      return GestureDetector(
                        onTap: () {
                          playOrPause();
                          buttonVisible = false;
                        },
                        child: Icon(
                          videoController.value.isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
                          color: AppColor.appLightBlue,
                          size: 80,
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
