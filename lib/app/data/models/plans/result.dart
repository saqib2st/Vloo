import 'plan.dart';

class DonglePlanResult {
  DonglePlanResult({
      this.plan, 
      this.donglePrice, 
      this.deliveryTime, 
      this.deliveryFee, 
      this.vat,});

  DonglePlanResult.fromJson(dynamic json) {
    plan = json['plan'] != null ? Plan.fromJson(json['plan']) : null;
    donglePrice = json['donglePrice'] != null ? double.tryParse(json['donglePrice'].toString()) : 0.0;
    deliveryTime = json['deliveryTime'];
    deliveryFee = json['deliveryFee'] != null ? double.tryParse(json['deliveryFee'].toString()) : 0.0;
    vat = json['vat'] != null ? double.tryParse(json['vat'].toString()) : 0.0;
  }
  Plan? plan;
  double? donglePrice;
  String? deliveryTime;
  double? deliveryFee;
  double? vat;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (plan != null) {
      map['plan'] = plan?.toJson();
    }
    map['donglePrice'] = donglePrice;
    map['deliveryTime'] = deliveryTime;
    map['deliveryFee'] = deliveryFee;
    map['vat'] = vat;
    return map;
  }

}