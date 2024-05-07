import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/utils/singleton.dart';

class LoadingWidget extends StatelessWidget {
  final Widget widget;

  const LoadingWidget({
    Key? key,
    required this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(children: [
        widget,
        if(Singleton.isAPILoading.value)
        const Center(
          child: SpinKitWave(color: Colors.white, type: SpinKitWaveType.start),
        ),
      ]),
    );
  }
}
