import 'Src.dart';

class StockPhotos {
  StockPhotos({
      this.id, 
      this.width, 
      this.height, 
      this.url, 
      this.photographer, 
      this.photographerUrl, 
      this.photographerId, 
      this.avgColor, 
      this.src, 
      this.liked, 
      this.alt,});

  StockPhotos.fromJson(dynamic json) {
    id = json['id'];
    width = json['width'];
    height = json['height'];
    url = json['url'];
    photographer = json['photographer'];
    photographerUrl = json['photographer_url'];
    photographerId = json['photographer_id'];
    avgColor = json['avg_color'];
    src = json['src'] != null ? Src.fromJson(json['src']) : null;
    liked = json['liked'];
    alt = json['alt'];
  }
  int? id;
  int? width;
  int? height;
  String? url;
  String? photographer;
  String? photographerUrl;
  int? photographerId;
  String? avgColor;
  Src? src;
  bool? liked;
  String? alt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['width'] = width;
    map['height'] = height;
    map['url'] = url;
    map['photographer'] = photographer;
    map['photographer_url'] = photographerUrl;
    map['photographer_id'] = photographerId;
    map['avg_color'] = avgColor;
    if (src != null) {
      map['src'] = src?.toJson();
    }
    map['liked'] = liked;
    map['alt'] = alt;
    return map;
  }

}