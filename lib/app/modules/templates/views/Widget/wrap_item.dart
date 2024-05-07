import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vloo/app/modules/templates/controllers/templates_controller.dart';

class WrapItem extends GetView<TemplatesController> {

    final String? title, prize, description, imageUrl;
  final TextStyle? titleTextStyle, prizeTextStyle, descriptionTextStyle;
  const WrapItem( {super.key, this.title, this.prize, this.imageUrl, this.description, this.titleTextStyle, this.prizeTextStyle, this.descriptionTextStyle,});


  @override
  Widget build(BuildContext context) {
    return Container(
      // height: Get.height * 0.15,
      width: Get.width * 0.35,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(11)),
      child: Column(children: [
        CircleAvatar(
          radius: 35,
          backgroundColor: const Color.fromARGB(255, 3, 52, 138),
          backgroundImage: NetworkImage(imageUrl ?? ""),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          title ?? 'Item Title here',
          style: titleTextStyle,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          prize ?? 'Item Prize here',
          style: prizeTextStyle,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          description ?? 'Item Prize here',
          style: descriptionTextStyle,
        ),
      ]),
    );
  }
}
