import 'stockPhotos.dart';

class StockPhotoResponse {
  StockPhotoResponse({
      this.page, 
      this.perPage, 
      this.photos, 
      this.totalResults, 
      this.nextPage,});

  StockPhotoResponse.fromJson(dynamic json) {
    page = json['page'];
    perPage = json['per_page'];
    if (json['photos'] != null) {
      photos = [];
      json['photos'].forEach((v) {
        photos?.add(StockPhotos.fromJson(v));
      });
    }
    totalResults = json['total_results'];
    nextPage = json['next_page'];
  }
  int? page;
  int? perPage;
  List<StockPhotos>? photos;
  int? totalResults;
  String? nextPage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['page'] = page;
    map['per_page'] = perPage;
    if (photos != null) {
      map['photos'] = photos?.map((v) => v.toJson()).toList();
    }
    map['total_results'] = totalResults;
    map['next_page'] = nextPage;
    return map;
  }

}