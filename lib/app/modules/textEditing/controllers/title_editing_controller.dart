import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/models/options/currency_model.dart';
import 'package:vloo/app/data/models/template/template_single_item_model.dart';
import 'package:vloo/app/data/utils/singleton.dart';
import 'package:vloo/app/data/utils/static_assets.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/utils/utils.dart';
import 'package:vloo/app/modules/imageElement/controllers/image_element_controller.dart';
import 'package:vloo/app/modules/templates/controllers/templates_controller.dart';
import 'package:vloo/app/modules/textEditing/views/editing/circular_label.dart';
import 'package:vloo/app/modules/textEditing/views/editing/rectangle_label.dart';
import 'package:vloo/app/modules/textEditing/views/editing/rectangle_label_rounded.dart';

class AnimatedTextWidgetModel {
  int? selectedTextAlignment;
  TextStyle? selectedTextStyle;
  Rx<Color>? currentTextColor;
  Rx<Color>? currentBackgroundColor;
  String? selectedEffect;
  String? fontStyle;
  TextTransitionModel? textTransitionModel;

  AnimatedTextWidgetModel({
    this.selectedTextAlignment,
    this.selectedTextStyle,
    this.currentTextColor,
    this.currentBackgroundColor,
    this.selectedEffect,
    this.textTransitionModel,
    this.fontStyle,
  });

  static AnimatedTextWidgetModel initModel() {
    return AnimatedTextWidgetModel(
      selectedTextAlignment: 1,
      selectedTextStyle: GoogleFonts.openSans(),
      fontStyle: 'OpenSans',
      currentTextColor: const Color(0xffFFFFFF).obs,
      currentBackgroundColor: Colors.transparent.obs,
      selectedEffect: StaticAssets.noneIcon,
      textTransitionModel: TextTransitionModel(imagePath: '', text: 'None', transitionType: null, animationDirection: AnimationDirection.none),
    );
  }
}

class TextTransitionModel {
  String? imagePath;
  String? text;
  TransitionType? transitionType;
  AnimationDirection? animationDirection;
  String? positionDirection;
  ImageTransitionsAndMoves? imageTransitionsAndMoves;

  TextTransitionModel({
    required this.imagePath,
    required this.text,
    this.transitionType,
    this.animationDirection,
    this.positionDirection,
    this.imageTransitionsAndMoves,
  });
}

class TitleEditingController extends GetxController
    with GetTickerProviderStateMixin {
  TemplateSingleItemModel? elementModel;
  final GetStorage storage = Get.find<GetStorage>();
  TemplatesController templatesController = Get.find<TemplatesController>();

  late TabController templateEditingTabController;
  late TabController priceEditingTabController;
  late TabController descriptionEditingTabController;
  late TabController animationTabController;
  RxBool isReadOnly = false.obs;
  RxDouble opacityBGValue = 1.0.obs;
  RxDouble opacityFontValue = 1.0.obs;
  GlobalKey containerKey = GlobalKey();

  Rx<TemplateSingleItemModel> templateSingleItemModelForTheme = TemplateSingleItemModel().obs;

  Rx<AnimatedTextWidgetModel> animatedTextWidgetModel =
      AnimatedTextWidgetModel.initModel().obs;
  RxInt selectedColorTab = 0.obs;
  RxInt selectedBackGroundColorTab = 0.obs;
  RxInt animationTabInnerIndex = 0.obs;
  RxInt tabInnerIndex = 0.obs;
  RxInt selectedTemplateBackGroundColor = 0.obs;
  RxBool selectedTab = false.obs;
  RxBool isPickerColor = true.obs;
  var selectedCurrencyFormat = 'Symbol in end'.obs;
  Rx<CurrencyModel>? selectedCurrencyChoice = CurrencyModel(
          countryCode: '',
          countryName: '',
          currencySymbol: '',
          isSelectedCurrency: false.obs)
      .obs;
  var tempSymbol = '';
  var prevText = '';
  var comingFromMiddleFormat = false;
  RxString selectedPriceTheme = StaticAssets.none.obs;
  late final AnimationController animationController;

  late AnimationController scaleController;
  TextEditingController textController = TextEditingController();
  List<Map<String, dynamic>> effectsItemList = [
    {'image': StaticAssets.noneIcon},
    {'image': StaticAssets.effectNeon},
    {'image': StaticAssets.effectGlitch},
    {'image': StaticAssets.effectFade},
    {'image': StaticAssets.effectCut},
    {'image': StaticAssets.effectBlink}
  ];
  List<TextTransitionModel> transitionItemList = [
    TextTransitionModel(
      imagePath: StaticAssets.noneIcon,
      transitionType: TransitionType.none,
      animationDirection: AnimationDirection.none,
      text: 'None',
    ),
    TextTransitionModel(
      imagePath: StaticAssets.icAppear,
      transitionType: TransitionType.opacity,
      animationDirection: AnimationDirection.appear,
      text: 'Appear',
    ),
    TextTransitionModel(
      imagePath: StaticAssets.icLeft,
      transitionType: TransitionType.slide,
      animationDirection: AnimationDirection.left,
      text: 'Left',
    ),
    TextTransitionModel(
      imagePath: StaticAssets.icRight,
      transitionType: TransitionType.slide,
      animationDirection: AnimationDirection.right,
      text: 'Right',
    ),
    TextTransitionModel(
      imagePath: StaticAssets.icUp,
      transitionType: TransitionType.slide,
      animationDirection: AnimationDirection.top,
      text: 'Top',
    ),
    TextTransitionModel(
      imagePath: StaticAssets.icDown,
      transitionType: TransitionType.slide,
      animationDirection: AnimationDirection.down,
      text: 'Down',
    ),
  ];

  List<TextTransitionModel> transitionItemListTitle = [
    TextTransitionModel(
      imagePath: StaticAssets.noneIcon,
      transitionType: TransitionType.none,
      animationDirection: AnimationDirection.none,
      text: 'None',
    ),
    TextTransitionModel(
      imagePath: 'assets/images/appear_transition.gif',
      transitionType: TransitionType.opacity,
      animationDirection: AnimationDirection.appear,
      text: 'Appear',
    ),
    TextTransitionModel(
      imagePath: 'assets/images/left_transition.gif',
      transitionType: TransitionType.slide,
      animationDirection: AnimationDirection.left,
      text: 'Left',
    ),
    TextTransitionModel(
      imagePath: 'assets/images/right_transition.gif',
      transitionType: TransitionType.slide,
      animationDirection: AnimationDirection.right,
      text: 'Right',
    ),
    TextTransitionModel(
      imagePath: 'assets/images/top_transition.gif',
      transitionType: TransitionType.slide,
      animationDirection: AnimationDirection.top,
      text: 'Top',
    ),
    TextTransitionModel(
      imagePath: 'assets/images/down_transition.gif',
      transitionType: TransitionType.slide,
      animationDirection: AnimationDirection.down,
      text: 'Down',
    ),
  ];

  List<Map<String, dynamic>> iconsList = [
    {"icon": Icons.format_align_left, "text": "Left"},
    {"icon": Icons.format_align_center, "text": "Center"},
    {"icon": Icons.format_align_right, "text": "Right"},
  ];

  List<Map<String, String>> fontsList = [
    {"OpenSans": "OpenSans"},
    {"Caveat": "Caveat"},
    {"ChalkDuster": "ChalkDuster"},
    {"chantal": "chantal"},
    {"CocogooseTrial": "CocogooseTrial"},
    {"DSMoster": "DSMoster"},
    {"EBGaramond08": "EBGaramond08"},
    {"edosz": "edosz"},
    {"Gagalin": "Gagalin"},
    {"KOMIKAX": "KOMIKAX"},
    {"NocturneSerif": "NocturneSerif"},
    {"PoiretOne": "PoiretOne"},
    {"RifficFree": "RifficFree"},
    {"UTLaurelle": "UTLaurelle"},
  ];

  List<Map<String, String>> currencyFormatList = [
    {"\$10.99": "Symbol in start"},
    {"10\$99": "Symbol in middle"},
    {"10.99\$": "Symbol in end"},
  ];

  List<CurrencyModel> currencyChoiceList = [
    CurrencyModel(
        countryCode: 'EU',
        countryName: 'EUR',
        currencySymbol: '€',
        isSelectedCurrency: false.obs),
    CurrencyModel(
        countryCode: 'US',
        countryName: 'USD',
        currencySymbol: '\$',
        isSelectedCurrency: false.obs),
    CurrencyModel(
        countryCode: 'CA',
        countryName: 'CAD',
        currencySymbol: '\$',
        isSelectedCurrency: false.obs),
    CurrencyModel(
        countryCode: 'GB',
        countryName: 'GBP',
        currencySymbol: '£',
        isSelectedCurrency: false.obs),
    CurrencyModel(
        countryCode: 'MA',
        countryName: 'MAD',
        currencySymbol: 'MAD',
        isSelectedCurrency: false.obs),
    CurrencyModel(
        countryCode: 'AE',
        countryName: 'AED',
        currencySymbol: 'AED',
        isSelectedCurrency: false.obs),
  ];

  List<Map<String, dynamic>> tabsList = [
    {"text": "Text"},
    {"text": "Background"},
  ];

  List<Color> colorizeAnimatedText = [
    AppColor.transparent,
  ];

  List<String> stickerList = [
    StaticAssets.none,
    StaticAssets.priceTheme1Icon,
    StaticAssets.priceTheme2Icon,
    StaticAssets.priceTheme3Icon,
  ];

  List<Color> colorsList = [
    AppColor.transparent,
    AppColor.white,
    AppColor.yellow,
    AppColor.purple,
    AppColor.orange,
    AppColor.lightPurple,
    AppColor.darkRed,
    AppColor.lightGreen,
  ];

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
  void findMostUsedCurrencySymbol(var list) {
    // Define a map to store the count of each currency symbol
    Map<String, int> symbolCount = {};

    // Define a regular expression to match currency symbols
    RegExp currencyRegex = RegExp(r'[$€£]|MAD|AED');

    // Iterate through the list of values and count the occurrences of each symbol
    list.forEach((value) {
      currencyRegex.allMatches(value.currency ?? '').forEach((match) {
        String symbol = match.group(0)!;
        symbolCount[symbol] = (symbolCount[symbol] ?? 0) + 1;
      });
    });

    // Find the symbol with the highest count
    String mostUsedSymbol = '';
    int maxCount = 0;
    symbolCount.forEach((symbol, count) {
      if (count > maxCount) {
        maxCount = count;
        mostUsedSymbol = symbol;
      }
    });

    selectedCurrencyChoice?.value = currencyChoiceList.firstWhere((element) => element.currencySymbol==mostUsedSymbol);
    selectedCurrencyChoice?.value.isSelectedCurrency?.value = true;
    selectedCurrencyFormat.value =list.where((element) => element.type=='Price').first.currencyFormat.isNotEmpty?
        list.where((element) => element.type=='Price').last.currencyFormat ??'Symbol in end':'Symbol in end';
  }

  String extractCurrencySymbol(String input) {
    // Define a regular expression to match currency symbols at the beginning or end of the string
    RegExp currencyRegex = RegExp(r'[$€£]|MAD|AED');

    // Use the firstMatch method to find the first occurrence of the currency symbol
    // and return the matched symbol or an empty string if not found
    var match = currencyRegex.firstMatch(input);
    return match?.group(0) ?? '';
  }
  String setSymbolFormat(String value, String symbolFormat, String symbol,bool comingFromMiddleFormat) {
    // Remove any leading or trailing spaces from the symbol format
    symbolFormat = symbolFormat.trim();
    if (!comingFromMiddleFormat) {
      value = value.replaceAll(RegExp(r'[$€£]|MAD|AED'), '');
    }

    // Check the position of the symbol format and format the value accordingly
    switch (symbolFormat) {
      case 'Symbol in start':
      // Remove any currency symbols from the value and place the provided symbol at the start
        if (comingFromMiddleFormat == true) {
          value = value.replaceFirst(RegExp(r'[$€£]|MAD|AED'), '.');
          return '$symbol$value';
        } else {
          value = value.replaceAll(RegExp(r'[$€£]|MAD|AED'), '');
          return '$symbol$value';
        }
      case 'Symbol in middle':
      // Replace dots ('.') with the provided symbol or place the symbol in the middle if not present
        if (value.contains('.')) {
          return value.replaceFirst('.', symbol);
        } else {
          return value;
        }
      case 'Symbol in end':
      // Remove any currency symbols from the value and place the provided symbol at the end

        if (comingFromMiddleFormat == true) {
          value = value.replaceAll(RegExp(r'[$€£]|MAD|AED'), '.');
          return '$value$symbol';
        } else {
          value = value.replaceAll(RegExp(r'[$€£]|MAD|AED'), '');
          return '$value$symbol';
        }
      default:
      // If the symbol format is not recognized, return the original value
        return value;
    }
  }

  Widget setPriceTheme() {
    if (selectedPriceTheme.value == StaticAssets.priceTheme3Icon) {
      return RectangleLabel2(
          text: textController.text.obs,
          textColor: animatedTextWidgetModel.value.currentTextColor?.value,
          bgColor: animatedTextWidgetModel.value.currentBackgroundColor?.value,
          backgroundImage: StaticAssets.rectangular);
    } else if (selectedPriceTheme.value == StaticAssets.priceTheme2Icon) {
      return CircularLabel2(
          text: textController.text.obs,
          textColor: animatedTextWidgetModel.value.currentTextColor?.value,
          bgColor: animatedTextWidgetModel.value.currentBackgroundColor?.value,
          backgroundImage: StaticAssets.circular);
    } else {
      return RectangleLabelRoundedTitle(
          text: textController.text.obs,
          textColor: animatedTextWidgetModel.value.currentTextColor?.value,
          bgColor: animatedTextWidgetModel.value.currentBackgroundColor?.value,
          backgroundImage: StaticAssets.rectangularRounded);
    }
  }

  void updateTitleThemeModelState(){
    templateSingleItemModelForTheme.value = TemplateSingleItemModel(
      selectedAlignment: animatedTextWidgetModel
          .value.selectedTextAlignment,
      valueLocal: textController.value.text,
      fontSize: 40,
      fontFamily:animatedTextWidgetModel.value.fontStyle,
      textColor: animatedTextWidgetModel.value
          .currentTextColor!.value.value
          .toRadixString(16),
      backgroundColor: animatedTextWidgetModel
          .value.currentBackgroundColor!.value
          .value.toRadixString(16),
      animation: animatedTextWidgetModel.value
          .textTransitionModel?.animationDirection
          .toString() ??
          TransitionType.none.toString(),
      effect:
          animatedTextWidgetModel.value.selectedEffect,
    );
  }

  void setCountryCurrency(int index) {
    for (var element in currencyChoiceList) {
      element.isSelectedCurrency?.value = false;
    }
    selectedCurrencyChoice?.value = currencyChoiceList[index];
    currencyChoiceList[index].isSelectedCurrency?.toggle();
  }

  void addDefaultCurrency() {
    if (textController.text.isEmpty) {
      selectedCurrencyFormat.value = Strings.symbolInEnd;
      setCountryCurrency(0);
      textController.text = '${textController.text}0€';
      textController.selection = const TextSelection(
        baseOffset: 0, // starting index
        extentOffset: 1, // ending index
      );
    }
  }

  priceElementText() {
    updateTitleThemeModelState();
    //if statement for handling default € sign in textField
    if (RegExp(r'(€)').hasMatch(textController.text) && (!RegExp(r'[$€£]|MAD|AED').hasMatch(tempSymbol))) {
      textController.text =
          textController.text.substring(0, textController.text.length - 1);
    }
    if (selectedCurrencyChoice?.value.currencySymbol != '' &&
        textController.value.text.contains(tempSymbol.toString())) {
      //start format handling
      if (selectedCurrencyFormat.value == Strings.symbolInStart) {
        textController.text = textController.text.replaceAll(tempSymbol, '');
        if (comingFromMiddleFormat == true) {
          textController.text =
              '${selectedCurrencyChoice?.value.currencySymbol}$prevText';
        } else {
          textController.text =
              '${selectedCurrencyChoice?.value.currencySymbol}${textController.text}';
        }
      }
      //middle format handling
      else if (selectedCurrencyFormat.value == Strings.symbolInMiddle) {
        if (textController.value.text.contains('.')) {
          textController.text =
              textController.value.text.replaceAll(tempSymbol, '');
          prevText = textController.value.text;
          comingFromMiddleFormat = true;
          textController.text = textController.value.text.replaceAll(
              '.', selectedCurrencyChoice?.value.currencySymbol ?? '');
        } else if (textController.value.text.contains(tempSymbol)) {
          textController.text = textController.value.text.replaceAll(
              tempSymbol, selectedCurrencyChoice?.value.currencySymbol ?? '');
        } else {
          textController.text =
              textController.value.text.replaceAll(tempSymbol, '');
          textController.text =
              '${textController.value.text}${selectedCurrencyChoice?.value.currencySymbol}';
        }
      }
      //end format handling
      else {
        textController.text =
            textController.value.text.replaceAll(tempSymbol, '');
        if (comingFromMiddleFormat == true) {
          textController.text =
              '$prevText${selectedCurrencyChoice?.value.currencySymbol}';
        } else {
          textController.text =
              '${textController.value.text}${selectedCurrencyChoice?.value.currencySymbol}';
        }
      }
      tempSymbol = selectedCurrencyChoice!.value.currencySymbol.toString();
    }
  }

  void changeColor(Color color) {
    if (selectedColorTab.value == 0) {
      animatedTextWidgetModel.value.currentTextColor?.value = color;
    } else {
      animatedTextWidgetModel.value.currentBackgroundColor?.value = color;
    }
    Get.forceAppUpdate();
  }

  TextStyle changeFontFamily(String fontFamily) {
    return GoogleFonts.getFont(fontFamily);
  }

  void resetAllView() {
    selectedCurrencyChoice?.value = CurrencyModel(
        countryCode: '',
        countryName: '',
        currencySymbol: '',
        isSelectedCurrency: false.obs);
    selectedCurrencyFormat.value = Strings.symbolInStart;
    tempSymbol = '';
    selectedPriceTheme.value = StaticAssets.none;
    templateEditingTabController.index = 0;
    priceEditingTabController.index = 0;
    opacityFontValue.value =1.0;
    opacityBGValue.value =1.0;
    descriptionEditingTabController.index = 0;
    textController.clear();
    animatedTextWidgetModel.value.currentTextColor?.value = AppColor.white;
    animatedTextWidgetModel.value.currentBackgroundColor?.value = AppColor.transparent;
    selectedColorTab.value = 0;
    animatedTextWidgetModel.value.selectedTextStyle =
        changeFontFamily('Open Sans');
    animatedTextWidgetModel.value.fontStyle = 'OpenSans';
    animatedTextWidgetModel.value.selectedTextAlignment = 1;
    animatedTextWidgetModel.value.selectedEffect = StaticAssets.noneIcon;
    animatedTextWidgetModel.value.textTransitionModel = TextTransitionModel(
        imagePath: '',
        text: 'None',
        transitionType: null,
        animationDirection: AnimationDirection.none);
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

  @override
  void onReady() {
    if (Get.arguments != null) {
      elementModel = (Get.arguments[0] as TemplateSingleItemModel);
      if (elementModel == null) return;
      if (Singleton.comingFrom == Strings.editElementTitle ||
          Singleton.comingFrom == Strings.editElementDescription ||
          Singleton.comingFrom == Strings.editElementPrice) {
        textController.text = elementModel?.valueLocal ?? "";
        if (elementModel!.valueLocal!.isNotEmpty) {
          String currencySymbol = '';
          currencySymbol =
              elementModel!.valueLocal!.replaceAll(RegExp(r"[0-9]+"), '');
          currencySymbol = currencySymbol.contains('.')
              ? currencySymbol.replaceAll('.', '')
              : currencySymbol;
          tempSymbol = currencySymbol;
          int? index = currencyChoiceList.indexWhere((element) =>
          element.currencySymbol == elementModel?.currency);
          if ( index >= 0) {
            selectedCurrencyChoice?.value = currencyChoiceList[index];
            currencyChoiceList[index].isSelectedCurrency?.value = true;
          }else {
            elementModel?.isSelectedCurrency = true;
          }

        }
        selectedCurrencyFormat.value = elementModel?.currencyFormat ?? Strings.symbolInEnd;
        var currencyModel = CurrencyModel(
            currencySymbol: elementModel?.currencySymbol,
            countryName: elementModel?.currencyCountry,
            countryCode: elementModel?.currencyName,
            isSelectedCurrency: (elementModel?.isSelected ?? false).obs);

        selectedCurrencyChoice?.value = currencyModel;
        selectedPriceTheme.value = elementModel?.theme ?? '';
        opacityFontValue.value =  elementModel?.fontOpacity ?? 1.0 ;
        opacityBGValue.value =  elementModel?.backgroundOpacity ?? 1.0 ;
        priceEditingTabController.index = elementModel?.tabsIndex ?? 0;
        templateEditingTabController.index = elementModel?.tabsIndex ?? 0;
        descriptionEditingTabController.index = elementModel?.tabsIndex ?? 0;
        animatedTextWidgetModel.value.fontStyle = elementModel?.fontFamily;
        animatedTextWidgetModel.value.selectedTextStyle = TextStyle(
          color: Color(int.parse(
                  elementModel?.textColor != null &&
                          elementModel!.textColor!.isNotEmpty
                      ? elementModel!.textColor!
                      : "0x000000",
                  radix: 16) +
              0xFF000000),
          fontFamily: elementModel?.fontFamily,
          fontSize: elementModel?.fontSize,
        );

        animatedTextWidgetModel.value.selectedEffect =
            elementModel?.effect ?? '';
        animatedTextWidgetModel.value.textTransitionModel?.text =
            elementModel?.animation ?? '';
        animatedTextWidgetModel.value.selectedTextAlignment =
            elementModel?.selectedAlignment ?? 0;
        animatedTextWidgetModel.value.currentTextColor?.value = Color(int.parse(
                elementModel?.textColor != null &&
                        elementModel!.textColor!.isNotEmpty
                    ? elementModel!.textColor!
                    : "0x000000",
                radix: 16) +
            0xFF000000);
        animatedTextWidgetModel.value.currentBackgroundColor?.value =
            Utils.fetchColorFromStringColor(elementModel?.backgroundColor);
      }
    }
    Get.forceAppUpdate();
    super.onReady();
  }

// init
  @override
  void onInit() async{
    animationTabController =
        TabController(length: 2, vsync: this, animationDuration: null);
    templateEditingTabController = TabController(length: 4, vsync: this);
    priceEditingTabController = TabController(length: 5, vsync: this);
    descriptionEditingTabController = TabController(length: 3, vsync: this);

    animationTabController.addListener(() {
      animationTabInnerIndex.value = animationTabController.index;
    });

    templateEditingTabController.addListener(() {
      tabInnerIndex.value = templateEditingTabController.index;
      if (templateEditingTabController.index == 0) {
        isReadOnly.value = false;
      } else {
        isReadOnly.value = true;
      }
    });
    descriptionEditingTabController.addListener(() {
      tabInnerIndex.value = descriptionEditingTabController.index;

      if (descriptionEditingTabController.index == 0) {
        isReadOnly.value = false;
      } else {
        isReadOnly.value = true;
      }
    });

    priceEditingTabController.addListener(() {
      tabInnerIndex.value = priceEditingTabController.index;
      if (priceEditingTabController.index == 0) {
        isReadOnly.value = false;
      } else {
        isReadOnly.value = true;
      }
    });
    colorBox = await Hive.openBox('colors');
    setColorList();
    super.onInit();
  }

  String getCountryFlag(String countryCode) {
    return countryCode.toUpperCase().replaceAllMapped(
        RegExp(r'[A-Z]'),
        (match) =>
            String.fromCharCode((match.group(0)?.codeUnitAt(0))! + 127397));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // controller1.dispose();
    animationController.dispose();
    priceEditingTabController.dispose();
    descriptionEditingTabController.dispose();
    templateEditingTabController.dispose();
    scaleController.dispose();
    super.dispose();
  }
}

// enums
enum AnimationDirection {
  none,
  appear,
  left,
  right,
  top,
  down,
  pulse,
  positionH,
  positionV,
  wiggle,
  shaking,
}

enum TransitionType {
  none,
  scale,
  opacity,
  slide,
  rotation,
}

enum TextEffects {
  none,
  neon,
  glitch,
  fade,
  cut,
  blink,
}

enum TextAlignment {
  right,
  left,
  center,
}

enum CurrencyTheme {
  none,
  one,
  two,
  three,
}

enum WidgetAnimation {
  incomingScaleUp,
  incomingSlideInFromLeft,
  incomingSlideInFromBottom,
  incomingSlideInFromRight,
  incomingSlideInFromUp,
}
