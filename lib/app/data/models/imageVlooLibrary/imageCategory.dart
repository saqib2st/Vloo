/// folder_id : 2
/// title : "Neon"

class ImageCategory {
  ImageCategory({
      this.folderId, 
      this.title,});

  ImageCategory.fromJson(dynamic json) {
    folderId = json['folder_id'];
    title = json['title'];
  }
  num? folderId;
  String? title;
ImageCategory copyWith({  num? folderId,
  String? title,
}) => ImageCategory(  folderId: folderId ?? this.folderId,
  title: title ?? this.title,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['folder_id'] = folderId;
    map['title'] = title;
    return map;
  }

}