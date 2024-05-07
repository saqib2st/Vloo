class Src {
  Src({
      this.original, 
      this.large2x, 
      this.large, 
      this.medium, 
      this.small, 
      this.portrait, 
      this.landscape, 
      this.tiny,});

  Src.fromJson(dynamic json) {
    original = json['original'];
    large2x = json['large2x'];
    large = json['large'];
    medium = json['medium'];
    small = json['small'];
    portrait = json['portrait'];
    landscape = json['landscape'];
    tiny = json['tiny'];
  }
  String? original;
  String? large2x;
  String? large;
  String? medium;
  String? small;
  String? portrait;
  String? landscape;
  String? tiny;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['original'] = original;
    map['large2x'] = large2x;
    map['large'] = large;
    map['medium'] = medium;
    map['small'] = small;
    map['portrait'] = portrait;
    map['landscape'] = landscape;
    map['tiny'] = tiny;
    return map;
  }

}