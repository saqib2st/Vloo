/// files : 3
/// totalSpace : 10
/// percentage : "0.007"
/// usedSpace : "758.2 KB"

class UsedStorageModel {
  UsedStorageModel({
      this.files, 
      this.totalSpace, 
      this.percentage, 
      this.usedSpace,});

  UsedStorageModel.fromJson(dynamic json) {
    files = json['files'];
    totalSpace = json['totalSpace'];
    percentage = json['percentage'];
    usedSpace = json['usedSpace'];
  }
  num? files;
  num? totalSpace;
  String? percentage;
  String? usedSpace;
UsedStorageModel copyWith({  num? files,
  num? totalSpace,
  String? percentage,
  String? usedSpace,
}) => UsedStorageModel(  files: files ?? this.files,
  totalSpace: totalSpace ?? this.totalSpace,
  percentage: percentage ?? this.percentage,
  usedSpace: usedSpace ?? this.usedSpace,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['files'] = files;
    map['totalSpace'] = totalSpace;
    map['percentage'] = percentage;
    map['usedSpace'] = usedSpace;
    return map;
  }

}