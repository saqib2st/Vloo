import 'dart:ui';

/// fonts : ""
/// fontWeight : ""
/// fontSize : 16
/// color : "0xff245698"

class CustomStyle {
  CustomStyle({
      String? fonts, 
      FontWeight? fontWeight,
      num? fontSize, 
      Color? color,}){
    _fonts = fonts;
    _fontWeight = fontWeight;
    _fontSize = fontSize;
    _color = color;
}

  CustomStyle.fromJson(dynamic json) {
    _fonts = json['fonts'];
    _fontWeight = json['fontWeight'];
    _fontSize = json['fontSize'];
    _color = json['color'];
  }
  String? _fonts;
  FontWeight? _fontWeight;
  num? _fontSize;
  Color? _color;
CustomStyle copyWith({  String? fonts,
  FontWeight? fontWeight,
  num? fontSize,
  Color? color,
}) => CustomStyle(  fonts: fonts ?? _fonts,
  fontWeight: fontWeight ?? _fontWeight,
  fontSize: fontSize ?? _fontSize,
  color: color ?? _color,
);
  String? get fonts => _fonts;
  FontWeight? get fontWeight => _fontWeight;
  num? get fontSize => _fontSize;
  Color? get color => _color;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fonts'] = _fonts;
    map['fontWeight'] = _fontWeight;
    map['fontSize'] = _fontSize;
    map['color'] = _color;
    return map;
  }

}