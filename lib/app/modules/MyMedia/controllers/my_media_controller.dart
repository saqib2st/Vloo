import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as https;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
// import 'package:photo_manager/photo_manager.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vloo/app/data/configs/api_config.dart';
import 'package:vloo/app/data/models/buy_dongle_delivery_address/Delivery_address_response.dart';
import 'package:vloo/app/data/models/buy_storage/buy_storage_response.dart';
import 'package:vloo/app/data/models/common/common_response.dart';
import 'package:vloo/app/data/models/common/dummy_model.dart';
import 'package:vloo/app/data/models/media/MediaDetailsModel.dart';
import 'package:vloo/app/data/models/media/MediaModel.dart';
import 'package:vloo/app/data/models/plans/plan.dart';
import 'package:vloo/app/data/models/storage/UsedStorageModel.dart';
import 'package:vloo/app/data/utils/singleton.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/utils/utils.dart';
import 'package:vloo/app/modules/MyMedia/views/payment_successful_screen.dart';
import 'package:vloo/app/modules/stripeIntegrations/controllers/stripe_integrations_controller.dart';
import 'package:vloo/app/modules/templates/views/Widget/app_loader.dart';
import 'package:vloo/app/repository/rest_api.dart';
import 'package:vloo/main.dart';

class MyMediaController extends GetxController {
  Rx<Plan> selectedStorage = Plan().obs;
  RxString selectedVideoThumbnailPath = ''.obs;
  Rx<Uint8List?> processedImageBytes = Rx<Uint8List?>(null);
  Rx<File?> thumbnailFile = Rx<File?>(null);
  final RxList<MediaModel> mediaList = <MediaModel>[].obs;
  final RxList<Plan> storagePlanList = <Plan>[].obs;
  Rx<MediaDetailsModel> mediaDetailsModel = MediaDetailsModel().obs;
  Rx<UsedStorageModel> usedStorageModel = UsedStorageModel().obs;
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  final RestAPI restAPI = Get.find<RestAPI>();

  List<DummyModel> storageList = [
    DummyModel(
        storage: '2 GB',
        prize: 'Included in \n the plan',
        currentPlan: 'Current plan'),
    DummyModel(storage: '5 GB', prize: '2€99\n/Month', currentPlan: 'Upgrade'),
    DummyModel(storage: '10 GB', prize: '4€99\n/Month', currentPlan: 'Upgrade'),
  ];

  int planID = 0;
  String paymentStatus = "";
  String paymentMethod = "";
  String startDate = "";
  String expiryDate = "";
  String type = "";
  double totalPrice = 0;

  //List<AssetEntity> galleryMediaList = [];

  late CustomPainter _balls;
  double xPos = 100;
  double yPos = 100;
  bool isClick = false;

  CustomPainter get balls => _balls;

  void setBalls(CustomPainter painter) {
    _balls = painter;
    update();
  }

  bool isBallRegion(double checkX, double checkY) {
    if ((pow(xPos - checkX, 2) + pow(yPos - checkY, 2)) <= pow(20, 2)) {
      return true;
    }
    return false;
  }

  void updatePosition(double newX, double newY) {
    xPos = newX;
    yPos = newY;
    update();
  }

  final count = 0.obs;
  final List<Offset> _positions = <Offset>[];
  List<Offset> get positions => _positions;

  void addPosition(Offset position) {
    _positions.add(position);
    update();
  }

  void clearPositions() {
    _positions.clear();
    update();
  }

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    storagePlanList.clear();
    await getStoragePlanList();
  }

  void onRefresh() async {
    mediaList.clear();
    await getMyStorageSpace();
    await getMyMediaList();
    refreshController.refreshCompleted();
  }

  @override
  void onReady() {
    onRefresh();
    super.onReady();
  }

  Future<void> toMediaDetails() async {
    // await Get.to(const BlankTemplate());
    onRefresh();
  }

  Future<void> getMyMediaList() async {
    /* if (!showSnackBarError()) {*/
    mediaList.clear();
    AppLoader.showLoader();
    var response = await restAPI.getDataMethod(
        ApiConfig.mediaListingURL, Singleton.header, null);
    if (response != null) {
      try {
        CommonResponse model = CommonResponse.fromJson(response);
        if (model.status == 200 &&
            model.result != null &&
            model.result!.isNotEmpty) {
          List<MediaModel> list = <MediaModel>[];
          for (int index = 0; index < model.result.length; index++) {
            list.add(MediaModel.fromJson(model.result[index]));
          }
          mediaList.value = list.reversed.toList();
        }
        AppLoader.hideLoader();
        mediaList.refresh();
        print(model.message);
        //  scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(2, model.message ?? Strings.success));
      } on Exception catch (_) {
        scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(3, response["message"]));
        print(response);
        AppLoader.hideLoader();
        rethrow;
      }
    } else {
      AppLoader.hideLoader();
      scaffoldKey.currentState?.showSnackBar(SnackBar(
          content: Text(Singleton.errorResponse?.message ?? "Server Error")));
    }
  }

  Future<void> getMyStorageSpace() async {
    var response = await restAPI.getDataMethod(
        ApiConfig.usedStorageURL, Singleton.header, null);
    if (response != null) {
      try {
        CommonResponse model = CommonResponse.fromJson(response);
        if (model.status == 200 &&
            model.result != null &&
            model.result!.isNotEmpty) {
          usedStorageModel.value = UsedStorageModel.fromJson(model.result);
        } else {
          scaffoldKey.currentState?.showSnackBar(
              Utils.getSnackBar(1, model.message ?? Strings.success));
        }
        print(model.message);
      } on Exception catch (_) {
        scaffoldKey.currentState
            ?.showSnackBar(Utils.getSnackBar(3, response["message"]));
        print(response);
        rethrow;
      }
    } else {
      scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(
          3, Singleton.errorResponse?.message ?? Strings.somethingWentWrong));
    }
  }

  Future<void> getMyMediaDetailsList(String id) async {
    var url = "${ApiConfig.mediaDetailsListingURL}?media_id=$id";
    var response = await restAPI.getDataMethod(url, Singleton.header, null);
    if (response != null) {
      try {
        CommonResponse model = CommonResponse.fromJson(response);
        if (model.status == 200 &&
            model.result != null &&
            model.result!.isNotEmpty) {
          mediaDetailsModel.value = MediaDetailsModel.fromJson(
              model.result[0]); // having list returning with only 1 item
        } else {
          scaffoldKey.currentState?.showSnackBar(
              Utils.getSnackBar(1, model.message ?? Strings.success));
        }

        print(model.message);
        //   scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(2, model.message ?? Strings.success));
      } on Exception catch (_) {
        scaffoldKey.currentState
            ?.showSnackBar(Utils.getSnackBar(3, response["message"]));
        print(response);
        rethrow;
      }
    } else {
      scaffoldKey.currentState?.showSnackBar(SnackBar(
          content: Text(Singleton.errorResponse?.message ?? "Server Error")));
    }
  }

  String? fetchMediaListScreen() {
    var concatValue = "";

    if (mediaDetailsModel.value.screens?.isNotEmpty ?? false) {
      for (var element in mediaDetailsModel.value.screens!) {
        concatValue =
        "$concatValue, ${element?.toString()}";
      }
    } else {
      concatValue = "No broadcast";
    }
    return concatValue;
  }

  Future<void> deleteMyMedia(String id) async {
    AppLoader.showLoader();
    var url = "${ApiConfig.mediaDeleteURL}?media_id=$id";

    var response = await restAPI.getDataMethod(url, Singleton.header, null);
    if (response != null) {
      try {
        CommonResponse updateResponse = CommonResponse.fromJson(response);
        print(updateResponse.message);

        if (updateResponse.status == 200) {
          scaffoldKey.currentState?.showSnackBar(
              Utils.getSnackBar(2, updateResponse.message ?? Strings.success));
          AppLoader.hideLoader();
          Get.back();
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

  Future<void> updateMyMediaTitle(String screenID, String? prevValue) async {
    Map<String, dynamic> params = {};
    params["media_id"] = screenID;
    // params["name"] = title.isNotEmpty ? title : prevValue;
    AppLoader.showLoader();

    var response = await restAPI.postDataMethod(
        ApiConfig.mediaEditURL, Singleton.header, params);
    if (response != null) {
      try {
        CommonResponse updateResponse = CommonResponse.fromJson(response);
        print(updateResponse.message);

        if (updateResponse.status == 200) {
          scaffoldKey.currentState?.showSnackBar(
              Utils.getSnackBar(2, updateResponse.message ?? Strings.success));
          AppLoader.hideLoader();
          Get.back();
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

  Future<String?> selectVideoFromGallery() async {
    XFile? file = await ImagePicker().pickVideo(source: ImageSource.gallery);
    return file?.path;
  }

  Future<String?> selectImageFromGallery() async {
    XFile? file = await ImagePicker().pickMedia(imageQuality: 10);
    return file?.path;
  }

  Future<String?> uploadMediaToServer(String? path) async {
    if (path == null || path.isEmpty) return null;
    AppLoader.showLoader();

    var featureImgVideo = File(path);
    var documentFrontStream =
        https.ByteStream(DelegatingStream.typed(featureImgVideo.openRead()));
    var documentFrontLength = await featureImgVideo.length();
    String fileName = basename(featureImgVideo.path).toString();
    String extension = fileName.toString().split('.').last;

    List<https.MultipartFile> multipartFiles = [];
    multipartFiles.add(https.MultipartFile(
        'file', documentFrontStream, documentFrontLength,
        filename: fileName));

    Map<String, String> params = {
      'name': fileName.toString().split('.').first,
      'type': (extension == "png" || extension == "jpg" || extension == "jpeg")
          ? "Image"
          : "Video",
    };

    var response = await restAPI.postMultipartMethod(
        ApiConfig.mediaUploadURL, multipartFiles, params, true);
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
      scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(
          3, Singleton.errorResponse?.message ?? Strings.somethingWentWrong));
    }

    return null;
  }

/*  Future<void> getVideoThumbnail(String videoURL) async {
    selectedVideoThumbnailPath.value = await VideoThumbnail.thumbnailFile(
        video: "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
        thumbnailPath: (await getTemporaryDirectory()).path,
    imageFormat: ImageFormat.PNG,
    quality: 100,
    ) ?? "";
  }

  Future<void> generateThumbnail(String videoURL) async {
    final String? path = await VideoThumbnail.thumbnailFile(
      video: videoURL,
      thumbnailPath: (await getTemporaryDirectory()).path, /// path_provider
      imageFormat: ImageFormat.PNG,
      quality: 50,
    );
    thumbnailFile.value = File(path ?? "");
  }

  Future<Uint8List?> getVideoThumbnailUInt8List(String videoURL) async {
    return await VideoThumbnail.thumbnailData(
      video: videoURL,
      imageFormat: ImageFormat.JPEG,
      maxWidth: 200, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
      quality: 25,
    );
  }*/

  Future<void> getStoragePlanList() async {
    storagePlanList.clear();
    var url = "${ApiConfig.getStoragePlanList}?type=Storage-Plan";
    var response = await restAPI.getDataMethod(url, Singleton.header, null);
    if (response != null) {
      try {
        CommonResponse model = CommonResponse.fromJson(response);
        if (model.status == 200 &&
            model.result != null &&
            model.result!.isNotEmpty) {
          for (int index = 0; index < model.result.length; index++) {
            storagePlanList.add(Plan.fromJson(model.result[index]));
          }
        } else {
          scaffoldKey.currentState?.showSnackBar(
              Utils.getSnackBar(1, model.message ?? Strings.success));
        }
        print(model.message);
      } on Exception catch (_) {
        scaffoldKey.currentState
            ?.showSnackBar(Utils.getSnackBar(3, response["message"]));
        print(response);
        rethrow;
      }
    } else {
      scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(
          3, Singleton.errorResponse?.message ?? Strings.somethingWentWrong));
    }
  }

  // API integration for account profile update
  Future<void> addSubscriptionPlan() async {
    var params = {
      'plan_id': planID,
      'payment_status': paymentStatus,
      'payment_method': paymentMethod,
      'start_date': startDate,
      'expiry_date': expiryDate,
      'type': type,
      'total_price': totalPrice
    };
    AppLoader.showLoader();

    var response = await restAPI.postDataMethod(
        ApiConfig.addOrderURL, Singleton.header, params);
    if (response != null) {
      try {
        CommonResponse updateResponse = CommonResponse.fromJson(response);
        if (updateResponse.status == 200) {
          AppLoader.hideLoader();
          Get.to(const PaymentSuccessfulView());
        } else {
          AppLoader.hideLoader();
          /*scaffoldKey.currentState?.showSnackBar(
              Utils.getSnackBar(2, updateResponse.message ?? Strings.success));*/
        }

        print(updateResponse.message);
      } on Exception catch (_) {
        // TODO: Here show the error message that comes from server
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

  // API integration for storage order update
  Future<void> orderStoragePlan() async {
    //Step 1: Get payment from stripe
    StripeIntegrationsController stripeController =
        Get.put<StripeIntegrationsController>(StripeIntegrationsController());
    bool isSuccess = await stripeController.makePayment(
        amount: selectedStorage.value.fee.toString(), currency: "USD");

    //Step 2: If payment successful, proceed to order storage
    if (isSuccess) {
      var params = {
        'plan_id': selectedStorage.value.id,
        'payment_status': Strings.paid,
        'payment_method': Strings.stripe,
        'start_date': DateTime.now().toString(),
        'expiry_date': DateTime.now().add(const Duration(days: 30)).toString(),
        'type': Strings.storage,
        'total_price': selectedStorage.value.fee,
      };

      var response = await restAPI.postDataMethod(
          ApiConfig.placeStorageOrderURL, Singleton.header, params);
      if (response != null) {
        try {
          BuyStorageResponse storageResponse =
              BuyStorageResponse.fromJson(response);
          if (storageResponse.status == 200) {
            AppLoader.hideLoader();
            Get.to(const PaymentSuccessfulView());
          } else {
            AppLoader.hideLoader();
            scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(
                2, storageResponse.message ?? Strings.success));
            print(storageResponse.message);
          }
          //  scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(2, deliveryAddressResponse.message ?? Strings.success));
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
    } else {
      AppLoader.hideLoader();
      scaffoldKey.currentState?.showSnackBar(
          const SnackBar(content: Text('Payment Failed due to some error')));
    }
  }

  void increment() => count.value++;
}
