import 'dart:ui';

import 'package:get/get.dart';
import 'package:vloo/app/data/models/error/error_response.dart';
import 'package:vloo/app/data/models/login/User.dart';
import 'package:vloo/app/data/models/user_subscription_plan/user_subscription_item.dart';

class Singleton {
  static String token = "";
  static Map<String, String> header = {"Authorization": "Bearer $token" /*, "Content-Type": "application/json", "Accept": "application/json",*/};

  static User? userObject;
  static String? apiMessage;
  static ErrorResponse? errorResponse = ErrorResponse();

  static String? email;
  static num? code;

  static RxBool isAPILoading = false.obs;

  // Templates create
  static RxString orientation = "".obs;
  static RxString? currency = "".obs;
  static Rx<Locale> localeValue = const Locale("en").obs;

  static UserSubscriptionPlanItem? screenPlan;
  static UserSubscriptionPlanItem? storagePlan;
  static UserSubscriptionPlanItem? donglePlan;

  static String comingFrom = "";
}
