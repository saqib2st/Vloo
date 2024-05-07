import 'package:vloo/app/data/models/common/custom_style.dart';
import 'package:vloo/app/data/models/template/template_single_item_model.dart';

/// id : 3
/// user_id : 1
/// title : "Hello 8"
/// feature_img : "https://vloo.6lgx.com/storage/images/templates/0_1689852693.jpg"
/// currency : "$"
/// currency_alignment : "Middle"
/// description : "Hello sixlogics"
/// background_color : ""
/// background_image : ""
/// orientation : "Portrait"
/// is_locked : "Yes"
/// created_at : "2023-07-20T11:31:33.000000Z"
/// updated_at : "2023-07-20T11:31:33.000000Z"
/// elements : []

class Template {
  Template({
    int? id,
      num? userId, 
      String? title, 
      String? name,
      String? featureImg,
      String? currency, 
      String? currencyAlignment, 
      String? description, 
      String? backgroundColor, 
      String? backgroundImage, 
      String? orientation, 
      String? isLocked, 
      int? isPredefined,
      String? createdAt,
      String? updatedAt, 
      List<TemplateSingleItemModel>? elements,}){
    id = id;
    userId = userId;
    title = title;
    name = name;
    featureImg = featureImg;
    currency = currency;
    currencyAlignment = currencyAlignment;
    description = description;
    backgroundColor = backgroundColor;
    backgroundImage = backgroundImage;
    orientation = orientation;
    isLocked = isLocked;
    isPredefined =isPredefined;
    createdAt = createdAt;
    updatedAt = updatedAt;
    elements = elements;
}

  Template.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    name = json['name'];
    featureImg = json['feature_img'];
    currency = json['currency'];
    currencyAlignment = json['currency_alignment'];
    description = json['description'];
    backgroundColor = json['background_color'];
    backgroundImage = json['background_image'];
    orientation = json['orientation'];
    isLocked = json['is_locked'];
    isPredefined = json['is_predefined'] ;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['template_elements'] != null) {
      elements = [];
      json['template_elements'].forEach((e) {
        elements?.add(TemplateSingleItemModel.fromJson(e));
      });
    }
  }
  int? id;
  num? userId;
  String? title;
  CustomStyle? titleStyle;
  String? name;
  String? featureImg;
  String? currency;
  CustomStyle? currencyStyle;
  String? currencyAlignment;
  String? description;
  CustomStyle? descriptionStyle;
  String? backgroundColor;
  String? backgroundImage;
  String? orientation;
  String? isLocked;
  int? isPredefined;
  String? createdAt;
  String? updatedAt;
  List<TemplateSingleItemModel>? elements;


Template copyWith({  int? id,
  num? userId,
  String? title,
  String? name,
  String? featureImg,
  String? currency,
  String? currencyAlignment,
  String? description,
  String? backgroundColor,
  String? backgroundImage,
  String? orientation,
  String? isLocked,
  int? isPredefined,
  String? createdAt,
  String? updatedAt,
  List<TemplateSingleItemModel>? elements,
}) => Template(  id: id ?? id,
  userId: userId ?? userId,
  title: title ?? title,
  name: name ?? name,
  featureImg: featureImg ?? featureImg,
  currency: currency ?? currency,
  currencyAlignment: currencyAlignment ?? currencyAlignment,
  description: description ?? description,
  backgroundColor: backgroundColor ?? backgroundColor,
  backgroundImage: backgroundImage ?? backgroundImage,
  orientation: orientation ?? orientation,
  isLocked: isLocked ?? isLocked,
  isPredefined: isPredefined ?? isPredefined,
  createdAt: createdAt ?? createdAt,
  updatedAt: updatedAt ?? updatedAt,
  elements: elements ?? elements,
);


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['title'] = title;
    map['name'] = name;
    map['feature_img'] = featureImg;
    map['currency'] = currency;
    map['currency_alignment'] = currencyAlignment;
    map['description'] = description;
    map['background_color'] = backgroundColor;
    map['background_image'] = backgroundImage;
    map['orientation'] = orientation;
    map['is_locked'] = isLocked;
    map['is_predefined'] = isPredefined;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (elements != null) {
      map['template_elements'] = elements?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}