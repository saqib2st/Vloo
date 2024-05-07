import 'package:vloo/app/data/models/buy_storage/buy_storage_result.dart';

/// status : 200
/// message : "Order patch successfully"
/// result : {"plan_id":"14","payment_status":"Paid","payment_method":"Stripe","type":"Storage","total_price":"2.99","user_id":16,"is_active":1,"start_date":"2024-02-07 09:51:05","expiry_date":"2023-08-05 12:26:23","plan_name":"5GB/Month","currency":"$"}

class BuyStorageResponse {
  BuyStorageResponse({
      this.status, 
      this.message, 
      this.result,});

  BuyStorageResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    result = json['result'] != null ? BuyStorageResult.fromJson(json['result']) : null;
  }
  num? status;
  String? message;
  BuyStorageResult? result;
BuyStorageResponse copyWith({  num? status,
  String? message,
  BuyStorageResult? result,
}) => BuyStorageResponse(  status: status ?? this.status,
  message: message ?? this.message,
  result: result ?? this.result,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (result != null) {
      map['result'] = result?.toJson();
    }
    return map;
  }

}