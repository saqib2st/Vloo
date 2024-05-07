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

class Elements {
  Elements({
      num? id, 
      num? userId,
    num? templateId,
      String? title,
      double? price,
      String? featureImg,
      String? currency, 
      String? currencyAlignment, 
      String? description, 
      String? backgroundColor, 
      String? backgroundImage, 
      String? orientation, 
      String? isLocked,
    num? sortingOrder,
      String? createdAt,
      String? updatedAt, }){
    id = id;
    userId = userId;
    templateId = templateId;
    title = title;
    price = price;
    featureImg = featureImg;
    currency = currency;
    currencyAlignment = currencyAlignment;
    description = description;
    backgroundColor = backgroundColor;
    backgroundImage = backgroundImage;
    orientation = orientation;
    isLocked = isLocked;
    sortingOrder = sortingOrder;
    createdAt = createdAt;
    updatedAt = updatedAt;
}

  Elements.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    templateId = json['template_id'];
    title = json['title'];
    price = json['price'] != null ? json['price'].toDouble() : 0.0;
    featureImg = json['feature_img'];
    currency = json['currency'];
    currencyAlignment = json['currency_alignment'];
    description = json['description'];
    backgroundColor = json['background_color'];
    backgroundImage = json['background_image'];
    orientation = json['orientation'];
    isLocked = json['is_locked'];
    sortingOrder = json['sorting_order'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];

  }
  num? id;
  num? userId;
  num? templateId;
  String? title;
  double? price;
  String? featureImg;
  String? currency;
  String? currencyAlignment;
  String? description;
  String? backgroundColor;
  String? backgroundImage;
  String? orientation;
  String? isLocked;
  num? sortingOrder;
  String? createdAt;
  String? updatedAt;


Elements copyWith({  num? id,
  num? userId,
  num? templateId,
  String? title,
  double? price,
  String? featureImg,
  String? currency,
  String? currencyAlignment,
  String? description,
  String? backgroundColor,
  String? backgroundImage,
  String? orientation,
  String? isLocked,
  num? sortingOrder,
  String? createdAt,
  String? updatedAt,
}) => Elements(  id: id ?? id,
  userId: userId ?? userId,
  title: title ?? title,
  price: price ?? price,
  templateId: templateId ?? templateId,
  featureImg: featureImg ?? featureImg,
  currency: currency ?? currency,
  currencyAlignment: currencyAlignment ?? currencyAlignment,
  description: description ?? description,
  backgroundColor: backgroundColor ?? backgroundColor,
  backgroundImage: backgroundImage ?? backgroundImage,
  orientation: orientation ?? orientation,
  isLocked: isLocked ?? isLocked,
  sortingOrder: sortingOrder ?? sortingOrder,
  createdAt: createdAt ?? createdAt,
  updatedAt: updatedAt ?? updatedAt,
);


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['template_id'] = templateId;
    map['title'] = title;
    map['price'] = price;
    map['feature_img'] = featureImg;
    map['currency'] = currency;
    map['currency_alignment'] = currencyAlignment;
    map['description'] = description;
    map['background_color'] = backgroundColor;
    map['background_image'] = backgroundImage;
    map['orientation'] = orientation;
    map['is_locked'] = isLocked;
    map['sorting_order'] = sortingOrder;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}