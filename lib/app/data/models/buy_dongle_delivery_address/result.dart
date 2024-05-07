class Result {
  Result({
      this.userId, 
      this.planId, 
      this.planName, 
      this.totalPrice, 
      this.currency, 
      this.paymentStatus, 
      this.paymentMethod, 
      this.type, 
      this.isActive, 
      this.updatedAt, 
      this.createdAt,
      this.startDate,
      this.expiryDate,
      this.id,});

  Result.fromJson(dynamic json) {
    userId = json['user_id'];
    planId = json['plan_id'];
    planName = json['plan_name'];
    totalPrice = json['total_price'];
    currency = json['currency'];
    paymentStatus = json['payment_status'];
    paymentMethod = json['payment_method'];
    type = json['type'];
    isActive = json['is_active'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    startDate = json['start_date'];
    expiryDate = json['expiry_date'];
    id = json['id'];
  }
  int? userId;
  int? planId;
  String? planName;
  int? totalPrice;
  String? currency;
  String? paymentStatus;
  String? paymentMethod;
  String? type;
  int? isActive;
  String? updatedAt;
  String? createdAt;
  String? startDate;
  String? expiryDate;
  int? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = userId;
    map['plan_id'] = planId;
    map['plan_name'] = planName;
    map['total_price'] = totalPrice;
    map['currency'] = currency;
    map['payment_status'] = paymentStatus;
    map['payment_method'] = paymentMethod;
    map['type'] = type;
    map['is_active'] = isActive;
    map['updated_at'] = updatedAt;
    map['created_at'] = createdAt;
    map['start_date'] = startDate;
    map['expiry_date'] = expiryDate;
    map['id'] = id;
    return map;
  }

}