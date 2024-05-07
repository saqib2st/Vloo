import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/configs/text.dart';
import 'package:vloo/app/data/models/media/MediaModel.dart';
import 'package:vloo/app/data/utils/static_assets.dart';
import 'package:vloo/app/data/utils/utils.dart';
import 'package:vloo/app/data/widgets/custom_buttons.dart';
import 'package:vloo/app/data/widgets/custom_row_icon.dart';
import 'package:vloo/app/modules/myscreens/controllers/myscreens_controller.dart';

class CustomContentScreenList extends GetView<MyscreensController> {
  final MediaModel? mediaModel;
  final String index;
  const CustomContentScreenList({super.key, required this.mediaModel, required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(index, style: CustomTextStyle.font18R),
            SizedBox(
              width: 35.w,
            ),
            CustomButton(
              buttonName:mediaModel?.isTemplate ==true?'Template': mediaModel?.type ?? "",
              height: 30.h,
              width:mediaModel?.isTemplate ==true?95.w: 80.w,
              textColor: AppColor.primaryColor,
              isbold:mediaModel?.isTemplate ==true?false: true,
              borderRadius: 8,
              backgroundColor: AppColor.secondaryColor,
              onPressed: () {},
            ),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
              child: Text(
                mediaModel?.isTemplate ==true?mediaModel?.title??'':mediaModel?.name ?? "",
                style: CustomTextStyle.font14R,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            //Todo will continue if design not approves [slide-able]
            // InkWell(
            //   borderRadius: BorderRadius.circular(20),
            //     onTap: (){
            //       // if templateId is coming the APii will detach template from the screen else detach Media
            //       if(mediaModel?.isTemplate==false) {
            //         controller.removeMyScreenContent(mediaID: controller.selectedScreenModel.value.uploadMedias?[int.parse(index)].id);
            //       }else {
            //         controller.removeMyScreenContent(templateId: controller.selectedScreenModel.value.uploadMedias?[int.parse(index)].id);
            //       }
            //     },
            //     child: Padding(
            //       padding: EdgeInsets.all(3.w),
            //       child: Icon(Icons.close,color: AppColor.red,size: 26.h,),
            //     ))
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          child: Row(
            children: [
              SvgPicture.asset(
                StaticAssets.icSort,
                placeholderBuilder: (BuildContext context) => Container(
                    padding: const EdgeInsets.all(30.0),
                    child: const CircularProgressIndicator()),
              ),
              SizedBox(
                width: 15.w,
              ),
              Stack(alignment: Alignment.center, children: [
                Utils.getNetworkImage(mediaModel?.isTemplate ==true?mediaModel?.featureImg??"":mediaModel?.thumbnail ?? "",mediaModel?.isTemplate ==true?BoxFit.fill: BoxFit.cover, 100.w, 100.h),
                SvgPicture.asset(
                  (mediaModel?.type == "Video") ? StaticAssets.icPlay : StaticAssets.icEye,
                  width: 40.w,
                  height: 40.h,
                  placeholderBuilder: (BuildContext context) => Container(
                      padding: const EdgeInsets.all(30.0),
                      child: const CircularProgressIndicator()),
                ),
              ]),
              SizedBox(
                width: 20.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (mediaModel?.duration?.isNotEmpty == true)
                    CustomRowIcon(
                      text: mediaModel?.duration ?? "",
                      logoAsset: StaticAssets.icClock,
                    ),
                  CustomRowIcon(
                    text: 'created on ${Utils.getDateInFormat(mediaModel?.createdAt ?? "", "yyyy-MM-ddThh:mm:ss.000000Z", "dd/MM/yyyy")}',
                    logoAsset: StaticAssets.icCalendar,
                  ),
                  CustomRowIcon(
                    text:mediaModel?.isTemplate ==true?mediaModel?.orientation ??'': mediaModel?.filesize ?? "",
                    logoAsset: StaticAssets.fileIcon,
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
