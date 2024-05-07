import 'package:vloo/app/data/models/media/MediaModel.dart';

/// id : 1
/// user_id : 16
/// title : "Test Screen 1"
/// date_of_first_connection : "2023-10-09"
/// orientation : "Landscape"
/// status : "Connected"
/// created_at : "2023-10-02T16:07:57.000000Z"
/// updated_at : "2023-10-02T16:07:57.000000Z"
/// screenContents : []

class ScreenModel {
  ScreenModel({
      num? id, 
      num? userId, 
      String? title, 
      String? dateOfFirstConnection, 
      String? orientation, 
      String? status, 
      String? createdAt, 
      String? updatedAt, 
      List<dynamic>? uploadMedias,}){
    id = id;
    userId = userId;
    title = title;
    dateOfFirstConnection = dateOfFirstConnection;
    orientation = orientation;
    status = status;
    createdAt = createdAt;
    updatedAt = updatedAt;
    uploadMedias = uploadMedias;
}

  ScreenModel.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    dateOfFirstConnection = json['date_of_first_connection'];
    orientation = json['orientation'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['uploadMedias'] != null) {
      uploadMedias = [];
      json['uploadMedias'].forEach((v) {
        // if (v['is_template'] == true) {
        //   uploadMedias?.add(TemplateModel.fromJson(v));
        // } else {
          uploadMedias?.add(MediaModel.fromJson(v));
        // }
      });
    }
  }
  num? id;
  num? userId;
  String? title;
  String? dateOfFirstConnection;
  String? orientation;
  String? status;
  String? createdAt;
  String? updatedAt;
  List<dynamic>? uploadMedias;                 //TODO: change int with original model when available
ScreenModel copyWith({  num? id,
  num? userId,
  String? title,
  String? dateOfFirstConnection,
  String? orientation,
  String? status,
  String? createdAt,
  String? updatedAt,
  List<dynamic>? uploadMedias,
}) => ScreenModel(  id: id ?? id,
  userId: userId ?? userId,
  title: title ?? title,
  dateOfFirstConnection: dateOfFirstConnection ?? dateOfFirstConnection,
  orientation: orientation ?? orientation,
  status: status ?? status,
  createdAt: createdAt ?? createdAt,
  updatedAt: updatedAt ?? updatedAt,
  uploadMedias: uploadMedias ?? uploadMedias,
);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['title'] = title;
    map['date_of_first_connection'] = dateOfFirstConnection;
    map['orientation'] = orientation;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (uploadMedias != null) {
       map['uploadMedias'] = uploadMedias?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}