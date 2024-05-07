import 'package:vloo/app/data/models/stockphoto/vloo_library_images.dart';

/// current_page : 1
/// data : [{"id":8,"sub_folder_id":3,"title":" sandwich2","media_file":"https://vloo.6lgx.com/storage/vloo_library/Images/Sandwiches/f7d4d5d58efb59431701255969.jpg","type":"","is_active":1,"created_at":"2023-11-29T11:06:30.000000Z","updated_at":"2023-11-29T11:06:30.000000Z"},{"id":7,"sub_folder_id":3,"title":"sandwich1","media_file":"https://vloo.6lgx.com/storage/vloo_library/Images/Sandwiches/9b0177796a356de31701255960.jpg","type":"","is_active":1,"created_at":"2023-11-29T11:06:30.000000Z","updated_at":"2023-11-29T11:06:30.000000Z"}]
/// first_page_url : "https://vloo.6lgx.com/api/vloo-library/get?page=1"
/// from : 1
/// last_page : 1
/// last_page_url : "https://vloo.6lgx.com/api/vloo-library/get?page=1"
/// links : [{"url":"","label":"&laquo; Previous","active":false},{"url":"https://vloo.6lgx.com/api/vloo-library/get?page=1","label":"1","active":true},{"url":"","label":"Next &raquo;","active":false}]
/// next_page_url : ""
/// path : "https://vloo.6lgx.com/api/vloo-library/get"
/// per_page : 15
/// prev_page_url : ""
/// to : 2
/// total : 2

class LibraryResponse {
  LibraryResponse({
      this.currentPage, 
      this.data, 
      this.firstPageUrl, 
      this.from, 
      this.lastPage, 
      this.lastPageUrl,
      this.nextPageUrl, 
      this.path, 
      this.perPage, 
      this.prevPageUrl, 
      this.to, 
      this.total,});

  LibraryResponse.fromJson(dynamic json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(LibraryImages.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'] != "" ? json['from'] : 0;
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'] != "" ? json['to'] : 0;
    total = json['total'];
  }
  num? currentPage;
  List<LibraryImages>? data;
  String? firstPageUrl;
  num? from;
  num? lastPage;
  String? lastPageUrl;
  String? nextPageUrl;
  String? path;
  num? perPage;
  String? prevPageUrl;
  num? to;
  num? total;
LibraryResponse copyWith({  num? currentPage,
  List<LibraryImages>? data,
  String? firstPageUrl,
  num? from,
  num? lastPage,
  String? lastPageUrl,
  String? nextPageUrl,
  String? path,
  num? perPage,
  String? prevPageUrl,
  num? to,
  num? total,
}) => LibraryResponse(  currentPage: currentPage ?? this.currentPage,
  data: data ?? this.data,
  firstPageUrl: firstPageUrl ?? this.firstPageUrl,
  from: from ?? this.from,
  lastPage: lastPage ?? this.lastPage,
  lastPageUrl: lastPageUrl ?? this.lastPageUrl,
  nextPageUrl: nextPageUrl ?? this.nextPageUrl,
  path: path ?? this.path,
  perPage: perPage ?? this.perPage,
  prevPageUrl: prevPageUrl ?? this.prevPageUrl,
  to: to ?? this.to,
  total: total ?? this.total,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['current_page'] = currentPage;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['first_page_url'] = firstPageUrl;
    map['from'] = from;
    map['last_page'] = lastPage;
    map['last_page_url'] = lastPageUrl;
    map['next_page_url'] = nextPageUrl;
    map['path'] = path;
    map['per_page'] = perPage;
    map['prev_page_url'] = prevPageUrl;
    map['to'] = to;
    map['total'] = total;
    return map;
  }

}


