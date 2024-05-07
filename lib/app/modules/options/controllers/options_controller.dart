import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vloo/app/data/configs/api_config.dart';
import 'package:vloo/app/data/models/common/common_response.dart';
import 'package:vloo/app/data/models/options/currency_model.dart';
import 'package:vloo/app/data/utils/singleton.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/utils/utils.dart';
import 'package:vloo/app/data/utils/zbot_toast.dart';
import 'package:vloo/app/modules/templates/views/Widget/app_loader.dart';
import 'package:vloo/app/repository/rest_api.dart';
import 'package:vloo/app/routes/app_pages.dart';
import 'package:vloo/main.dart';

class OptionsController extends GetxController {
  String title = Strings.dummyProjectName;
  final GetStorage storage = Get.find<GetStorage>();
  final RestAPI restAPI = Get.find<RestAPI>();

  List<CurrencyModel> list = [
    CurrencyModel(countryCode: 'PK', countryName: 'PAK'),
    CurrencyModel(countryCode: 'US', countryName: 'USA'),
    CurrencyModel(countryCode: 'CA', countryName: 'CAD'),
    CurrencyModel(countryCode: 'AW', countryName: 'AED'),
  ];

  List<CurrencyModel> currencyFormatList = [
    CurrencyModel(
        countryCode: '10\$99', countryName: 'Currency Symbol in the middle'),
    CurrencyModel(
        countryCode: '10\$99', countryName: 'Currency Symbol in the left'),
    CurrencyModel(
        countryCode: '10\$99', countryName: 'Currency Symbol in the right'),
  ];

  String getCountryFlag(String countryCode) {
    return countryCode.toUpperCase().replaceAllMapped(
        RegExp(r'[A-Z]'),
        (match) =>
            String.fromCharCode((match.group(0)?.codeUnitAt(0))! + 127397));
  }

  final count = 0.obs;

  bool showSnackBarError() {
    String errorMessage = "";

    if (title.isEmpty) {
      errorMessage = "Please enter title value first";
    }

    if (errorMessage.isNotEmpty) {
      scaffoldKey.currentState
          ?.showSnackBar(SnackBar(content: Text(errorMessage)));
    }

    return errorMessage.isNotEmpty;
  }

  Future<void> updateMyScreenTitle(
      String comingFrom, num screenID, String? prevValue) async {
    if (!showSnackBarError()) {
      AppLoader.showLoader();

      Map<String, dynamic> params = {};
      String url = "";

      switch (comingFrom) {
        case Strings.template:
          params["template_id"] = screenID;
          params["title"] = title.isNotEmpty ? title : prevValue;
          url = ApiConfig.updateTemplateTitleURL;
          break;

        case Strings.screens:
          params["screen_id"] = screenID;
          params["title"] = title.isNotEmpty ? title : prevValue;
          url = ApiConfig.updateScreenTitleURL;
          break;

        case Strings.medias:
          params["media_id"] = screenID;
          params["name"] = title.isNotEmpty ? title : prevValue;
          url = ApiConfig.mediaEditURL;
          break;
      }

      var response =
          await restAPI.postDataMethod(url, Singleton.header, params);
      if (response != null) {
        try {
          CommonResponse updateResponse = CommonResponse.fromJson(response);
          print(updateResponse.message);
          scaffoldKey.currentState?.showSnackBar(
              Utils.getSnackBar(2, updateResponse.message ?? Strings.success));

          //  if (updateResponse.status == 200) {
          AppLoader.hideLoader();
          Get.back();
          // }
        } on Exception catch (_) {
          AppLoader.hideLoader();
          scaffoldKey.currentState
              ?.showSnackBar(Utils.getSnackBar(3, response["message"]));
          print(response);
          rethrow;
        }
      } else {
        AppLoader.hideLoader();
        scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(
            3, Singleton.errorResponse?.message ?? Strings.somethingWentWrong));
      }
    }
  }

  Future<void> duplicateTemplate(String id) async {
    AppLoader.showLoader();
    Map<String, dynamic> params = {
      "template_id": id,
      "predefined" :await storage.read(Strings.userEmail)== 'templateadmin@vloo.com' ? 1 : 0,
    };

    var response = await restAPI.postDataMethod(
        ApiConfig.duplicateTemplateURL, Singleton.header, params);

    if (response != null) {
      try {
        CommonResponse updateResponse = CommonResponse.fromJson(response);
        print(updateResponse.message);

        if (updateResponse.status == 200) {
          scaffoldKey.currentState?.showSnackBar(
              Utils.getSnackBar(2, updateResponse.message ?? Strings.success));
          AppLoader.hideLoader();
        } else {
          AppLoader.hideLoader();
          scaffoldKey.currentState?.showSnackBar(
              Utils.getSnackBar(1, updateResponse.message ?? Strings.success));
        }
      } on Exception catch (_) {
        scaffoldKey.currentState
            ?.showSnackBar(Utils.getSnackBar(3, response["message"]));
        AppLoader.hideLoader();
        print(response);
        rethrow;
      }
    } else {
      AppLoader.hideLoader();
      scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(
          3, Singleton.errorResponse?.message ?? Strings.somethingWentWrong));
    }
  }

  Future<void> deleteTemplate(String id) async {
    AppLoader.showLoader();
    Map<String, dynamic> params = {};
    params["template_id"] = id;

    var response = await restAPI.postDataMethod(
        ApiConfig.deleteTemplateURL, Singleton.header, params);

    if (response != null) {
      try {
        CommonResponse updateResponse = CommonResponse.fromJson(response);
        print(updateResponse.message);

        if (updateResponse.status == 200) {
          scaffoldKey.currentState?.showSnackBar(
              Utils.getSnackBar(2, updateResponse.message ?? Strings.success));
          AppLoader.hideLoader();
          Get.close(3);
        } else {
          AppLoader.hideLoader();
          scaffoldKey.currentState?.showSnackBar(
              Utils.getSnackBar(1, updateResponse.message ?? Strings.success));
        }
      } on Exception catch (_) {
        scaffoldKey.currentState
            ?.showSnackBar(Utils.getSnackBar(3, response["message"]));
        AppLoader.hideLoader();
        print(response);
        rethrow;
      }
    } else {
      AppLoader.hideLoader();
      scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(
          3, Singleton.errorResponse?.message ?? Strings.somethingWentWrong));
    }
  }
}
