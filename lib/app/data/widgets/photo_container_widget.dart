import 'package:flutter/material.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/models/stockphoto/vloo_library_images.dart';
import 'package:vloo/app/data/utils/utils.dart';
import 'package:vloo/app/data/widgets/loading_widget.dart';

class PhotoContainerWidget extends StatelessWidget {
  final int listSize;
  final Function() onPressed;
  final List<LibraryImages>? modelList;

  const PhotoContainerWidget({
    Key? key,
    required this.listSize,
    required this.onPressed,
    this.modelList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoadingWidget(
      widget: GridView(
        shrinkWrap: true,
        padding: const EdgeInsets.fromLTRB(20, 20, 10, 20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.2,
        ),
        children: <Widget>[
          ...List.generate(listSize, (index) {
            return GestureDetector(
                onTap: onPressed,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Utils.getNetworkImage(modelList?[index].mediaFile ?? "", BoxFit.cover, 250.w, 100.h),
                ));
          }).toList()
        ],
      ),
    );
  }
}
