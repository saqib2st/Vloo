import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/configs/text.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/modules/textEditing/views/editing/currency_choice.dart';
import 'package:vloo/app/modules/textEditing/views/editing/currency_format.dart';
import 'package:vloo/app/data/widgets/cutom_tabs.dart';
import 'package:vloo/app/modules/textEditing/controllers/title_editing_controller.dart';
import 'package:vloo/custom_icons.dart';

class OptionsEdit extends GetView<TitleEditingController> {
  const OptionsEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DefaultTabController(
      length: 2,
      child: Container(
        color: AppColor.primaryDarkColor,
        child: Column(
          children: [
            TabBar(
              dividerColor: AppColor.transparent,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorPadding: const EdgeInsets.fromLTRB(8, 0, 8 , 8),
              labelPadding: const EdgeInsets.fromLTRB(3, 0, 3 , 0),
              indicatorColor: AppColor.appSkyBlue,
              indicatorWeight: 4,
              labelColor: AppColor.appSkyBlue,
              unselectedLabelColor: AppColor.hintTextColor,
              labelStyle: CustomTextStyle.font14R,
              tabs:  [
                CustomTab(
                  icon: Icon(size: 20.w,FlutterCustomIcons.currency_icon),
                  text: Strings.currencyChoice,
                ),
                CustomTab(
                  icon: Icon(size: 20.w,FlutterCustomIcons.terminal_icon),
                  text: Strings.format,
                ),
              ],
            ),
            const Expanded(
                child: TabBarView(children: [
              SingleChildScrollView(child: CurrencyChoiceWidget()),
              SingleChildScrollView(child: CurrencyFormatWidget())
            ]))
          ],
        ),
      ),
    ));
  }
}
