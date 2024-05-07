import 'result.dart';

class PlansResponse {
  PlansResponse({
      this.status, 
      this.message, 
      this.result,});

  PlansResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    result = json['result'] != null ? DonglePlanResult.fromJson(json['result']) : null;
  }
  int? status;
  String? message;
  DonglePlanResult? result;

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