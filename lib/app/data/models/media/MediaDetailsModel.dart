/// id : 82
/// url : "https://vloo.6lgx.com/media/user_16/1703344259196dcd954997e393.mp4"
/// thumbnail : "https://vloo.6lgx.com/media/user_16/thumbnail_1703344259.jpg"
/// name : "video test 13"
/// duration : "0:15"
/// size : "492.45 KB"
/// Add the : "23/12/2023"
/// format : "Video MP4 (640x360)"
/// screens : ["new screen","qwerry1","mine"]
/// status : "On broadcast"

class MediaDetailsModel {
  MediaDetailsModel({
      this.id, 
      this.url, 
      this.thumbnail, 
      this.name, 
      this.duration, 
      this.size, 
      this.addthe, 
      this.format, 
      this.screens,
      this.status,});

  MediaDetailsModel.fromJson(dynamic json) {
    id = json['id'];
    url = json['url'];
    thumbnail = json['thumbnail'];
    name = json['name'];
    duration = json['duration'];
    size = json['size'];
    addthe = json['Add the'];
    format = json['format'];
    if(json['screens'] == null){
      screens=[];
    }
    else{
      json['screens'].forEach((element){
        screens?.add(element);
      });
    }
    status = json['status'];
  }
  num? id;
  String? url;
  String? thumbnail;
  String? name;
  String? duration;
  String? size;
  String? addthe;
  String? format;
  List<String?>? screens = [];
  String? status;
MediaDetailsModel copyWith({  num? id,
  String? url,
  String? thumbnail,
  String? name,
  String? duration,
  String? size,
  String? addthe,
  String? format,
  List<String>? screens,
  String? status,
}) => MediaDetailsModel(  id: id ?? this.id,
  url: url ?? this.url,
  thumbnail: thumbnail ?? this.thumbnail,
  name: name ?? this.name,
  duration: duration ?? this.duration,
  size: size ?? this.size,
  addthe: addthe ?? this.addthe,
  format: format ?? this.format,
  screens: screens ?? this.screens,
  status: status ?? this.status,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['url'] = url;
    map['thumbnail'] = thumbnail;
    map['name'] = name;
    map['duration'] = duration;
    map['size'] = size;
    map['Add the'] = addthe;
    map['format'] = format;
    map['screens'] = screens;
    map['status'] = status;
    return map;
  }

}