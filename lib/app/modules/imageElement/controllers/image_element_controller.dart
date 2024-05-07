import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:async/async.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' as https;
import 'package:image/image.dart' as img;
// ignore: depend_on_referenced_packages
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:remove_background/crop_widget.dart';
import 'package:vloo/app/data/configs/api_config.dart';
import 'package:vloo/app/data/models/common/common_response.dart';
import 'package:vloo/app/data/models/imageVlooLibrary/imageCategory.dart';
import 'package:vloo/app/data/models/stockphoto/Stock_photo_response.dart';
import 'package:vloo/app/data/models/stockphoto/library_response.dart';
import 'package:vloo/app/data/models/stockphoto/stockPhotos.dart';
import 'package:vloo/app/data/models/stockphoto/vloo_library_images.dart';
import 'package:vloo/app/data/models/template/template_single_item_model.dart';
import 'package:vloo/app/data/utils/static_assets.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/utils/utils.dart';
import 'package:vloo/app/modules/imageElement/views/animations/move_animations.dart';
import 'package:vloo/app/modules/imageElement/views/animations/transition_animations.dart';
import 'package:vloo/app/modules/imageElement/views/availability.dart';
import 'package:vloo/app/modules/imageElement/views/image_element_view.dart';
import 'package:vloo/app/modules/imageElement/views/image_screen.dart';
import 'package:vloo/app/modules/templates/views/Widget/app_loader.dart';
import 'package:vloo/app/modules/textEditing/controllers/title_editing_controller.dart';
import 'package:vloo/app/repository/rest_api.dart';
import 'package:vloo/main.dart';

import '../../../data/utils/singleton.dart';

class ImageModel {
  String? image;
  String? sticker;
  ImageTransitionsAndMoves? imageTransition = ImageTransitionsAndMoves.none;
  ImageTransitionsAndMoves? imageMove = ImageTransitionsAndMoves.none;
  ImageModel({
    this.image,
    this.sticker,
    this.imageTransition,
    this.imageMove,
  });

  static ImageModel initModel() {
    return ImageModel(image: '', sticker: '');
  }
}

class ImageElementController extends GetxController with GetTickerProviderStateMixin {
  TemplateSingleItemModel? elementModel;
  RxInt tabInnerIndex = 0.obs;
  RefreshController phoneTabRefreshController = RefreshController();

  Timer? debounce;


// class ImageElementController extends GetxController
//     with GetTickerProviderStateMixin {
  late final AnimationController animationController;
  late AnimationController scaleController;
  late final Tween<Offset> topAnimation;
  late final Tween<Offset> downAnimation;
  late final Tween<Offset> leftAnimation;
  late final Tween<Offset> rightAnimation;
  late Animation<double> scaleAnimation;

  late ScrollController scrollController;
  int currentPageIndex = 1;
  int lastPageIndex = 1;
  ImageModel? imageModel;

  Rx<Uint8List?> processedImageBytes = Rx<Uint8List?>(null);
  Rx<String?> errorMessage = Rx<String?>(null);
  RxString imageUrl = ''.obs;
  Rx<String>? selectedSticker = ''.obs;
  //Rx<AnimationDirection> selectedAnimation = AnimationDirection.none.obs;
  //Rx<TransitionType> selectedTransition = TransitionType.none.obs;
  Rx<ImageTransitionsAndMoves> imageTransition = ImageTransitionsAndMoves.none.obs;
  Rx<ImageTransitionsAndMoves> imageMove = ImageTransitionsAndMoves.none.obs;
  RxBool isAnimationActivate = false.obs;
  RxBool isBackgroundRemoved = false.obs;
  RxBool isLoading = false.obs;
  RxBool showAnimationContent = false.obs;
  RxBool isSwitched = true.obs;
  late TabController templateEditingTabController;
  late TabController libraryImagesTabController;
  late TabController libraryBackgroundTabController;

  void toggleSwitch(bool value) => isSwitched.value = value;
  int selectedIndex = 0;
  int selectedFolderID = 0;
  String searchString = "";
  Rx<List<StockPhotos>?> stockPhotosList = Rx<List<StockPhotos>?>(null);
  Rx<List<LibraryImages>?> vlooLibraryPhotosList = Rx<List<LibraryImages>?>(null);
  Rx<List<ImageCategory>?> imageFolderCategoryList = Rx<List<ImageCategory>?>(null);
  RxList<LibraryImages>? recentLibraryImages = <LibraryImages>[].obs;
  RxBool isBackgroundImages = false.obs; // if false then means it is Images else backgrounds
  final RestAPI restAPI = Get.find<RestAPI>();
 late TabController libraryTabController ;

  List<Widget> tabViews = [
    const TransitionAnimation(),
    const MoveAnimation(),
    Container(color: Colors.red),
    const Availability(),
  ];
  
  List<Map<String, String>> stickersList = [
    {"image": StaticAssets.outOfStock1},
    {"image": StaticAssets.outOfStock2},
    {"image": StaticAssets.outOfStock3},
    {"image": StaticAssets.outOfStock4},
    {"image": StaticAssets.outOfStock5},
    {"image": StaticAssets.outOfStock6},
    {"image": StaticAssets.soldOut1},
    {"image": StaticAssets.soldOut2},
    {"image": StaticAssets.soldOut3},
    {"image": StaticAssets.soldOut4},
    {"image": StaticAssets.soldOut5},
    {"image": StaticAssets.soldOut6},
  ];

  List<TextTransitionModel> movesItemList = [
    TextTransitionModel(
      imagePath: StaticAssets.noneIcon,
      imageTransitionsAndMoves: ImageTransitionsAndMoves.none,
      text: 'None',
    ),
    TextTransitionModel(
      imagePath: "assets/images/pulse.gif",
      imageTransitionsAndMoves: ImageTransitionsAndMoves.pulse,
      positionDirection: StaticAssets.horizontalMoveIcon,
      text: Strings.pulse,
    ),
    TextTransitionModel(
      imagePath: "assets/images/position_left_right.gif",
      imageTransitionsAndMoves: ImageTransitionsAndMoves.positionH,
      positionDirection: StaticAssets.horizontalMoveIcon,
      text: Strings.position,
    ),
    TextTransitionModel(
      imagePath: "assets/images/position_up_down.gif",
      imageTransitionsAndMoves: ImageTransitionsAndMoves.positionV,
      positionDirection: StaticAssets.verticalMoveIcon,
      text: Strings.position,
    ),
    TextTransitionModel(
      imagePath: "assets/images/wiggle.gif",
      imageTransitionsAndMoves: ImageTransitionsAndMoves.wiggle,
      text: 'Wiggle',
    ),
    TextTransitionModel(
      imagePath: "assets/images/shaking.gif",
      imageTransitionsAndMoves: ImageTransitionsAndMoves.shaking,
      text: 'Shaking',
    ),
  ];

  List<TextTransitionModel> transitionItemList = [
    TextTransitionModel(
      imagePath: StaticAssets.noneIcon,
      imageTransitionsAndMoves: ImageTransitionsAndMoves.none,
      text: 'None',
    ),
    TextTransitionModel(
      imagePath: "assets/images/appear_transition_image.gif",
      imageTransitionsAndMoves: ImageTransitionsAndMoves.appear,
      text: 'Appear',
    ),
    TextTransitionModel(
      imagePath: "assets/images/left_transition_image.gif",
      imageTransitionsAndMoves: ImageTransitionsAndMoves.left,
      text: 'Left',
    ),
    TextTransitionModel(
      imagePath: "assets/images/right_transition_image.gif",
      imageTransitionsAndMoves: ImageTransitionsAndMoves.right,
      text: 'Right',
    ),
    TextTransitionModel(
      imagePath: "assets/images/top_transition_image.gif",
      imageTransitionsAndMoves: ImageTransitionsAndMoves.top,
      text: 'Top',
    ),
    TextTransitionModel(
      imagePath: "assets/images/down_transition_image.gif",
      imageTransitionsAndMoves: ImageTransitionsAndMoves.down,
      text: 'Down',
    ),
  ];

// method for the api call in order to remove background
// ToDo the following api call is paid, TL told to change it when he'll ask
  Future<void> removeBgApi(String imagePath) async {
    isLoading.value = true;
    AppLoader.showLoader();
    if (!isBackgroundRemoved.value) {
      try {
        /*  var request = http.MultipartRequest("POST", Uri.parse("https://api.remove.bg/v1.0/removebg")); // remove-bg API
        request.headers.addAll({"x-api-key": "zqpmbChKN6FDdZLZZZDMuEPS"});*/



        String? downloadImagePath = await downloadImage(imagePath, imagePath.length);

        var request = http.MultipartRequest("POST", Uri.parse("https://sdk.photoroom.com/v1/segment")); // PhotoRoom API
        request.headers.addAll({"x-api-key": "60a0a181720e2c4fc26f8ae384ac3aafa8598d50"});
        //request.headers.addAll({"x-api-key": "d33a3e065783665cf75458bfd300908029382541"});
        request.files.add(await http.MultipartFile.fromPath("image_file", downloadImagePath ?? ""));
        request.headers.addAll({"Accept": "image/png, application/json"});
        request.headers.addAll({"Content-Type": "multipart/form-data"});
        final response = await request.send();
        // print(response.statusCode);
        if (response.statusCode == 200) {
          http.Response imgRes = await http.Response.fromStream(response);

          processedImageBytes.value = imgRes.bodyBytes;
          isBackgroundRemoved.value = true;

          isLoading.value = false;
          AppLoader.hideLoader();
        } else {
          errorMessage.value = response.reasonPhrase;
          isLoading.value = false;
          AppLoader.hideLoader();
        }
      } catch (e) {
        errorMessage.value = "Error occurred. Please try again.";
        isLoading.value = false;
        AppLoader.hideLoader();
      }
    } else {
      isBackgroundRemoved.value = false;
      isLoading.value = false;
      AppLoader.hideLoader();
    }
  }

  Future<String?> uploadImageAPIToServer(File? featureImg) async {
    if (featureImg == null) return null;

    AppLoader.showLoader();
    var documentFrontStream = https.ByteStream(DelegatingStream.typed(featureImg.openRead()));
    var documentFrontLength = await featureImg.length();

    List<https.MultipartFile> multipartFiles = [];
    multipartFiles.add(https.MultipartFile('image', documentFrontStream, documentFrontLength, filename: basename(featureImg.path)));

    Map<String, String> params = {};

    var response = await restAPI.postMultipartMethod(ApiConfig.uploadTemplateMediaURL, multipartFiles, params, true);
    if (response != null && response.isNotEmpty) {
      try {
        AppLoader.hideLoader();
        return response;
      } on Exception catch (_) {
        // scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(3, response));
        if (kDebugMode) {
          print(response);
        }
        AppLoader.hideLoader();
        rethrow;
      }
    } else {
      AppLoader.hideLoader();
      // scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(3, Singleton.errorResponse?.message ?? Strings.somethingWentWrong));
    }

    return null;
  }

  Future<String?> downloadImage(String? url, int? index) async {
    try {
      String randomName = '${index ?? 0}stock_photo.png';
      String savePath = "";
      if (Platform.isIOS) {
        final directory = await getApplicationDocumentsDirectory();
        savePath = '${directory.path}/$randomName';
      } else if (Platform.isAndroid) {
        final directory = await getApplicationDocumentsDirectory();
        savePath = '${directory.path}/$randomName';
      }
      AppLoader.showLoader();
      var response = await http.get(Uri.parse(url ?? ""));
      // Directory documentDirectory = await getApplicationDocumentsDirectory();
      // String path = '${documentDirectory.path}${index ?? 0}stock_photo.png';

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

  Future<void> getRecentImagesList()async{
    try{
      var url = ApiConfig.vlooLibraryGetRecentImages;

      var response = await restAPI.getDataMethod(url, Singleton.header, null);
        recentLibraryImages?.clear();
        CommonResponse model = CommonResponse.fromJson(response);

        List<LibraryImages> list = <LibraryImages>[];
        for (int index = 0; index < model.result.length; index++) {
          list.add(LibraryImages.fromJson(model.result[index]));
        }
        recentLibraryImages?.value = list;
        print(recentLibraryImages?.toJson());
    }
    catch(e){
      throw Exception(e);
    }
    finally{
    }
  }

  Future<void> onRefresh()async{
    await getRecentImagesList();
    phoneTabRefreshController.refreshCompleted();
  }


  void resetView() {
    selectedSticker?.value = '';
    isBackgroundRemoved.value = false;
    imageUrl.value = '';
    imageMove.value = ImageTransitionsAndMoves.none;
    imageTransition.value = ImageTransitionsAndMoves.none;
    templateEditingTabController.index = 0;
    stockImagesApi("burger", 1.toString());
  }

  Future<void> onGoingBackFromImage () async {
    if (isBackgroundRemoved.value == true) {
      AppLoader.showLoader();
      String randomName =
          '${DateTime.now().microsecondsSinceEpoch.toString()}stock_photo.png';
      String savePath = "";
      if (Platform.isIOS) {
        final directory = await getApplicationDocumentsDirectory();
        savePath = '${directory.path}/$randomName';
      } else if (Platform.isAndroid) {
        final directory = await getApplicationDocumentsDirectory();
        savePath = '${directory.path}/$randomName';
      }

      if (await File(savePath).exists()) {
    await File(savePath).delete();
    }

    File file = File(savePath);
    file.writeAsBytesSync(
    processedImageBytes.value as List<int>);

    String? selectedImagePath = await uploadImageAPIToServer(file); // converting file to url
    if (selectedImagePath != null) {
    imageUrl.value = selectedImagePath;
    }
    AppLoader.hideLoader();
    }
    final ImageModel result = ImageModel(
    image: imageUrl.value,
    sticker: selectedSticker?.value,
    imageTransition: imageTransition.value,
    imageMove: imageMove.value,
    );

    Get.back(result: result);
    Get.back(result: result);

    resetView();
  }

// method for the api call in order to get pexels.com stock images
  Future<void> stockImagesApi(String? searchQuery, String? index) async {
    isLoading.value = true;
    AppLoader.showLoader();
    try {
      var query = searchQuery ?? "food";
      var page = index ?? "1";
      var url = "https://api.pexels.com/v1/search?query=$query&page=$page&size=small&per_page=80";

      var response = await http.get(Uri.parse(url), headers: {
        "Authorization": "shkHAa5kA6NJ7tCaGD37ql8f8DJwGFmMdqygpj7vkbdXL3yPJDb1jFWm",
        "Accept": "image/png, application/json",
        "Content-Type": "application/json"
      }).timeout(const Duration(seconds: 60), onTimeout: () {
        AppLoader.hideLoader();
        throw Exception("Request Time Out");
      });

      StockPhotoResponse serverResponse = StockPhotoResponse.fromJson(json.decode(response.body));
      if (response.statusCode >= 200) {
        AppLoader.hideLoader();
        stockPhotosList.value = serverResponse.photos;
      } else {
        AppLoader.hideLoader();
        stockPhotosList.value = null;
        Singleton.errorResponse?.message = Strings.somethingWentWrong;
      }
    } catch (e) {
      errorMessage.value = "Error occurred. Please try again.";
      AppLoader.hideLoader();
      isLoading.value = false;
    }
  }

  Future<File?> selectImageFromGallery() async {
    XFile? xFile = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 10);
    File file = File(xFile?.path ??'');
    return file;
  }

  Future<File?> selectImageFromCamera() async {
    XFile? xFile = await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 10);
    File file= File(xFile?.path ?? "");
    return file;
  }

// method for starting animation
  void startAnimations() {
    scaleController.forward();
    scaleController.addListener(() {
      if (scaleController.value == 1) {
        scaleController.reverse();
      }
      if (scaleController.value == 0.2) {
        scaleController.forward();
      }
    });
  }

// method for stopping animation
  void endAnimation() {
    scaleController.reset();
    scaleController.stop();
  }

// method for triggering scale animation
  Animation<double> triggerScaleAnimations(AnimationDirection animation) {
    switch (animation) {
      case AnimationDirection.pulse:
        return Tween<double>(begin: 0.75, end: 1.0).animate(CurvedAnimation(
          parent: scaleController,
          curve: Curves.easeInOut,
        ));
      default:
        return Tween<double>(begin: 0.75, end: 1.0).animate(CurvedAnimation(
          parent: scaleController,
          curve: Curves.easeInOut,
        ));
    }
  }

// method for triggering wiggle and shaking animation
  Animation<double> triggerWiggleAnimations(AnimationDirection animation) {
    switch (animation) {
      case AnimationDirection.wiggle:
        return Tween<double>(begin: -0.005, end: 0.005).animate(CurvedAnimation(
          parent: scaleController,
          curve: Curves.easeInOut,
        ));
      case AnimationDirection.shaking:
        return Tween<double>(begin: -0.03, end: 0.03).animate(CurvedAnimation(
          parent: scaleController,
          curve: Curves.easeInOut,
        ));
      default:
        return Tween<double>(begin: 0, end: 0).animate(CurvedAnimation(
          parent: scaleController,
          curve: Curves.easeInOut,
        ));
    }
  }

// method for triggering position and slide animation
  Animation<Offset> triggerPositionAnimations(AnimationDirection animation) {
    switch (animation) {
      case AnimationDirection.none:
        return Tween<Offset>(
          begin: Offset.zero,
          end: Offset.zero,
        ).animate(animationController);
      case AnimationDirection.appear:
        return Tween<Offset>(
          begin: const Offset(0.0, -2),
          end: const Offset(0.0, 0.025),
        ).animate(animationController);
      case AnimationDirection.left:
        return leftAnimation.animate(animationController);
      case AnimationDirection.right:
        return rightAnimation.animate(animationController);
      case AnimationDirection.top:
        return topAnimation.animate(animationController);
      case AnimationDirection.down:
        return downAnimation.animate(animationController);
      case AnimationDirection.positionH:
        return Tween<Offset>(
          begin: const Offset(-0.1, 0.0),
          end: const Offset(0.1, 0.0),
        ).animate(CurvedAnimation(
          parent: scaleController,
          curve: Curves.easeInOut,
        ));
      case AnimationDirection.positionV:
        return Tween<Offset>(
          begin: const Offset(0, -0.1),
          end: const Offset(0, 0.1),
        ).animate(CurvedAnimation(
          parent: scaleController,
          curve: Curves.easeInOut,
        ));
      default:
        return Tween<Offset>(
          begin: const Offset(2, 0.0),
          end: const Offset(-0.025, 0.0),
        ).animate(CurvedAnimation(
          parent: scaleController,
          curve: Curves.easeInOut,
        ));
    }
  }

// method for triggering opacity animation
  Animation<double> triggerOpacityAnimations(AnimationDirection animation) {
    switch (animation) {
      case AnimationDirection.appear:
        return Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(animationController);
      default:
        return Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(animationController);
    }
  }
  ImageTransitionsAndMoves getImageTransition(String value) {
    // Remove the prefix "ImageTransitionsAndMoves."
    Get.forceAppUpdate();
    if (value.startsWith('ImageTransitionsAndMoves.')) {
      value = value.substring('ImageTransitionsAndMoves.'.length);
    }

    switch (value) {
      case 'none':
        return ImageTransitionsAndMoves.none;
      case 'appear':
        return ImageTransitionsAndMoves.appear;
      case 'left':
        return ImageTransitionsAndMoves.left;
      case 'right':
        return ImageTransitionsAndMoves.right;
      case 'top':
        return ImageTransitionsAndMoves.top;
      case 'down':
        return ImageTransitionsAndMoves.down;
      case 'pulse':
        return ImageTransitionsAndMoves.pulse;
      case 'positionH':
        return ImageTransitionsAndMoves.positionH;
      case 'positionV':
        return ImageTransitionsAndMoves.positionV;
      case 'wiggle':
        return ImageTransitionsAndMoves.wiggle;
      case 'shaking':
        return ImageTransitionsAndMoves.shaking;
      default:
        throw ArgumentError('Invalid value: $value');
    }

  }

  @override
  void onReady() {
    super.onReady();
    if (Get.arguments != null) {
      elementModel = (Get.arguments as TemplateSingleItemModel);
      imageUrl.value = elementModel!.valueLocal!;
      selectedSticker?.value = elementModel!.availability!;
      templateEditingTabController.index = elementModel?.tabsIndex?? 0;
      imageTransition.value = getImageTransition(elementModel?.animation ?? '');
      imageMove.value = getImageTransition(elementModel?.effect ?? '');
    }

    stockImagesApi("burger", 1.toString());
    getVlooLibraryCategories(ImageCategoryType.IMAGE.name, currentPageIndex);
    libraryTabController.addListener(() {
      if(libraryTabController.index==1) {
        getRecentImagesList();
      }
    });
  }

// init
  @override
  void onInit() {
    templateEditingTabController = TabController(length: 4, vsync: this);
    libraryImagesTabController = TabController(length: 0, vsync: this);
    libraryBackgroundTabController = TabController(length: 0, vsync: this);
    libraryTabController = TabController(length: 3, vsync: this);

    templateEditingTabController.addListener(() {
      tabInnerIndex.value = templateEditingTabController.index;

      if(templateEditingTabController.index == 2){
        if(!Get.isRegistered<ImageElementController>()){
          Get.put<ImageElementController>(ImageElementController());
        }
        Get.to(()=> ImageElementView(comingFrom: 'edit'));
      }

    });

    animationController = AnimationController(
      vsync: this,
      value: 1.0,
      duration: const Duration(milliseconds: 800),
    );
    // slide animations
    topAnimation = Tween<Offset>(
      begin: const Offset(0.0, -0.1),
      end: const Offset(0.0, 0.025),
    );
    downAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.1),
      end: const Offset(0.0, -0.025),
    );
    leftAnimation = Tween<Offset>(
      begin: const Offset(-0.1, 0.0),
      end: const Offset(0.1, 0.0),
    );
    rightAnimation = Tween<Offset>(
      begin: const Offset(0.1, 0.0),
      end: const Offset(-0.025, 0.0),
    );
    // scale animations
    scaleController = AnimationController(
      lowerBound: 0.2,
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    final Animation<double> curvedAnimation = CurvedAnimation(
      parent: scaleController,
      curve: Curves.easeInOut,
    );
    scaleAnimation = Tween<double>(begin: 1, end: 2).animate(curvedAnimation);

    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent <= scrollController.offset) {
        if (currentPageIndex < lastPageIndex) {
          currentPageIndex = currentPageIndex + 1;
          getVlooLibraryImages(ImageCategoryType.IMAGE.name, imageFolderCategoryList.value?[selectedIndex].folderId.toString(),  "", currentPageIndex);
        }
      }
    });

    super.onInit();
  }

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
              selectedFolderID   = imageFolderCategoryList.value?[selectedIndex].folderId?.toInt() ?? 0;

              getVlooLibraryImages(type, selectedFolderID.toString(), "",  page); // TODO: Pagination needed to be implemented
            });
          } else {
            libraryBackgroundTabController = TabController(length: imageFolderCategoryList.value?.length ?? 0, vsync: this);
            libraryBackgroundTabController.addListener(() {
              vlooLibraryPhotosList.value?.clear();
              selectedIndex = libraryBackgroundTabController.index;
              selectedFolderID = imageFolderCategoryList.value?[selectedIndex].folderId?.toInt() ?? 0;
              getVlooLibraryImages(type, selectedFolderID.toString(),  "", page);
            });
          }

          getVlooLibraryImages(type, imageFolderCategoryList.value?[0].folderId.toString(),  "", page); // For first time call
        }
        print(model.message);
        //scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(2, model.message ?? Strings.success));
      } on Exception catch (_) {
        // scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(3, response["message"]));
        print(response);
        rethrow;
      }
    } else {
      // scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text(Singleton.errorResponse?.message ?? "Server Error")));
    }
  }

  Future<void> getVlooLibraryImages(String? type, String? folderID, String? searchString,  int page) async {
    AppLoader.showLoader();
    var url = "";

    if (folderID != null && folderID.isNotEmpty) {
      url = "${ApiConfig.vlooLibraryGetImages}?folderId=$folderID&search=$searchString&type=$type&page=$page";
    } else if (searchString != null && searchString.isNotEmpty) {
      url =
      "${ApiConfig.vlooLibraryGetImages}?search=$searchString&type=$type&page=$page";
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
          if (vlooLibraryPhotosList.value != null) vlooLibraryPhotosList.value!.clear;
          vlooLibraryPhotosList.value = modelChild.data;
        } else {
          vlooLibraryPhotosList.value?.addAll(modelChild.data!);
        }

        currentPageIndex = modelChild.currentPage?.toInt() ?? 0;
        lastPageIndex = modelChild.lastPage?.toInt() ?? 0;
        vlooLibraryPhotosList.refresh();

        AppLoader.hideLoader();
        print(model.message);
      } on Exception catch (e) {
        print(e);
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

  @override
  void dispose() {
    scaleController.dispose();
    libraryBackgroundTabController.dispose();
    libraryImagesTabController.dispose();
    scaleController.dispose();
    super.dispose();
  }
}

// enums
enum ImageTransitionsAndMoves { none, appear, left, right, top, down, pulse, positionH, positionV, wiggle, shaking }

// enum TransitionType {
//   none,
//   scale,
//   opacity,
//   slide,
//   rotaion,
// }

enum ImageCategoryType {
  BACKGROUND,
  IMAGE,
}
