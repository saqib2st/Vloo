/// id : 8
/// sub_folder_id : 3
/// title : " sandwich2"
/// media_file : "https://vloo.6lgx.com/storage/vloo_library/Images/Sandwiches/f7d4d5d58efb59431701255969.jpg"
/// type : ""
/// is_active : 1
/// created_at : "2023-11-29T11:06:30.000000Z"
/// updated_at : "2023-11-29T11:06:30.000000Z"

class LibraryImages {
  LibraryImages({
      this.id, 
      this.subFolderId, 
      this.title, 
      this.mediaFile, 
      this.type, 
      this.isActive, 
      this.createdAt, 
      this.updatedAt,});

  LibraryImages.fromJson(dynamic json) {
    id = json['id'];
    subFolderId = json['sub_folder_id'];
    title = json['title'];
    mediaFile = json['media_file'];
    type = json['type'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  num? id;
  num? subFolderId;
  String? title;
  String? mediaFile;
  String? type;
  num? isActive;
  String? createdAt;
  String? updatedAt;
LibraryImages copyWith({  num? id,
  num? subFolderId,
  String? title,
  String? mediaFile,
  String? type,
  num? isActive,
  String? createdAt,
  String? updatedAt,
}) => LibraryImages(  id: id ?? this.id,
  subFolderId: subFolderId ?? this.subFolderId,
  title: title ?? this.title,
  mediaFile: mediaFile ?? this.mediaFile,
  type: type ?? this.type,
  isActive: isActive ?? this.isActive,
  createdAt: createdAt ?? this.createdAt,
  updatedAt: updatedAt ?? this.updatedAt,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['sub_folder_id'] = subFolderId;
    map['title'] = title;
    map['media_file'] = mediaFile;
    map['type'] = type;
    map['is_active'] = isActive;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}