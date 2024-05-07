/// status : 200
/// message : "Reset password code sent successfully"
/// result : true
/// reset_password_code : 3604

class CommonResponse {
  CommonResponse({
      num? status, 
      String? message, 
      dynamic result,
      num? resetPasswordCode,}){
    _status = status;
    _message = message;
    _result = result;
    _resetPasswordCode = resetPasswordCode;
}

  CommonResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _result = json['result'];
    _resetPasswordCode = json['reset_password_code'];
  }
  num? _status;
  String? _message;
  dynamic _result;
  num? _resetPasswordCode;
CommonResponse copyWith({  num? status,
  String? message,
  dynamic result,
  num? resetPasswordCode,
}) => CommonResponse(  status: status ?? _status,
  message: message ?? _message,
  result: result ?? _result,
  resetPasswordCode: resetPasswordCode ?? _resetPasswordCode,
);
  num? get status => _status;
  String? get message => _message;
  dynamic get result => _result;
  num? get resetPasswordCode => _resetPasswordCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['result'] = _result;
    map['reset_password_code'] = _resetPasswordCode;
    return map;
  }

}