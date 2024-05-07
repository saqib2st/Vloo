import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;
import 'dart:ui';
import 'package:async/async.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' as https;
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:screen_recorder/screen_recorder.dart';
import 'package:vloo/app/data/configs/api_config.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/models/common/common_response.dart';
import 'package:vloo/app/data/models/imageVlooLibrary/imageCategory.dart';
import 'package:vloo/app/data/models/options/currency_model.dart';
import 'package:vloo/app/data/models/screens/ScreenCount.dart';
import 'package:vloo/app/data/models/screens/ScreenModel.dart';
import 'package:vloo/app/data/models/stockphoto/library_response.dart';
import 'package:vloo/app/data/models/stockphoto/vloo_library_images.dart';
import 'package:vloo/app/data/models/template/Create_template_response.dart';
import 'package:vloo/app/data/models/template/Template.dart';
import 'package:vloo/app/data/models/template/Template_count_response.dart';
import 'package:vloo/app/data/models/template/Template_response.dart';
import 'package:vloo/app/data/models/template/template_single_item_model.dart';
import 'package:vloo/app/data/models/user_subscription_plan/user_subscription_response.dart';
import 'package:vloo/app/data/utils/singleton.dart';
import 'package:vloo/app/data/utils/static_assets.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/utils/utils.dart';
import 'package:vloo/app/modules/addScreen/controllers/add_screen_controller.dart';
import 'package:vloo/app/modules/addScreen/views/add_screen.dart';
import 'package:vloo/app/modules/addScreen/views/choose_dongle_or_smart_tv.dart';
import 'package:vloo/app/modules/bottomNav/controllers/bottom_nav_controller.dart';
import 'package:vloo/app/modules/imageElement/controllers/image_element_controller.dart';
import 'package:vloo/app/modules/imageElement/views/image_element_view.dart';
import 'package:vloo/app/modules/imageElement/views/image_screen.dart';
import 'package:vloo/app/modules/layers/controllers/layers_controller.dart';
import 'package:vloo/app/modules/layers/views/template_layers_view.dart';
import 'package:vloo/app/modules/templates/views/Widget/app_loader.dart';
import 'package:vloo/app/modules/templates/views/blank_template.dart';
import 'package:vloo/app/modules/templates/views/drag_and_resize_landscape.dart';
import 'package:vloo/app/modules/templates/views/preview_template.dart';
import 'package:vloo/app/modules/templates/views/select_screen_to_broadcast_template.dart';
import 'package:vloo/app/modules/textEditing/controllers/title_editing_controller.dart';
import 'package:vloo/app/modules/textEditing/views/template_add_title_effect_view.dart';
import 'package:vloo/app/modules/textEditing/views/template_description_editing_view.dart';
import 'package:vloo/app/modules/textEditing/views/template_price_editing_view.dart';
import 'package:vloo/app/modules/textEditing/views/template_title_editing_view.dart';
import 'package:vloo/app/repository/rest_api.dart';
import 'package:vloo/app/routes/app_pages.dart';
import 'package:vloo/main.dart';

import '../views/drag_and_resize.dart';

class TemplatesController extends GetxController with GetTickerProviderStateMixin {
  RxInt savedTemplateCount = 0.obs;
  RxInt liveTemplateCount = 0.obs;
  RxInt totalTemplateCount = 0.obs;
  final count = 0.obs;
  // ignore: prefer_typing_uninitialized_variables
  var colorBox ;
  List<String> colorList = <String>[].obs;

  void addColor(String color) async {
    colorList.add(color.toString());
    await colorBox?.put('colors', colorList);
  }

  void setColorList()async {
    colorList = await colorBox?.get('colors') ?? [];
  }


  RxList<TemplateSingleItemModel> singleItemList = <TemplateSingleItemModel>[].obs;
  List<int> deletedElementList = [];
  List<TemplateSingleItemModel> tempSingleItemList = <TemplateSingleItemModel>[];
  List<List<TemplateSingleItemModel>> historySingleItemList = <List<TemplateSingleItemModel>>[];
  int historyIndexCount = 0;

  Template? editTemplateModel;

  Rx<CurrencyModel>? selectedCurrency = CurrencyModel(countryCode: '', countryName: '', currencySymbol: '').obs;
  Rx<String>? selectedCurrencyFormat = ''.obs;

  late ScrollController scrollController;
  int currentPageIndex = 1;
  int lastPageIndex = 1;
  RxDouble maxScale = 1.0.obs;
  TransformationController transformationController = TransformationController();

  ScreenRecorderController screenRecordController = ScreenRecorderController(
    pixelRatio: 1,
    skipFramesBetweenCaptures: 0,
  );

  bool get canExport => screenRecordController.exporter.hasFrames;
  RxBool recording = false.obs;
  RxBool exporting = false.obs;
  RxBool isEyeBlinkerEnabled = false.obs;

  RxBool showNewView = false.obs;
  RxBool isAddButtonEnabled = false.obs;
  final RxList<Template> templateList = <Template>[].obs;
  final RestAPI restAPI = Get.find<RestAPI>();
  final RefreshController refreshController = RefreshController(initialRefresh: false);
  final RefreshController refreshControllerSelectScreen = RefreshController(initialRefresh: false);
  final RefreshController refreshControllerMyProjects = RefreshController(initialRefresh: false);

  RxString title = Strings.dummyProjectName.obs; // By default
  RxInt elementTemplateID = 0.obs; // By default
  RxString elementImage = ''.obs;
  RxString? elementImageSticker = ''.obs;
  RxString elementTitle = ''.obs; // By default
  RxString elementDescription = ''.obs; // By default
  RxString elementPrice = '786'.obs; // By default
  RxString selectedPriceTheme = StaticAssets.none.obs; // By default
  RxString description = "".obs; // By default
  RxString currency = "\$".obs; // By default
  TextStyle titleStyle = const TextStyle();
  TextStyle descriptionStyle = const TextStyle();
  TextStyle currencyStyle = const TextStyle();
  TextStyle elementTitleStyle = const TextStyle();
  TextStyle elementDescriptionStyle = const TextStyle();
  TextStyle elementPriceStyle = const TextStyle();
  RxString backgroundImage = ''.obs;
  RxBool? isUnLock = true.obs;
  RxBool? isAppBarVisible = true.obs;
  RxBool isBottomSheetLocked = false.obs;
  int? selectedAlignment = 0;
  AnimatedTextWidgetModel? animatedModel;
  ImageModel? imageModel;

  Rx<List<LibraryImages>?> vlooLibraryPhotosList = Rx<List<LibraryImages>?>(null);
  Rx<List<ImageCategory>?> imageFolderCategoryList = Rx<List<ImageCategory>?>(null);
  late TabController libraryImagesTabController;
  late TabController libraryBackgroundTabController;
  int selectedIndex = 0;
  String searchString = "";
  int selectedFolderID = 0;

  RxBool isPickerColor = true.obs;
  Rx<Color> selectedTemplateBackGroundColor = Colors.transparent.obs;
  var pickerTemplateBackgroundColor = Rx<Color>(AppColor.primaryDarkColor);
  var currentTemplateBackgroundColor = Rx<Color>(Colors.transparent);
  RxDouble rangeValue = 1.0.obs;
  double fontOpacity = 1.0;
  double backgroundOpacity = 1.0;
  final GetStorage storage = Get.find<GetStorage>();

  List<Color> colorsList = [
    AppColor.transparent,
    AppColor.yellow,
    AppColor.white,
    AppColor.purple,
    AppColor.orange,
    AppColor.lightPurple,
    AppColor.darkRed,
    AppColor.lightGreen,
  ];

  final GlobalKey myThumbnailGlobalKey = GlobalKey(); // Key to access the widget's render object
  RxBool isScreenshotTaken = false.obs; // Observable to track screenshot status
  File? templateScreenShot;
  Rx<Uint8List> screenshotImage = Rx<Uint8List>(Uint8List(0)); // Observable for screenshot image data

  TextEditingController prizeController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  RxList<double> textSize = <double>[].obs;
  RxList<int> quarterTurns = <int>[].obs;
  final RxList<double> rotation = <double>[].obs;
  final RxList<Offset> startDragOffset = <Offset>[].obs;

  void changeTemplateBackgroundColor(Color color) {
    pickerTemplateBackgroundColor.value = color;
  }

  void saveTemplateBackGroundColor() {
    currentTemplateBackgroundColor.value = pickerTemplateBackgroundColor.value;
  }

  void screenLock() {
    if (isUnLock?.value == true) {
      deSelectAllExceptLastNEntries(1);
    } else {
      deSelectAllExceptLastNEntries(0);
    }
  }

  @override
  void onReady() {
    onUpdateHistoryStack();
    getVlooLibraryCategories(ImageCategoryType.BACKGROUND.name, currentPageIndex);
    super.onReady();
  }

  @override
  void onInit() async{
    super.onInit();
    libraryImagesTabController = TabController(length: 0, vsync: this);
    libraryBackgroundTabController = TabController(length: 0, vsync: this);
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent <= scrollController.offset) {
        if (currentPageIndex < lastPageIndex) {
          currentPageIndex = currentPageIndex + 1;
          getVlooLibraryImages(ImageCategoryType.BACKGROUND.name, imageFolderCategoryList.value?[selectedIndex].folderId.toString(), "", currentPageIndex);
        }
      }
    });

    colorBox = await Hive.openBox('colors');
    setColorList();
  }

  Future<void> ongoingBack(String orientation, String? comingFrom) async {
    Get.back();
    screenRecordController.exporter.clear();
    AppLoader.showLoader();
    if (await createCanvaTemplateAPI(orientation, editTemplateModel?.id ?? 0)) {
      var isSaved = await takeScreenshot();
      if (isSaved) {
        if (comingFrom == null) {
          resetCanvaTemplate(singleItemList[0].comingFrom?.contains('edit') == true ? 0 : 1);
        } else {
          resetCanvaTemplate(comingFrom.contains('edit') == true ? 0 : 1);
        }
        AppLoader.hideLoader();
        Get.back();
      } else {
        AppLoader.hideLoader();
        Get.back();
      }
    } else {
      AppLoader.hideLoader();
    }
  }

  Future<void> saveFrames(List<RawFrame>? frames) async {
    if (frames != null) {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      final framesDirectory = Directory('${appDocDir.path}/frames');
      if (!await framesDirectory.exists()) {
        await framesDirectory.create(recursive: true);
      }
      for (int i = 0; i < frames.length; i++) {
        final image = img.decodeImage(frames[i].image.buffer.asUint8List());
        if (image != null) {
          if (kDebugMode) {
            print('saving...');
          }
          String number = '';
          if (i < 10) {
            number = '00$i';
          } else if (i < 100 && i >= 10) {
            number = '0$i';
          } else {
            number = '$i';
          }
          await File('${framesDirectory.path}/00$number.jpeg').writeAsBytes(img.encodePng(image)).then((value) => print(value.path));
        }
      }
    }
  }

  onUpdateHistoryStack() {
    if (historySingleItemList.length >= 5) {
      // Handle only for 5 last changes
      historySingleItemList.removeAt(0);
    }
    deSelectAllExceptLastNEntries(1);

    tempSingleItemList = <TemplateSingleItemModel>[];
    tempSingleItemList.addAll(singleItemList);

    historySingleItemList.add(tempSingleItemList);
    historyIndexCount = historySingleItemList.length - 1;
    Get.forceAppUpdate();
  }

  onPressAddItem(String comingFrom, String orientation) async {
    String type = "";
    String value = "";
    String currency = "";
    TextStyle style = const TextStyle();

    if (comingFrom == Strings.addElementTitle) {
      type = "Title";
      value = elementTitle.value;
      style = elementTitleStyle;
    } else if (comingFrom == Strings.addElementDescription) {
      type = "Description";
      value = elementDescription.value;
      style = elementDescriptionStyle;
    } else if (comingFrom == Strings.addElementPrice) {
      type = "Price";
      value = elementPrice.value;
      style = elementPriceStyle;
      currency = elementPrice.value.replaceAll(RegExp(r"[0-9]+"), '');
      currency = currency.contains('.') ? currency.replaceAll('.', '') : currency;
    } else if (comingFrom == Strings.addElementImage) {
      type = "Image";
      value = elementImage.value;
    }

    singleItemList.add(
      TemplateSingleItemModel(
          id: null,
          type: type,
          value: value,
          //await uploadImageAPIToServer(elementImage.value) ?? "",
          // get name of File from server
          valueLocal: value,
          currency: currency,
          currencySymbol: selectedCurrency?.value.currencySymbol,
          currencyName: selectedCurrency?.value.countryName,
          currencyCountry: selectedCurrency?.value.countryCode,
          currencyFormat: selectedCurrencyFormat?.value,
          xaxis: 120.w,
          yaxis: 100.h,
          height: 100.h,
          width: 100.w,
          fontFamily: style.fontFamily,
          fontSize: 14,
          textColor: style.color?.value.toRadixString(16),
          rotation: "0",
          animation: comingFrom == Strings.addElementImage ? imageModel?.imageTransition.toString() : animatedModel?.textTransitionModel?.text,
          effect: comingFrom == Strings.addElementImage ? imageModel?.imageMove.toString() : animatedModel?.selectedEffect,
          label: "",
          theme: selectedPriceTheme.value,
          availability: elementImageSticker?.value,
          backgroundImage: "",
          backgroundColor: style.shadows?[0].color.value.toRadixString(16),
          isSelected: true,
          comingFrom: comingFrom,
          fontOpacity: fontOpacity,
          backgroundOpacity: backgroundOpacity,
          rect: (orientation == Strings.landscape) ? Rect.fromLTWH(50.w, 50.h, 160.w, 100.h) : Rect.fromLTWH(120.w, 250.h, 160.w, 100.h),
          selectedAlignment: selectedAlignment,
          availabilityStickerSize: 50,
          tabsIndex: 0),
    );

    initializeRotationList();
    deSelectAllExceptLastNEntries(1);
    onUpdateHistoryStack();
    if (comingFrom != Strings.editElementImage && comingFrom != Strings.addElementImage) {
      Get.back();
    }
  }

  onPressEditItem(String comingFrom, String orientation, int index) async {
    String type = "";
    String value = "";
    String currency = "";

    TextStyle style = const TextStyle();

    if (comingFrom == Strings.editElementTitle) {
      type = "Title";
      value = elementTitle.value;
      style = elementTitleStyle;
    } else if (comingFrom == Strings.editElementDescription) {
      type = "Description";
      value = elementDescription.value;
      style = elementDescriptionStyle;
    } else if (comingFrom == Strings.editElementPrice) {
      type = "Price";
      value = elementPrice.value;
      style = elementPriceStyle;
      currency = elementPrice.value.replaceAll(RegExp(r"[0-9]+"), '');
      currency = currency.contains('.') ? currency.replaceAll('.', '') : currency;
    } else if (comingFrom == Strings.editElementImage) {
      type = "Image";
      value = elementImage.value;
    }

    singleItemList[index] = TemplateSingleItemModel(
      id: singleItemList[index].id,
      type: type,
      value: value,
      //await uploadImageAPIToServer(elementImage.value) ?? "",
      valueLocal: value,
      currency: currency,
      currencySymbol: selectedCurrency?.value.currencySymbol,
      currencyName: selectedCurrency?.value.countryName,
      currencyCountry: selectedCurrency?.value.countryCode,
      currencyFormat: selectedCurrencyFormat?.value,
      xaxis: singleItemList[index].xaxis,
      yaxis: singleItemList[index].yaxis,
      height: singleItemList[index].height,
      width: singleItemList[index].width,
      fontFamily: style.fontFamily,
      fontSize: singleItemList[index].fontSize,
      textColor: style.color?.value.toRadixString(16),
      rotation: "0",
      fontOpacity: singleItemList[index].fontOpacity,
      backgroundOpacity: singleItemList[index].backgroundOpacity == 0.0 ? 0.0 : singleItemList[index].backgroundOpacity,
      animation: comingFrom == Strings.editElementImage ? imageModel?.imageTransition.toString() : animatedModel?.textTransitionModel?.text,
      effect: comingFrom == Strings.editElementImage ? imageModel?.imageMove.toString() : animatedModel?.selectedEffect,
      label: "",
      theme: singleItemList[index].theme != selectedPriceTheme.value ? selectedPriceTheme.value : singleItemList[index].theme,
      availability: elementImageSticker?.value,
      backgroundImage: "",
      backgroundColor: style.shadows?[0].color.value.toRadixString(16),
      isSelected: true,
      comingFrom: comingFrom,
      rect: (orientation == Strings.landscape)
          ? Rect.fromLTWH(singleItemList[index].xaxis != null ? singleItemList[index].xaxis!.toDouble() : 100.w, singleItemList[index].yaxis != null ? singleItemList[index].yaxis!.toDouble() : 100.h,
              160.w, 100.h)
          : Rect.fromLTWH(singleItemList[index].xaxis!.toDouble(), singleItemList[index].yaxis!.toDouble(), 160.w, 100.h),
      selectedAlignment: selectedAlignment,
      availabilityStickerSize: singleItemList[index].availabilityStickerSize,
      tabsIndex: singleItemList[index].tabsIndex,
    );

    initializeRotationList();
    deSelectAllExceptLastNEntries(1);
    onUpdateHistoryStack();
    if (comingFrom != Strings.editElementImage && comingFrom != Strings.addElementImage) {
      Get.back();
    }
  }

  initializeRotationList() {
    for (var _ in singleItemList) {
      rotation.add(0.0);
      startDragOffset.add(const Offset(0, 0));
    }
  }

  deSelectAllExceptLastNEntries(int number) {
    for (int index = 0; index < singleItemList.length - number; index++) {
      singleItemList[index].isSelected = false;
    }
    Get.forceAppUpdate();
  }
  RxList<ScreenModel> screenList = <ScreenModel>[].obs;
  RxInt connectedScreens = 0.obs;
  RxInt offlineScreens = 0.obs;
  RxInt withoutContentScreens = 0.obs;
  Rx<ScreenModel> selectedScreenModel = ScreenModel().obs;


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
        debugPrint(updateResponse.message);
        //scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(2, updateResponse.message ?? Strings.success));
      } on Exception catch (_) {
        AppLoader.hideLoader();
        scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(3, response["message"]));
        debugPrint(response);
        rethrow;
      }
    } else {
      AppLoader.hideLoader();
      scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(3, Singleton.errorResponse?.message ?? Strings.somethingWentWrong));
    }
  }

  Future<void> getMyScreensListing(String orientation) async {
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
          RxList<ScreenModel> list =<ScreenModel>[].obs;

          for (var element in screenList) {
            if(element.orientation?.split(' ').first.toLowerCase()==orientation){
              list.add(element);
            }
          }
            if (list.isNotEmpty) {
              screenList.clear();
              screenList = list;
            }
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

  Future<void> addMyScreenContent({num? screenId,int? templateId}) async {
    AppLoader.showLoader();

    Map<String, dynamic> params = {};
    params["template_id"] = templateId;
    params["screen_id"] = screenId;

    var response = await restAPI.postDataMethod(ApiConfig.addScreenContentURL, Singleton.header, params);
    if (response != null) {
      try {
        CommonResponse updateResponse = CommonResponse.fromJson(response);
        debugPrint(updateResponse.message);
        scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(2, updateResponse.message ?? Strings.success));
        AppLoader.hideLoader();

        if (updateResponse.status == 200) {
          Get.back();
        }
      } on Exception catch (_) {
        AppLoader.hideLoader();
        scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(3, response["message"]));
        debugPrint(response);
        rethrow;
      }
    } else {
      AppLoader.hideLoader();
      scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(3, Singleton.errorResponse?.message ?? Strings.somethingWentWrong));
    }
    //ZBotToast.loadingClose();
  }


  void onRefresh() async {
    if (Get.find<BottomNavController>().currentIndex.value == 0) {
      getPreDefinedTemplateList();
      refreshController.refreshCompleted();
    } else {
      getTemplateList();
      refreshControllerMyProjects.refreshCompleted();
    }
  }
  void onRefreshSelectScreen(String orientation) async {
    await getMyScreensListing(orientation);
    refreshControllerSelectScreen.refreshCompleted();
  }

  void toggleNewView() {
    showNewView.toggle();
  }

  bool showSnackBarError() {
    String errorMessage = "";

    if (templateList.isEmpty) {
      errorMessage = "No template found yet";
    }

    if (errorMessage.isNotEmpty) {
      scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text(errorMessage)));
    }
    return errorMessage.isNotEmpty;
  }

  Future<String?> selectImageFromGallery() async {
    XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 10);
    return file?.path;
  }

  Future<String?> selectImageFromCamera() async {
    XFile? file = await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 10);
    return file?.path;
  }

  // redirection to login
  void toLogin() {
    Get.offAllNamed(Routes.login);
  }

  Future<void> getTemplateList() async {
    templateList.clear();
    /* if (!showSnackBarError()) {*/
    AppLoader.showLoader();

    var response = await restAPI.getDataMethod(ApiConfig.getTemplateListingURL, Singleton.header, null);
    if (response != null) {
      try {
        TemplateResponse model = TemplateResponse.fromJson(response);
        if (model.status == 200 && model.result != null && model.result!.isNotEmpty) {
          templateList.addAll(model.result as Iterable<Template>);
          templateList.refresh();
        } else {}
        AppLoader.hideLoader();
        if (kDebugMode) {
          print(model.message);
        }
      } on Exception catch (_) {
        AppLoader.hideLoader();
        if (kDebugMode) {
          print(response);
        }
        rethrow;
      }
    } else {
      AppLoader.hideLoader();
    }
  }

  Future<void> templateListUpdate() async {
    templateList.clear();
    var response = await restAPI.getDataMethod(ApiConfig.getTemplateListingURL, Singleton.header, null);
    if (response != null) {
      try {
        TemplateResponse model = TemplateResponse.fromJson(response);
        if (model.status == 200 ) {
          templateList.addAll(model.result as Iterable<Template>);
          templateList.addAll(fetchFilteredList(Orientation.portrait.name) as Iterable<Template>);
          templateList.refresh();
        } else {}
        if (kDebugMode) {
          debugPrint(model.message);
        }
      } on Exception catch (_) {
        if (kDebugMode) {
          debugPrint(response);
        }
        rethrow;
      }
    } else {}
  }

  void openDuplicateProject(int index) async {
    duplicateTemplate(fetchFilteredList("Portrait")?[index].id.toString() ?? '0', predefine: 0);
    await Future.delayed(const Duration(seconds: 1));
    AppLoader.showLoader();
    AppLoader.hideLoader();

    // Adjust the delay as needed
    await templateListUpdate();
    final List<Template>? filteredList = fetchFilteredList("Portrait");
    if (filteredList != null && filteredList.isNotEmpty) {
      toCreateTemplateView(OrientationType.Portrait.name, Strings.editTemplate, filteredList[0]);
    }
    Get.find<BottomNavController>().currentIndex.value = 1;
  }

  void openDuplicateProjectLandscape(int index) async {
    duplicateTemplate(fetchFilteredList("Landscape")?[index].id.toString() ?? '0', predefine: 0);
    await Future.delayed(const Duration(seconds: 1));
    AppLoader.showLoader();
    AppLoader.hideLoader();

    // Adjust the delay as needed
    await templateListUpdate();
    final List<Template>? filteredList = fetchFilteredList("Landscape");
    if (filteredList != null && filteredList.isNotEmpty) {
      toCreateTemplateViewLandScape(OrientationType.Landscape.name, Strings.editTemplate, filteredList[0]);
    }
    Get.find<BottomNavController>().currentIndex.value = 1;
  }

  Future<void> getPreDefinedTemplateList() async {
    templateList.clear();
    /* if (!showSnackBarError()) {*/
    AppLoader.showLoader();

    var response = await restAPI.getDataMethod(ApiConfig.preDefinedTemplate, Singleton.header, null);
    if (response != null) {
      try {
        TemplateResponse model = TemplateResponse.fromJson(response);
        if (model.status == 200 && model.result != null && model.result!.isNotEmpty) {
          templateList.addAll(model.result as Iterable<Template>);
          templateList.refresh();
        } else {}
        AppLoader.hideLoader();
        if (kDebugMode) {
          print(model.message);
        }
      } on Exception catch (_) {
        AppLoader.hideLoader();
        if (kDebugMode) {
          print(response);
        }
        rethrow;
      }
    } else {
      AppLoader.hideLoader();
    }
  }

  // API integration for User Subscription Plan
  Future<void> getUserSubscriptionPlan(String orientation) async {
    /* if (!showSnackBarError()) {*/
    AppLoader.showLoader();

    var response = await restAPI.getDataMethod(ApiConfig.getUserSubscriptionPlanURL, Singleton.header, null);
    if (response != null) {
      try {
        UserSubscriptionPlanResponse model = UserSubscriptionPlanResponse.fromJson(response);
        if (model.status == 200 && model.result != null) {
          Singleton.screenPlan = model.result?.screenPlan;
          Singleton.storagePlan = model.result?.storagePlan;
          Singleton.donglePlan = model.result?.donglePlan;
          AppLoader.hideLoader();
          Get.put(AddScreenController());
          Get.put(AddScreenController());
          await getMyScreensCount();
          if (connectedScreens.value == 0 && Singleton.screenPlan?.id == null) {
            // case 1 : the user adds a screen for the 1st time. He has no subscription plan -> Go to add a screen flow.
            Get.to(() => const AddScreenView());
          } else {
              // case 3 : the user added a screen but has not yet configured the Vloo TV Dongle -> Go to vloo dongle configuration screen
            if (connectedScreens.value != 0 && Singleton.donglePlan?.id == null) {
              Get.to(() => const ChooseDongleOrSmartTv());
            } else {
              // case 2 : the User already has a screen so He already had a subscription plan -> go to choose screenView
              await getMyScreensListing(orientation);
              Get.to(()=> SelectScreenToBroadCast(orientations: orientation,));
            }}}


        if (kDebugMode) {
          print(model.message);
        }
      } on Exception catch (_) {
        AppLoader.hideLoader();
        if (kDebugMode) {
          print(response);
        }
        rethrow;
      }
    } else {
      AppLoader.hideLoader();
    }
  }

  List<Template>? fetchFilteredList(String orientation) {
    if (templateList.isNotEmpty) {
      //var list = templateList.reversed.where((p) => p.orientation == orientation);
      var list = templateList.where((p) => p.orientation == orientation);
      return list.toList();
    }
    return null;
  }

  Future<void> toBlankTemplate() async {
    await Get.to(() => const BlankTemplate());
    onRefresh();
  }

  Future<void> toTemplateLayers(BuildContext context) async {
    Get.put(LayersController(itemsListData: singleItemList));
    Navigator.of(context).push(_createRoute());
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const TemplateLayersView(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Future<void> toPreviewTemplates(double ratio, String comingFrom ,{int? noOfClose}) async {
    await Get.to(() => PreviewTemplateView(aspectRatio: ratio, comingFrom: comingFrom,noOfClose : noOfClose ?? 1));
    Get.forceAppUpdate();
  }

  Future<void> toImageElementView(String orientation, String comingFrom, int index) async {
    Get.put<ImageElementController>(ImageElementController());
    imageModel = await Get.to(() => ImageElementView(comingFrom: 'add'));
    elementImage.value = imageModel?.image ?? '';
    elementImageSticker?.value = imageModel?.sticker ?? '';
    selectedPriceTheme.value = StaticAssets.none;
    if (elementImage.value.isNotEmpty) {
      if (comingFrom == Strings.addElementImage) {
        onPressAddItem(Strings.addElementImage, orientation);
      } else {
        onPressEditItem(Strings.editElementImage, orientation, index);
      }
      elementImage.refresh();
    }
    showNewView.value = false;
    isAppBarVisible?.value = true;
  }

  Future<void> toEditImageElementView(String orientation, String comingFrom, int index) async {
    Get.put<ImageElementController>(ImageElementController());
    imageModel = await Get.to(() => const ImageScreen(), arguments: singleItemList[index]);
    elementImage.value = imageModel?.image ?? '';
    elementImageSticker?.value = imageModel?.sticker ?? '';
    selectedPriceTheme.value = StaticAssets.none;
    if (elementImage.value.isNotEmpty) {
      if (comingFrom == Strings.addElementImage) {
        onPressAddItem(Strings.addElementImage, orientation);
      } else {
        onPressEditItem(Strings.editElementImage, orientation, index);
      }
      elementImage.refresh();
    }
    showNewView.value = false;
    isAppBarVisible?.value = true;
  }

  void toAddTitleElementView(String orientation, String comingFrom, int? index) {
    Singleton.comingFrom = comingFrom;
    showNewView.value = false;
    isAppBarVisible?.value = true;
    selectedPriceTheme.value = StaticAssets.none;
    Get.put<TitleEditingController>(TitleEditingController());
    Get.to(
        () => TemplateAddTitleEffectView(
              animatedModel: (val) {
                animatedModel = val;
              },
              comingFrom: comingFrom,
              orientation: orientation,
              index: index,
            ),
        arguments: index != null && singleItemList.isBlank == false ? [singleItemList[index]] : [TemplateSingleItemModel()]);
  }

  void toTitleElementView(String orientation, String comingFrom, int? index) {
    Singleton.comingFrom = comingFrom;
    showNewView.value = false;
    isAppBarVisible?.value = true;
    selectedPriceTheme.value = StaticAssets.none;
    Get.put<TitleEditingController>(TitleEditingController());
    Get.to(
            () => TemplateTitleEditingView(
                  fontOpacity: (val) {
                    fontOpacity = val;
                  },
                  backgroundOpacity: (val) {
                    backgroundOpacity = val;
                  },
                  isAnimEnabled: false,
                  text: (val) {
                    elementTitle.value = val;
                  },
                  textStyle: (val) {
                    elementTitleStyle = val;
                  },
                  selectedAlignment: (val) {
                    selectedAlignment = val;
                  },
                  animatedModel: (val) {
                    animatedModel = val;
                  },
                  comingFrom: comingFrom,
                  orientation: orientation,
                  index: index,
                ),
            arguments: index != null && singleItemList.isBlank == false ? [singleItemList[index]] : [TemplateSingleItemModel()])
        ?.then((value) => {});
  }

  void toPriceElementView(String orientation, String comingFrom, int? index) {
    Singleton.comingFrom = comingFrom;
    showNewView.value = false;
    isAppBarVisible?.value = true;

    Get.put<TitleEditingController>(TitleEditingController());
    Get.to(
            () => TemplatePriceEditingView(
                  fontOpacity: (val) {
                    fontOpacity = val;
                  },
                  backgroundOpacity: (val) {
                    backgroundOpacity = val;
                  },
                  text: (val) {
                    elementPrice.value = val;
                  },
                  textStyle: (val) {
                    elementPriceStyle = val;
                  },
                  selectedAlignment: (val) {
                    selectedAlignment = val;
                  },
                  animatedModel: (val) {
                    animatedModel = val;
                  },
                  selectedPriceTheme: (val) => {selectedPriceTheme.value = val},
                  selectedCurrencyFormat: (val) {
                    selectedCurrencyFormat?.value = val;
                  },
                  selectedCurrency: (val) {
                    selectedCurrency?.value = val;
                  },
                  comingFrom: comingFrom,
                  orientation: orientation,
                  index: index,
                ),
            arguments: index != null && singleItemList.isBlank == false ? [singleItemList[index]] : [TemplateSingleItemModel()])
        ?.then((value) => {});
  }

  void toDescriptionElementView(String orientation, String comingFrom, int? index) {
    Singleton.comingFrom = comingFrom;
    showNewView.value = false;
    isAppBarVisible?.value = true;
    selectedPriceTheme.value = StaticAssets.none;

    Get.put<TitleEditingController>(TitleEditingController());
    Get.to(
            () => TemplateDescriptionEditingView(
                  fontOpacity: (val) {
                    fontOpacity = val;
                  },
                  backgroundOpacity: (val) {
                    backgroundOpacity = val;
                  },
                  text: (val) {
                    elementDescription.value = val;
                  },
                  textStyle: (val) {
                    elementDescriptionStyle = val;
                  },
                  selectedAlignment: (val) {
                    selectedAlignment = val;
                  },
                  animatedModel: (val) {
                    animatedModel = val;
                  },
                  comingFrom: comingFrom,
                  orientation: orientation,
                  index: index,
                ),
            arguments: index != null && singleItemList.isBlank == false ? [singleItemList[index]] : [TemplateSingleItemModel()])
        ?.then((value) => {});
  }

  Future<void> toCreateTemplateView(String value, String comingFrom, Template? template) async {
    Singleton.orientation.value = value;

    historySingleItemList.clear();
    historyIndexCount = 0;
    if (comingFrom == Strings.editTemplate) {
      if (template == null) {
        editTemplateModel = null;
      } else {
        editTemplateModel = template;
        backgroundImage.value = editTemplateModel?.backgroundImage ?? "";
        currentTemplateBackgroundColor.value = Utils.fetchColorFromStringColor(editTemplateModel?.backgroundColor) ?? "";

        if (editTemplateModel!.elements != null) {
          singleItemList.value = editTemplateModel!.elements!;
        }
      }
      initializeRotationList();

      deSelectAllExceptLastNEntries(1);

      for (var model in singleItemList) {
        if (model.type == 'Image') {
          model.comingFrom = Strings.editElementImage;
        } else {
          if (model.type == 'Title') {
            model.comingFrom = Strings.editElementTitle;
          } else if (model.type == 'Description') {
            model.comingFrom = Strings.editElementDescription;
          } else {
            model.comingFrom = Strings.editElementPrice;
          }
        }

        model.rect = Rect.fromLTWH(model.xaxis?.toDouble() ?? 110, model.yaxis?.toDouble() ?? 180, model.width ?? 100, model.height ?? 100);
        if(MediaQuery.of(scaffoldKey.currentContext!).size.width>428) {
          for (var item in singleItemList) {
            item.rect = Rect.fromLTWH(item.xaxis! * 1.2.w, item.yaxis! * 1.1.h, item.width! *0.8.w, item.height! * 1.h);
            item.width = item.width! * 1.w;
            item.height = item.height! * 1.h;
          }
        }else if(MediaQuery.of(scaffoldKey.currentContext!).size.width<380){
          for (var item in singleItemList) {
            item.rect = Rect.fromLTWH(item.xaxis! * 1.2.w, item.yaxis! * 1.1.h, item.width! *1.w, item.height! * 1.1.w);
          }
        }
        model.isSelected = false;
        model.fontSize = (model.fontSize == 0.0) ? 14 : model.fontSize;
        model.valueLocal = (model.value == null || model.value?.isEmpty == true) ? '' : model.value;
      }
    } else {
      editTemplateModel = null;
      singleItemList.clear();
    }
    onUpdateHistoryStack();
    await Get.to(() => DragAndResizeView(comingFrom: comingFrom));
    if (Get.find<BottomNavController>().currentIndex.value == 0) {
      getPreDefinedTemplateList();
    } else {
      getTemplateList();
    }
  }

  Future<void> toCreateTemplateViewLandScape(String value, String comingFrom, Template? template) async {
    Singleton.orientation.value = value;
    historySingleItemList.clear();
    historyIndexCount = 0;

    if (comingFrom == Strings.editTemplate) {
      if (template == null) {
        editTemplateModel = null;
      } else {
        editTemplateModel = template;
        backgroundImage.value = editTemplateModel?.backgroundImage ?? "";
        currentTemplateBackgroundColor.value = Utils.fetchColorFromStringColor(editTemplateModel?.backgroundColor) ?? "";
        if (editTemplateModel!.elements != null) {
          singleItemList.value = editTemplateModel!.elements!;
        }
      }
      initializeRotationList();

      deSelectAllExceptLastNEntries(1);

      for (var model in singleItemList) {
        if (model.type == 'Image') {
          model.comingFrom = Strings.editElementImage;
        } else {
          if (model.type == 'Title') {
            model.comingFrom = Strings.editElementTitle;
          } else if (model.type == 'Description') {
            model.comingFrom = Strings.editElementDescription;
          } else {
            model.comingFrom = Strings.editElementPrice;
          }
        }

        model.rect = Rect.fromLTWH(model.xaxis?.toDouble() ?? 110, model.yaxis?.toDouble() ?? 180, model.width ?? 50,model.height ?? 50);
        if(MediaQuery.of(scaffoldKey.currentContext!).size.width>428) {
          for (var item in singleItemList) {
            item.rect = Rect.fromLTWH(item.xaxis! * 1.2.w, item.yaxis! * 1.1.h, item.width! *0.8.w, item.height! * 1.h);
            item.width = item.width! * 1.w;
            item.height = item.height! * 1.h;
          }
        }else if(MediaQuery.of(scaffoldKey.currentContext!).size.width<380){
          for (var item in singleItemList) {
            item.rect = Rect.fromLTWH(item.xaxis! * 1.1.w, item.yaxis! * 1.1.h, item.width! *1.w, item.height! * 1.1.w);
          }
        }
        model.isSelected = false;
        model.fontSize = (model.fontSize == 0.0) ? 14 : model.fontSize;
        model.valueLocal = (model.value == null || model.value?.isEmpty == true) ? '' : model.value;
      }
    } else {
      editTemplateModel = null;
      singleItemList.clear();
    }
    onUpdateHistoryStack();
    await Get.to(() => DragAndResizeViewLandScape(comingFrom: comingFrom));
    if (Get.find<BottomNavController>().currentIndex.value == 0) {
      getPreDefinedTemplateList();
    } else {
      getTemplateList();
    }
  }

  ////////////////////////// Duplicate Template Item //////////////////////////////

  Future<void> duplicateTemplate(String id, {int? predefine}) async {
    Map<String, dynamic> params = {
      "template_id": id,
      "predefined": predefine ?? (await storage.read(Strings.userEmail) == 'templateadmin@vloo.com' || Get.find<BottomNavController>().currentIndex.value == 0 ? 1 : 0),
    };
    var response = await restAPI.postDataMethod(ApiConfig.duplicateTemplateURL, Singleton.header, params);

    if (response != null) {
      try {
        CommonResponse updateResponse = CommonResponse.fromJson(response);
        print(updateResponse.message);

        if (updateResponse.status == 200) {
          if(Get.find<BottomNavController>().currentIndex.value==0 && await storage.read(Strings.userEmail) == 'templateadmin@vloo.com' )scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(2, updateResponse.message ?? Strings.success));
        } else {
          AppLoader.hideLoader();
          scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(1, updateResponse.message ?? Strings.success));
        }
      } on Exception catch (_) {
        scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(3, response["message"]));
        print(response);
        rethrow;
      }
    } else {
      scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(3, Singleton.errorResponse?.message ?? Strings.somethingWentWrong));
    }
  }

  ////////////////////////// Create Template Screen ///////////////////////////////

  Future<bool> createCanvaTemplateAPI(String orientation, int templateId,{bool? resetTemplate}) async {
    //Step 1: make raw json request of all params

    Map<String, dynamic> params = {
      "title": title.value,
      "currency": currency.value,
      "description": description.value,
      "orientation": orientation,
      "is_locked": isUnLock?.value == true ? "Yes" : "No",
      "is_predefined": await storage.read(Strings.userEmail) == 'templateadmin@vloo.com' ? 1 : 0,
      "background": backgroundImage.isEmpty ? "0x${currentTemplateBackgroundColor.value.value.toRadixString(16)}" : "",
      "background_image": backgroundImage.isEmpty ? "" : /*await uploadImageAPIToServer(backgroundImage.value) ??*/ backgroundImage.value,
      "elements": singleItemList.map((i) => i.toJson()).toList(),
      "deleted_element": deletedElementList.map((i) => i).toList()
    };
    //in case of edit template
    if (templateId > 0) {
      params["template_id"] = templateId;
    }
    var body = json.encode(params);
    print(body);
    // Step 2: add all request json params to call
    var response = await restAPI.postRawDataMethod(ApiConfig.createCanvaTemplateURL, Singleton.header, body);

    // Step 3 : Just handle response
    if (response != null) {
      try {
        CreateTemplateResponse templateResponse = CreateTemplateResponse.fromJson(response);
        if (templateResponse.status == 200) {
          if (templateResponse.result != null) {
            if (resetTemplate ?? true) {
              resetCanvaTemplate(1);
            }
            elementTemplateID.value = templateResponse.result?.id ?? 0;
          }

          if (kDebugMode) {
            print(templateResponse.message);
          }
          scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(2, templateResponse.message ?? Strings.success));

          return true;
          //Todo: Activate button next and handle
        }
      } on Exception catch (_) {
        // TODO: Here show the error message that comes from server

        scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(3, response["message"]));
        if (kDebugMode) {
          print(response);
        }
        rethrow;
      }
    } else {
      scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(3, Singleton.errorResponse?.message ?? Strings.somethingWentWrong));
    }

    return false;
  }

  Future<bool> takeScreenshot() async {
    try {
      if (myThumbnailGlobalKey.currentContext == null) return false;

      RenderRepaintBoundary boundary = myThumbnailGlobalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage();

      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      screenshotImage.value = byteData!.buffer.asUint8List(); // Update the screenshot image data
      final buffer = screenshotImage.value.buffer;

      Directory? storageDir = await getTemporaryDirectory();
      String tempFilePath = '${storageDir.path}/screenshot.png';

      // Create a file in the storage directory
      templateScreenShot = await File(tempFilePath).writeAsBytes(buffer.asUint8List(screenshotImage.value.offsetInBytes, screenshotImage.value.lengthInBytes));
      isScreenshotTaken.value = true; // Update the observable value

      var isSaved = await updateTemplateFeatureImageAPI();
      if (isSaved) {
        return true;
      }
    } on Exception {
      scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(3, Strings.somethingWentWrong));
      rethrow;
    }
    return false;
  }

  Future<bool> updateTemplateFeatureImageAPI() async {
    if (elementTemplateID.value == 0 || isScreenshotTaken.value == false) {
      scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(1, Strings.enterTitleDescriptionFirst));
    } else {
      var documentFrontStream = templateScreenShot != null ? https.ByteStream(DelegatingStream.typed(templateScreenShot!.openRead())) : null;

      var documentFrontLength = templateScreenShot != null ? await templateScreenShot!.length() : null;

      List<https.MultipartFile> multipartFiles = [];
      multipartFiles.add(https.MultipartFile('feature_img', documentFrontStream!, documentFrontLength!, filename: basename(templateScreenShot!.path)));

      var params = {
        'template_id': elementTemplateID.value.toString(),
      };

      var response = await restAPI.postMultipartMethod(ApiConfig.updateTemplateFeatureImageURL, multipartFiles, params, false);
      if (response != null) {
        try {
          if (kDebugMode) {
            print(response);
          }

          return true;
        } on Exception catch (_) {
          scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(3, response));
          if (kDebugMode) {
            print(response);
          }
          rethrow;
        }
      } else {
        scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(3, Singleton.errorResponse?.message ?? Strings.somethingWentWrong));
      }
    }

    return false;
  }

  Future<String?> uploadImageAPIToServer(String? path) async {
    if (path == null || path.isEmpty) return null;

    var featureImg = File(path);
    var documentFrontStream = https.ByteStream(DelegatingStream.typed(featureImg.openRead()));
    var documentFrontLength = await featureImg.length();

    List<https.MultipartFile> multipartFiles = [];
    multipartFiles.add(https.MultipartFile('image', documentFrontStream, documentFrontLength, filename: basename(featureImg.path)));

    Map<String, String> params = {};

    var response = await restAPI.postMultipartMethod(ApiConfig.uploadTemplateMediaURL, multipartFiles, params, true);
    if (response != null && response.isNotEmpty) {
      try {
        return response;
      } on Exception catch (_) {
        scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(3, response));
        if (kDebugMode) {
          print(response);
        }
        rethrow;
      }
    } else {
      scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(3, Singleton.errorResponse?.message ?? Strings.somethingWentWrong));
    }

    return null;
  }

  Future<void> getProjectsListCount() async {
    /* if (!showSnackBarError()) {*/

    AppLoader.showLoader();
    var response = await restAPI.getDataMethod(ApiConfig.countTemplateURL, Singleton.header, null);
    if (response != null) {
      try {
        TemplateCountResponse model = TemplateCountResponse.fromJson(response);
        if (model.status == 200 && model.result != null) {
          AppLoader.hideLoader();
          totalTemplateCount.value = model.result?.totalTemplates ?? 0;
          liveTemplateCount.value = model.result?.liveTemplate ?? 0;
          savedTemplateCount.value = model.result?.savedTemplates ?? 0;
        } else {
          AppLoader.hideLoader();
          // scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(2, model.message ?? Strings.success));
        }

        print(model.message);
      } on Exception catch (_) {
        // TODO: Here show the error message that comes from server
        AppLoader.hideLoader();

        // scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(3, response["message"]));
        print(response);
        rethrow;
      }
    } else {
      AppLoader.hideLoader();
      // scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text(Singleton.errorResponse?.message ?? "Server Error")));
    }
  }

  Future<String?> uploadMediaToServer(File? featureImgVideo) async {
    if (featureImgVideo == null) return null;
    AppLoader.showLoader();

    var documentFrontStream = https.ByteStream(DelegatingStream.typed(featureImgVideo.openRead()));
    var documentFrontLength = await featureImgVideo.length();
    String fileName = basename(featureImgVideo.path).toString();
    String extension = fileName.toString().split('.').last;

    List<https.MultipartFile> multipartFiles = [];
    multipartFiles.add(https.MultipartFile('file', documentFrontStream, documentFrontLength, filename: fileName));

    Map<String, String> params = {
      'name': fileName.toString().split('.').first,
      'type': (extension == "png" || extension == "jpg" || extension == "jpeg" || extension == "gif") ? "Image" : "Video",
    };

    var response = await restAPI.postMultipartMethod(ApiConfig.mediaUploadURL, multipartFiles, params, true);
    if (response != null && response.isNotEmpty) {
      try {
        AppLoader.hideLoader();

        return response;
      } on Exception catch (e) {
        AppLoader.hideLoader();
        scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(3, response));
        if (kDebugMode) {
          print(e);
        }
        rethrow;
      }
    } else {
      AppLoader.hideLoader();
      scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(3, Singleton.errorResponse?.message ?? Strings.somethingWentWrong));
    }

    return null;
  }

  void resetEmptyCanvaTemplate(){
    maxScale.value = 1;
    isUnLock?.value = true;
    backgroundImage.value = '';
    currentTemplateBackgroundColor.value = Colors.transparent;
  }

  void resetCanvaTemplate(int clearList) {
    maxScale.value = 1;
    //  if (clearList == 1) {
    editTemplateModel = null;
    singleItemList.clear();
    //}
    backgroundImage.value = '';
    currentTemplateBackgroundColor.value = Colors.transparent;
    isUnLock?.value = true;

    historyIndexCount = 0;
    historySingleItemList.clear();

    showNewView = false.obs;
    isAddButtonEnabled = false.obs;

    elementTemplateID = 0.obs; // By default
    elementImage = ''.obs;
    selectedPriceTheme = ''.obs;
    elementTitle = ''.obs; // By default
    elementDescription = ''.obs; // By default
    elementPrice = ''.obs; // By default

    elementTitleStyle = const TextStyle();
    elementDescriptionStyle = const TextStyle();
    elementPriceStyle = const TextStyle();
    prizeController = TextEditingController();
    titleController = TextEditingController();

    isScreenshotTaken = false.obs; // Observable to track screenshot status
    templateScreenShot?.delete();
    screenshotImage = Rx<Uint8List>(Uint8List(0)); // Observable for screenshot image data
  }

  // get vloo library backgrounds
  Future<void> getVlooLibraryCategories(String? type, int page) async {
    var url = "${ApiConfig.vlooLibraryCategories}?type=$type";

    var response = await restAPI.getDataMethod(url, Singleton.header, null);
    if (response != null) {
      try {
        CommonResponse model = CommonResponse.fromJson(response);

        List<ImageCategory> list = <ImageCategory>[];
        for (int index = 0; index < model.result.length; index++) {
          list.add(ImageCategory.fromJson(model.result[index]));
        }
        imageFolderCategoryList.value = list;

        if (imageFolderCategoryList.value?.isNotEmpty == true) {
          // when folders are shown handling switch case
          if (type == ImageCategoryType.IMAGE.name) {
            libraryImagesTabController = TabController(length: imageFolderCategoryList.value?.length ?? 0, vsync: this);
            libraryImagesTabController.addListener(() {
              vlooLibraryPhotosList.value?.clear();
              selectedIndex = libraryImagesTabController.index;
              selectedFolderID = imageFolderCategoryList.value?[selectedIndex].folderId?.toInt() ?? 0;
              getVlooLibraryImages(type, selectedFolderID.toString(), "", page);
            });
          } else {
            libraryBackgroundTabController = TabController(length: imageFolderCategoryList.value?.length ?? 0, vsync: this);
            libraryBackgroundTabController.addListener(() {
              vlooLibraryPhotosList.value?.clear();
              selectedIndex = libraryBackgroundTabController.index;
              selectedFolderID = imageFolderCategoryList.value?[selectedIndex].folderId?.toInt() ?? 0;
              getVlooLibraryImages(type, selectedFolderID.toString(), "", page);
            });
          }

          getVlooLibraryImages(type, imageFolderCategoryList.value?[0].folderId.toString(), "", page); // For first time call
        }

        if (kDebugMode) {
          print(model.message);
        }
        //scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(2, model.message ?? Strings.success));
      } on Exception catch (_) {
        scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(3, response["message"]));
        if (kDebugMode) {
          print(response);
        }
        rethrow;
      }
    } else {
      scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text(Singleton.errorResponse?.message ?? "Server Error")));
    }
  }

  Future<void> getVlooLibraryImages(String? type, String? folderID, String? searchString, int page) async {
    AppLoader.showLoader();
    var url = "";

    if (folderID != null && folderID.isNotEmpty) {
      url = "${ApiConfig.vlooLibraryGetImages}?folderId=$folderID&type=$type&page=$page";
    } else if (searchString != null && searchString.isNotEmpty) {
      url = "${ApiConfig.vlooLibraryGetImages}?search=$searchString&type=$type&page=$page";
    } else {
      url = "${ApiConfig.vlooLibraryGetImages}?type=$type&page=$page";
    }

    var response = await restAPI.getDataMethod(url, Singleton.header, null);
    if (response != null) {
      try {
        CommonResponse model = CommonResponse.fromJson(response);
        LibraryResponse modelChild = LibraryResponse.fromJson(model.result);
        if (modelChild.data == null) return;

        if (page == 1) {
          if (vlooLibraryPhotosList.value != null) {
            vlooLibraryPhotosList.value!.clear;
          }
          vlooLibraryPhotosList.value = modelChild.data;
        } else {
          vlooLibraryPhotosList.value?.addAll(modelChild.data!);
        }

        currentPageIndex = modelChild.currentPage?.toInt() ?? 0;
        lastPageIndex = modelChild.lastPage?.toInt() ?? 0;
        vlooLibraryPhotosList.refresh();

        if (kDebugMode) {
          print(model.message);
        }
        AppLoader.hideLoader();
      } on Exception catch (e) {
        // TODO: Here show the error message that comes from server
        if (kDebugMode) {
          print(e);
        }
        scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(3, response["message"]));
        AppLoader.hideLoader();
        if (kDebugMode) {
          print(response);
        }
        rethrow;
      }
    } else {
      AppLoader.hideLoader();
      scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text(Singleton.errorResponse?.message ?? "Server Error")));
    }
  }

  Future<String?> downloadImage(String? url, int? index) async {
    AppLoader.showLoader();

    try {
      var response = await http.get(Uri.parse(url ?? ""));
      // Directory documentDirectory = await getApplicationDocumentsDirectory();
      // String path = '${documentDirectory.path}${index ?? 0}stock_photo.png';

      String randomName = '${index ?? 0}stock_photo.png';
      String savePath = "";
      if (Platform.isIOS) {
        final directory = await getApplicationDocumentsDirectory();
        savePath = '${directory.path}/$randomName';
      } else if (Platform.isAndroid) {
        savePath = '/storage/emulated/0/Download/$randomName';
      }

      if (await File(savePath).exists()) {
        await File(savePath).delete();
      }

      File file = File(savePath);
      file.writeAsBytesSync(response.bodyBytes);
      AppLoader.hideLoader();

      return file.path;
    } catch (e) {
      AppLoader.hideLoader();
      e.printError();
    }
    return null;
  }

  @override
  void dispose() {
    screenRecordController.stop();
    super.dispose();
  }
}

enum OrientationType {
  Landscape,
  Portrait,
}
