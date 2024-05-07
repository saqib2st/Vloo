/// plan_id : "14"
/// payment_status : "Paid"
/// payment_method : "Stripe"
/// type : "Storage"
/// total_price : "2.99"
/// user_id : 16
/// is_active : 1
/// start_date : "2024-02-07 09:51:05"
/// expiry_date : "2023-08-05 12:26:23"
/// plan_name : "5GB/Month"
/// currency : "$"
library;

class BuyStorageResult {
  BuyStorageResult({
    this.planId,
    this.paymentStatus,
    this.paymentMethod,
    this.type,
    this.totalPrice,
    this.userId,
    this.isActive,
    this.startDate,
    this.expiryDate,
    this.planName,
    this.currency,
  });

  BuyStorageResult.fromJson(dynamic json) {
    planId = json['plan_id'].toString();
    paymentStatus = json['payment_status'];
    paymentMethod = json['payment_method'];
    type = json['type'];
    totalPrice = json['total_price'].toString();
    userId = json['user_id'];
    isActive = json['is_active'];
    startDate = json['start_date'];
    expiryDate = json['expiry_date'];
    planName = json['plan_name'];
    currency = json['currency'];
  }
  String? planId;
  String? paymentStatus;
  String? paymentMethod;
  String? type;
  String? totalPrice;
  num? userId;
  num? isActive;
  String? startDate;
  String? expiryDate;
  String? planName;
  String? currency;
  BuyStorageResult copyWith({
    String? planId,
    String? paymentStatus,
    String? paymentMethod,
    String? type,
    String? totalPrice,
    num? userId,
    num? isActive,
    String? startDate,
    String? expiryDate,
    String? planName,
    String? currency,
  }) =>
      BuyStorageResult(
        planId: planId ?? this.planId,
        paymentStatus: paymentStatus ?? this.paymentStatus,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        type: type ?? this.type,
        totalPrice: totalPrice ?? this.totalPrice,
        userId: userId ?? this.userId,
        isActive: isActive ?? this.isActive,
        startDate: startDate ?? this.startDate,
        expiryDate: expiryDate ?? this.expiryDate,
        planName: planName ?? this.planName,
        currency: currency ?? this.currency,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['plan_id'] = planId;
    map['payment_status'] = paymentStatus;
    map['payment_method'] = paymentMethod;
    map['type'] = type;
    map['total_price'] = totalPrice;
    map['user_id'] = userId;
    map['is_active'] = isActive;
    map['start_date'] = startDate;
    map['expiry_date'] = expiryDate;
    map['plan_name'] = planName;
    map['currency'] = currency;
    return map;
  }
}
