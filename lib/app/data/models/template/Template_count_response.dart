
import 'package:vloo/app/data/models/template/Template_count_model.dart';

/// status : 200
/// message : "All Template Records"
/// result : [{"id":3,"user_id":1,"title":"Hello 8","feature_img":"https://vloo.6lgx.com/storage/images/templates/0_1689852693.jpg","currency":"$","currency_alignment":"Middle","description":"Hello sixlogics","background_color":"","background_image":"","orientation":"Portrait","is_locked":"Yes","created_at":"2023-07-20T11:31:33.000000Z","updated_at":"2023-07-20T11:31:33.000000Z","elements":[]},{"id":4,"user_id":1,"title":"Hello 8","feature_img":"https://vloo.6lgx.com/storage/images/templates/0_1689852980.jpg","currency":"$","currency_alignment":"Middle","description":"Hello sixlogics","background_color":"","background_image":"","orientation":"Portrait","is_locked":"Yes","created_at":"2023-07-20T11:36:20.000000Z","updated_at":"2023-07-20T11:36:20.000000Z","elements":[]}]

class TemplateCountResponse {
  TemplateCountResponse({
      num? status, 
      String? message,
    TemplateCountModel? result,}){
    status = status;
    message = message;
    result = result;
}

  TemplateCountResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['result'] != null) {
      result = TemplateCountModel.fromJson(json['result']);
    }
  }

  num? status;
  String? message;
  TemplateCountModel? result;

  TemplateCountResponse copyWith({  num? status,
  String? message,
    TemplateCountModel? result,
}) => TemplateCountResponse(  status: status ?? status,
  message: message ?? message,
  result: result ?? result,
);

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

