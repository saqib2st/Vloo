import 'Result.dart';

class LoginResponse {
  LoginResponse({
      this.status, 
      this.message, 
      this.result,});

  LoginResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }
  int? status;
  String? message;
  Result? result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (result != null) {
      map['result'] = result!.toJson();
    }
    return map;
  }

}