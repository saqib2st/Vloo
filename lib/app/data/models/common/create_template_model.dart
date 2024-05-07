import 'package:flutter/cupertino.dart';

class CreateTemplateModel {
  String? title, prize, image, description;
  TextStyle? titleTextStyle, prizeTextStyle, descriptionTextStyle;
  bool? isSelected;
  String? comingFrom;
  Rect? rect;

  CreateTemplateModel({this.title, this.description, this.prize, this.image, this.titleTextStyle, this.descriptionTextStyle, this.prizeTextStyle, this.isSelected, this.comingFrom, this.rect,});

  CreateTemplateModel.fromJson(Map<String, dynamic> json) {
    title = json['title'] ?? '';
    prize = json['prize'] ?? '';
    description = json['description'] ?? '';
    titleTextStyle = json['titleTextStyle'] ?? '';
    prizeTextStyle = json['prizeTextStyle'] ?? '';
    descriptionTextStyle = json['descriptionTextStyle'] ?? '';
    image = json['image'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['prize'] = prize;
    data['description'] = description;
    data['titleTextStyle'] = titleTextStyle;
    data['prizeTextStyle'] = prizeTextStyle;
    data['descriptionTextStyle'] = descriptionTextStyle;
    data['image'] = image;
    data['isSelected'] = image;
    data['comingFrom'] = image;
    data['rect'] = rect;
    return data;
  }
}

