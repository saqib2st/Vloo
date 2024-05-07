

class Plan {
  Plan({
      this.id, 
      this.title, 
      this.duration, 
      this.fee, 
      this.currency, 
      this.type, 
      this.description, 
      this.createdAt, 
      this.updatedAt,});

  Plan.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    duration = json['duration'];
    fee = json['fee'] != null ? double.tryParse(json['fee'].toString()) : 0.0;
    currency = json['currency'];
    type = json['type'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  String? title;
  String? duration;
  double? fee;
  String? currency;
  String? type;
  String? description;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['duration'] = duration;
    map['fee'] = fee;
    map['currency'] = currency;
    map['type'] = type;
    map['description'] = description;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}