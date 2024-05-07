import 'dart:ui';

import 'package:vloo/app/data/models/options/currency_model.dart';

/// id : 5
/// type : "image"
/// value : "C:/Users/aitsam.ali/Downloads/test.JPEG"
/// x-axis : "10px"
/// y-axis : "20px"
/// height : "200px"
/// width : "300px"
/// font_family : "Impact"
/// font_size : "18px"
/// text_color : "#ffffff"
/// rotation : "45"
/// animation : ""
/// effect : ""
/// label : "Test"
/// theme : ""
/// availability : ""
/// background_image : "C:/Users/muhammad.qamar/Downloads/test.jpg"
/// background_color : "#000000"
/// isSelected : true
/// comingFrom : ""
/// rect : ""

class TemplateSingleItemModel {
  TemplateSingleItemModel({
      this.id, 
      this.templateId,
      this.type,
      this.value, 
      this.valueLocal,
      this.currency,
      this.xaxis,
      this.yaxis, 
      this.height, 
      this.width, 
      this.fontFamily, 
      this.fontSize, 
      this.textColor, 
      this.rotation, 
      this.animation, 
      this.effect, 
      this.label, 
      this.theme, 
      this.availability, 
      this.backgroundImage, 
      this.backgroundColor, 
      this.isSelected, 
      this.isSelectedCurrency,
      this.comingFrom,
      this.rect,
      this.selectedAlignment,
      this.tabsIndex,
      this.availabilityStickerSize,
      this.currencyFormat,
      this.currencyName,
      this.currencySymbol,
      this.fontOpacity,
      this.backgroundOpacity,
      this.currencyCountry});

  TemplateSingleItemModel.fromJson(dynamic json) {
    id = json['id'];
    templateId = json['template_id'];
    type = json['type'];
    value = json['value'];
    xaxis = json['x-axis'];
    yaxis = json['y-axis'];
    height = json['height'] == null ?  100 : double.tryParse(json['height']) ;
    width = json['width'] == null?  100 : double.tryParse(json['width']);
    fontOpacity = json['font_opacity'] == null?  1.0 : double.tryParse(json['font_opacity']);
    backgroundOpacity = json['background_opacity'] == null?  1.0 : double.tryParse(json['background_opacity']);
    fontFamily = json['font_family'];
    fontSize = json['font_size'] == null ?  14 : double.tryParse(json['font_size']);
    textColor = json['text_color'];
    rotation = json['rotation'];
    animation = json['animation'];
    effect = json['effect'];
    label = json['label'];
    theme = json['theme'];
    availability = json['availability'];
    backgroundImage = json['background_image'];
    backgroundColor = json['background_color'];
    rect = json['rect'];
    valueLocal = json['local_value'];
    currency = json['currency_in_element'];
    currencyFormat = json['currency_format'];
    currencyName = json['currency_name'];
    currencySymbol = json['currency_symbol'];
    currencyCountry = json['currency_country'];
    isSelected = json['is_selected'] != null ? json['is_selected'] == 1 ? true : false : null;
    isSelectedCurrency = json['is_selected_currency'] != null ? json['is_selected_currency'] == 1 ? true : false : null;
    comingFrom = json['coming_from'];
    selectedAlignment = json['selected_alignment'] == null ? 1 :  double.tryParse(json['selected_alignment'])?.toInt();
    availabilityStickerSize =  json['availability_sticker_size'] ?? 50;
    tabsIndex =  json['tabsIndex'] ?? 50;
  }
  num? id;
  num? templateId;
  String? type;
  String? value;
  String? valueLocal;
  num? xaxis;
  num? yaxis;
  double? height;
  double? width;
  double? fontOpacity;
  double? backgroundOpacity;
  String? fontFamily;
  double? fontSize;
  String? textColor;
  String? rotation;
  String? animation;
  String? effect;
  String? label;
  String? theme;
  String? availability;
  String? backgroundImage;
  String? backgroundColor;
  bool? isSelected;
  bool? isSelectedCurrency;
  String? comingFrom;
  Rect? rect;
  int? selectedAlignment;
  int? availabilityStickerSize;
  int? tabsIndex;
  String? currency;
  String? currencyFormat;
  String? currencyName;
  String? currencySymbol;
  String? currencyCountry;

TemplateSingleItemModel copyWith({  num? id, num? templateId,
  String? type,
  String? value,
  String? valueLocal,
  num? xaxis,
  double? yaxis,
  double? height,
  double? width,
  double? fontOpacity,
  double? backgroundOpacity,
  String? fontFamily,
  double? fontSize,
  String? textColor,
  String? rotation,
  String? animation,
  String? effect,
  String? label,
  String? theme,
  String? availability,
  String? backgroundImage,
  String? backgroundColor,
  bool? isSelected,
  bool? isSelectedCurrency,
  String? comingFrom,
  Rect? rect,
  int? selectedAlignment,
  int? availabilityStickerSize,
  int? tabsIndex,
  String? currency,
  String? currencyFormat,
  String? currencyName,
  String? currencySymbol,
  String? currencyCountry,

}) => TemplateSingleItemModel(  id: id ?? this.id,templateId: templateId ?? this.templateId,
  type: type ?? this.type,
  value: value ?? this.value,
  valueLocal: valueLocal ?? this.valueLocal,
  currency: currency ?? this.currency,
  xaxis: xaxis ?? this.xaxis,
  yaxis: yaxis ?? this.yaxis,
  height: height ?? this.height,
  width: width ?? this.width,
  fontOpacity: fontOpacity ?? this.fontOpacity,
  backgroundOpacity: backgroundOpacity ?? this.backgroundOpacity,
  fontFamily: fontFamily ?? this.fontFamily,
  fontSize: fontSize ?? this.fontSize,
  textColor: textColor ?? this.textColor,
  rotation: rotation ?? this.rotation,
  animation: animation ?? this.animation,
  isSelectedCurrency: isSelectedCurrency ?? this.isSelectedCurrency,
  effect: effect ?? this.effect,
  label: label ?? this.label,
  theme: theme ?? this.theme,
  availability: availability ?? this.availability,
  backgroundImage: backgroundImage ?? this.backgroundImage,
  backgroundColor: backgroundColor ?? this.backgroundColor,
  isSelected: isSelected ?? this.isSelected,
  comingFrom: comingFrom ?? this.comingFrom,
  rect: rect ?? this.rect,
  selectedAlignment: selectedAlignment ?? this.selectedAlignment,
  availabilityStickerSize: availabilityStickerSize ?? this.availabilityStickerSize,
  tabsIndex: tabsIndex ?? this.tabsIndex,
  currencyFormat: currencyFormat ?? this.currencyFormat,
  currencyName: currencyName ?? this.currencyName,
  currencySymbol: currencySymbol ?? this.currencySymbol,
  currencyCountry: currencyCountry ?? this.currencyCountry,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['template_id'] = templateId;
    map['type'] = type;
    map['value'] = value;
    map['local_value'] = valueLocal;
    map['x-axis'] = xaxis;
    map['y-axis'] = yaxis;
    map['height'] = height;
    map['width'] = width;
    map['font_opacity'] = fontOpacity;
    map['background_opacity'] = backgroundOpacity;
    map['font_family'] = fontFamily;
    map['font_size'] = fontSize;
    map['text_color'] = textColor;
    map['rotation'] = rotation;
    map['animation'] = animation;
    map['effect'] = effect;
    map['label'] = label;
    map['theme'] = theme;
    map['availability'] = availability;
    map['background_image'] = backgroundImage;
    map['background_color'] = backgroundColor;
    map['is_selected'] = isSelected;
    map['is_selected_currency'] = isSelectedCurrency;
    map['coming_from'] = comingFrom;
    map['selected_alignment'] = selectedAlignment;
    map['availability_sticker_size'] = availabilityStickerSize;
    map['tabsIndex'] = tabsIndex;
    map['currency_in_element'] = currency;
    map['currency_format'] = currencyFormat;
    map['currency_name'] = currencyName;
    map['currency_symbol'] = currencySymbol;
    map['currency_country'] = currencyCountry;
    return map;
  }

}