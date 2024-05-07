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

import 'package:vloo/app/data/models/plans/plan.dart';

class UserSubscriptionPlanItem {
  UserSubscriptionPlanItem({
    this.id,
    this.userId,
    this.planId,
    this.planName,
    this.totalPrice,
    this.currency,
    this.paymentStatus,
    this.paymentMethod,
    this.type,
    this.startDate,
    this.expiryDate,
    this.createdAt,
    this.updatedAt,
    this.isActive,
    this.plan,
  });

  UserSubscriptionPlanItem.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    planId = json['plan_id'].toString();
    planName = json['plan_name'];
    totalPrice = json['total_price'].toString();
    currency = json['currency'];
    paymentStatus = json['payment_status'];
    paymentMethod = json['payment_method'];
    type = json['type'];
    startDate = json['start_date'];
    expiryDate = json['expiry_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isActive = json['is_active'];
    plan = json['plan'] != null ? Plan.fromJson(json['plan']) : null;
  }
  int? id;
  num? userId;
  String? planId;
  String? planName;
  String? totalPrice;
  String? currency;
  String? paymentStatus;
  String? paymentMethod;
  String? type;
  String? startDate;
  String? expiryDate;
  String? createdAt;
  String? updatedAt;
  num? isActive;
  Plan? plan;
  UserSubscriptionPlanItem copyWith({
    int? id,
    num? userId,
    String? planId,
    String? planName,
    String? totalPrice,
    String? currency,
    String? paymentStatus,
    String? paymentMethod,
    String? type,
    String? startDate,
    String? expiryDate,
    String? createdAt,
    String? updatedAt,
    num? isActive,
    Plan? plan,
  }) =>
      UserSubscriptionPlanItem(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        planId: planId ?? this.planId,
        planName: planName ?? this.planName,
        totalPrice: totalPrice ?? this.totalPrice,
        currency: currency ?? this.currency,
        paymentStatus: paymentStatus ?? this.paymentStatus,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        type: type ?? this.type,
        startDate: startDate ?? this.startDate,
        expiryDate: expiryDate ?? this.expiryDate,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        isActive: isActive ?? this.isActive,
        plan: plan ?? this.plan,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['plan_id'] = planId;
    map['plan_name'] = planName;
    map['total_price'] = totalPrice;
    map['currency'] = currency;
    map['payment_status'] = paymentStatus;
    map['payment_method'] = paymentMethod;
    map['type'] = type;
    map['start_date'] = startDate;
    map['expiry_date'] = expiryDate;
    map['created_at'] = expiryDate;
    map['updated_at'] = expiryDate;
    map['is_active'] = isActive;
    if (plan != null) {
      map['plan'] = plan?.toJson();
    }
    return map;
  }
}
