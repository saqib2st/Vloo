import 'dart:io';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as https;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vloo/app/data/configs/api_config.dart';
import 'package:vloo/app/data/models/common/common_response.dart';
import 'package:vloo/app/data/models/media/MediaModel.dart';
import 'package:vloo/app/data/models/screens/ScreenCount.dart';
import 'package:vloo/app/data/models/screens/ScreenModel.dart';
import 'package:vloo/app/data/models/template/Template.dart';
import 'package:vloo/app/data/models/template/Template_response.dart';
import 'package:vloo/app/data/utils/singleton.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/utils/utils.dart';
import 'package:vloo/app/modules/templates/views/Widget/app_loader.dart';
import 'package:vloo/app/modules/templates/views/blank_template.dart';
import 'package:vloo/app/repository/rest_api.dart';
import 'package:vloo/main.dart';

class MyscreensController extends GetxController with GetSingleTickerProviderStateMixin{
  final RxBool isCheckedHorizontal = false.obs;
  final RxBool isCheckedVerticalLeft = false.obs;
  final RxBool isCheckedVerticalRight = false.obs;
  final RxBool buttonVisible = true.obs;
  RxString dropdownMinvalue = '1'.obs;
  RxString dropdownSecvalue = '10'.obs;
  List<int> min = List.generate(60, (index) => index + 1);
  List<int> sec = [10, 20, 30, 40, 50, 60];

  final RestAPI restAPI = Get.find<RestAPI>();
  final RefreshController refreshController = RefreshController(initialRefresh: false);
  SlidableController? slidableController ;
  RxInt connectedScreens = 0.obs;
  RxInt offlineScreens = 0.obs;
  RxInt withoutContentScreens = 0.obs;
  final RxList<ScreenModel> screenList = <ScreenModel>[].obs;
  Rx<ScreenModel> selectedScreenModel = ScreenModel().obs;
  String selectedOrientation = "";
  Rx<Template> selectedTemplate = Template().obs;

  final RxList<Template> templateList = <Template>[].obs;
  final RxList<MediaModel> mediaList = <MediaModel>[].obs;

  Future<void> toBlankTemplate() async {
    await Get.to(const BlankTemplate());
  }

  void setSelectedScreenModel(ScreenModel model) {
    selectedScreenModel.value = model;
  }

  void onRefresh() async {
    templateList.clear();
    mediaList.clear();
    await getMyScreensCount();
    await getMyScreensListing();
    await getTemplateProjectsList();
    await getMyMediaList();
    refreshController.refreshCompleted();
  }

  @override
  void onReady() {
    onRefresh();
    super.onReady();
  }

  void setScreenOrientationValue(String value) {
    isCheckedHorizontal.value = false;
    isCheckedVerticalLeft.value = false;
    isCheckedVerticalRight.value = false;

    switch (value) {
      case Strings.horizontal:
        {
          selectedOrientation = "Landscape";
          isCheckedHorizontal.value = true;
        }
        break;
      case Strings.verticalLeft:
        {
          selectedOrientation = "Portrait Left";
          isCheckedVerticalLeft.value = true;
        }
        break;
      case Strings.verticalRight:
        {
          selectedOrientation = "Portrait Right";
          isCheckedVerticalRight.value = true;
        }
        break;
    }
  }

  bool showSnackBarError() {
    String errorMessage = "";

    if (selectedOrientation.isEmpty) {
      errorMessage = "Please select any orientation first";
    }

    if (errorMessage.isNotEmpty) {
      scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text(errorMessage)));
    }

    return errorMessage.isNotEmpty;
  }

  // API integration for my screens
  Future<void> getMyScreensCount() async {
    AppLoader.showLoader();
    var response = await restAPI.getDataMethod(ApiConfig.screensListingCountURL, Singleton.header, null);
    if (response != null) {
      try {
        CommonResponse updateResponse = CommonResponse.fromJson(response);

        ScreenCount userResponse = ScreenCount.fromJson(updateResponse.result);
        connectedScreens.value = userResponse.connectedScreens ?? 0;
        offlineScreens.value = userResponse.offlineScreens ?? 0;
        withoutContentScreens.value = userResponse.screensWithoutContent ?? 0;
        AppLoader.hideLoader();
        print(updateResponse.message);
        //scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(2, updateResponse.message ?? Strings.success));
      } on Exception catch (_) {
        AppLoader.hideLoader();
        scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(3, response["message"]));
        print(response);
        rethrow;
      }
    } else {
      AppLoader.hideLoader();
      scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(3, Singleton.errorResponse?.message ?? Strings.somethingWentWrong));
    }
  }

  Future<void> getMyScreensListing() async {
    AppLoader.showLoader();
    var response = await restAPI.getDataMethod(ApiConfig.screensListingURL, Singleton.header, null);
    if (response != null) {
      try {
        CommonResponse updateResponse = CommonResponse.fromJson(response);
        screenList.clear();
        AppLoader.hideLoader();
        if (updateResponse.status == 200 && updateResponse.result != null && updateResponse.result!.isNotEmpty) {
          for (int index = 0; index < updateResponse.result.length; index++) {
            screenList.add(ScreenModel.fromJson(updateResponse.result[index]));
          }
          screenList.value = screenList.reversed.toList();
        } else {
          scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(1, updateResponse.message ?? Strings.success));
        }
        screenList.refresh();
        print(updateResponse.message);
      } on Exception catch (_) {
        AppLoader.hideLoader();
        scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(3, response["message"]));
        print(response);
        rethrow;
      }
    } else {
      AppLoader.hideLoader();
      scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(3, Singleton.errorResponse?.message ?? Strings.somethingWentWrong));
    }
  }

  Future<void> getMyScreenDetails() async {
    var id = selectedScreenModel.value.id ?? 0;
    var url = "${ApiConfig.screenDetailsURL}?screen_id=$id";

    AppLoader.showLoader();
    var response = await restAPI.getDataMethod(url, Singleton.header, null);
    if (response != null) {
      try {
        CommonResponse updateResponse = CommonResponse.fromJson(response);
        AppLoader.hideLoader();
        if (updateResponse.status == 200 && updateResponse.result != null && updateResponse.result!.isNotEmpty) {
          selectedScreenModel.value = ScreenModel.fromJson(updateResponse.result);
        } else {
          scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(3, updateResponse.message ?? Strings.success));
        }

        print(updateResponse.message);
      } on Exception catch (_) {
        AppLoader.hideLoader();
        scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(3, response["message"]));
        print(response);
        rethrow;
      }
    } else {
      AppLoader.hideLoader();
      scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(3, Singleton.errorResponse?.message ?? Strings.somethingWentWrong));
    }
  }

  Future<void> updateMyScreenOrientation(num screenID) async {
    if (!showSnackBarError()) {
      AppLoader.showLoader();
      // ZBotToast.loadingShow();

      Map<String, dynamic> params = {};
      params["screen_id"] = screenID;
      params["orientation"] = selectedOrientation;

      var response = await restAPI.postDataMethod(ApiConfig.updateScreenOrientationURL, Singleton.header, params);
      if (response != null) {
        try {
          CommonResponse updateResponse = CommonResponse.fromJson(response);
          print(updateResponse.message);
          scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(2, updateResponse.message ?? Strings.success));
          AppLoader.hideLoader();

          if (updateResponse.status == 200) {
            Get.back();
          }
        } on Exception catch (_) {
          AppLoader.hideLoader();
          scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(3, response["message"]));
          print(response);
          rethrow;
        }
      } else {
        AppLoader.hideLoader();
        scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(3, Singleton.errorResponse?.message ?? Strings.somethingWentWrong));
      }
      //ZBotToast.loadingClose();
    }
  }

  Future<void> addMyScreenContent({num? mediaID,int? templateId}) async {
    AppLoader.showLoader();

    Map<String, dynamic> params = {};
    params["media_id"] = mediaID;
    params["template_id"] = templateId;
    params["screen_id"] = selectedScreenModel.value.id;

    var response = await restAPI.postDataMethod(ApiConfig.addScreenContentURL, Singleton.header, params);
    if (response != null) {
      try {
        CommonResponse updateResponse = CommonResponse.fromJson(response);
        print(updateResponse.message);
        scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(2, updateResponse.message ?? Strings.success));
        AppLoader.hideLoader();

        if (updateResponse.status == 200) {
          await getMyScreenDetails();
          Get.back();
          selectedTemplate.value = Template();//this is only for changing border color on selecting a template
        }
      } on Exception catch (_) {
        AppLoader.hideLoader();
        scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(3, response["message"]));
        print(response);
        rethrow;
      }
    } else {
      AppLoader.hideLoader();
      scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(3, Singleton.errorResponse?.message ?? Strings.somethingWentWrong));
    }
    //ZBotToast.loadingClose();
  }
  Future<void> removeMyScreenContent({num? mediaID,int? templateId}) async {
    AppLoader.showLoader();

    Map<String, dynamic> params = {};
    params["media_id"] = mediaID;
    params["template_id"] = templateId;
    params["screen_id"] = selectedScreenModel.value.id;

    var response = await restAPI.postDataMethod(ApiConfig.removeScreenContentURL, Singleton.header, params);
    if (response != null) {
      try {
        CommonResponse updateResponse = CommonResponse.fromJson(response);
        print(updateResponse.message);
        scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(2, updateResponse.message ?? Strings.success));
        AppLoader.hideLoader();

        if (updateResponse.status == 200) {
          await getMyScreenDetails();
        }
      } on Exception catch (_) {
        AppLoader.hideLoader();
        scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(3, response["message"]));
        print(response);
        rethrow;
      }
    } else {
      AppLoader.hideLoader();
      scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(3, Singleton.errorResponse?.message ?? Strings.somethingWentWrong));
    }
    //ZBotToast.loadingClose();
  }

  Future<void> deleteMyScreen(num? screenID) async {
    AppLoader.showLoader();
    var url = "${ApiConfig.deleteScreenURL}?screen_id=$screenID";

    var response = await restAPI.getDataMethod(url, Singleton.header, null);
    if (response != null) {
      try {
        CommonResponse updateResponse = CommonResponse.fromJson(response);
        print(updateResponse.message);
        scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(2, updateResponse.message ?? Strings.success));
        AppLoader.hideLoader();

        if (updateResponse.status == 200) {
          Get.back();
        }
      } on Exception catch (_) {
        AppLoader.hideLoader();
        scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(3, response["message"]));
        print(response);
        rethrow;
      }
    } else {
      AppLoader.hideLoader();
      scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(3, Singleton.errorResponse?.message ?? Strings.somethingWentWrong));
    }
  }

  Future<void> getTemplateProjectsList() async {
    /* if (!showSnackBarError()) {*/

    AppLoader.showLoader();
    var response = await restAPI.getDataMethod(ApiConfig.getSavedTemplateListingURL, Singleton.header, null);
    if (response != null) {
      try {
        TemplateResponse model = TemplateResponse.fromJson(response);
        if (model.status == 200 && model.result != null && model.result!.isNotEmpty) {
          templateList.addAll(model.result as Iterable<Template>);
          templateList.refresh();
          AppLoader.hideLoader();
        } else {
          AppLoader.hideLoader();
          scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(2, model.message ?? Strings.success));
        }

        print(model.message);
      } on Exception catch (_) {
        AppLoader.hideLoader();

        scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(3, response["message"]));
        print(response);
        rethrow;
      }
    } else {
      AppLoader.hideLoader();
      scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text(Singleton.errorResponse?.message ?? "Server Error")));
    }
  }

  List<Template>? fetchFilteredList(String orientation) {
    if (templateList.value.isNotEmpty) {
      var list = templateList.where((p) => p.orientation == orientation);
      return list.toList();
    }
    return null;
  }

  Future<void> getMyMediaList() async {
    /* if (!showSnackBarError()) {*/
    mediaList.clear();
    AppLoader.showLoader();

    var response = await restAPI.getDataMethod(ApiConfig.mediaListingURL, Singleton.header, null);
    if (response != null) {
      try {
        CommonResponse model = CommonResponse.fromJson(response);
        if (model.status == 200 && model.result != null && model.result!.isNotEmpty) {
          List<MediaModel> list = <MediaModel>[];
          for (int index = 0; index < model.result.length; index++) {
            list.add(MediaModel.fromJson(model.result[index]));
          }
          mediaList.value = list.reversed.toList();
          AppLoader.hideLoader();
        } else {
          AppLoader.hideLoader();
          scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(2, model.message ?? Strings.success));
        }
        mediaList.refresh();
        print(model.message);
      } on Exception catch (_) {
        AppLoader.hideLoader();
        scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(3, response["message"]));
        print(response);
        rethrow;
      }
    } else {
      AppLoader.hideLoader();
      scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text(Singleton.errorResponse?.message ?? "Server Error")));
    }
  }

  Future<String?> selectImageFromGallery() async {
    XFile? file = await ImagePicker().pickMedia(imageQuality: 10);
    return file?.path;
  }

  Future<String?> uploadMediaToServer(String? path) async {
    if (path == null || path.isEmpty) return null;
    AppLoader.showLoader();

    var featureImgVideo = File(path);
    var documentFrontStream = https.ByteStream(DelegatingStream.typed(featureImgVideo.openRead()));
    var documentFrontLength = await featureImgVideo.length();
    String fileName = basename(featureImgVideo.path).toString();
    String extension = fileName.toString().split('.').last;

    List<https.MultipartFile> multipartFiles = [];
    multipartFiles.add(https.MultipartFile('file', documentFrontStream, documentFrontLength, filename: fileName));

    Map<String, String> params = {
      'name': fileName.toString().split('.').first,
      'type': (extension == "png" || extension == "jpg" || extension == "jpeg") ? "Image" : "Video",
    };

    var response = await restAPI.postMultipartMethod(ApiConfig.mediaUploadURL, multipartFiles, params, true);
    if (response != null && response.isNotEmpty) {
      try {
        AppLoader.hideLoader();

        return response;
      } on Exception catch (e) {
        AppLoader.hideLoader();
        scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(3, response));
        print(e);
        rethrow;
      }
    } else {
      AppLoader.hideLoader();
      scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(3, Singleton.errorResponse?.message ?? Strings.somethingWentWrong));
    }

    return null;
  }

  @override
  void onInit() {
    slidableController = SlidableController(this);
    super.onInit();
  }
}
