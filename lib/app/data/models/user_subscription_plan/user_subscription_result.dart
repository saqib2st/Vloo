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

import 'package:vloo/app/data/models/user_subscription_plan/user_subscription_item.dart';

class UserSubscriptionPlanResult {
  UserSubscriptionPlanResult({
    this.screenPlan,
    this.storagePlan,
    this.donglePlan,
  });

  UserSubscriptionPlanResult.fromJson(dynamic json) {
    screenPlan = json['Screen'] != null
        ? UserSubscriptionPlanItem.fromJson(json['Screen'])
        : null;
    storagePlan = json['Storage'] != null
        ? UserSubscriptionPlanItem.fromJson(json['Storage'])
        : null;
    donglePlan = json['Dongle'] != null
        ? UserSubscriptionPlanItem.fromJson(json['Dongle'])
        : null;
  }
  UserSubscriptionPlanItem? screenPlan;
  UserSubscriptionPlanItem? storagePlan;
  UserSubscriptionPlanItem? donglePlan;

  UserSubscriptionPlanResult copyWith({
    UserSubscriptionPlanItem? screenPlan,
    UserSubscriptionPlanItem? storagePlan,
    UserSubscriptionPlanItem? donglePlan,
  }) =>
      UserSubscriptionPlanResult(
        screenPlan: screenPlan ?? this.screenPlan,
        storagePlan: storagePlan ?? this.storagePlan,
        donglePlan: donglePlan ?? this.donglePlan,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Screen'] = screenPlan;
    map['Storage'] = storagePlan;
    map['Dongle'] = donglePlan;

    return map;
  }
}
