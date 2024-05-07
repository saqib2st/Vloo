import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CurrencyModel {
  int? id;
  String? countryCode;
  String? countryName;
  String? currencySymbol;
  RxBool? isSelectedCurrency =false.obs;

  CurrencyModel(
      {this.id,
      this.countryCode,
      this.countryName,
      this.currencySymbol,
      this.isSelectedCurrency});

  CurrencyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryCode = json['countryCode'] = '';
    countryName = json['countryName'] ?? '';
    currencySymbol = json['currencySymbol'] ?? '';
    isSelectedCurrency?.value = json['isSelectedCurrency'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['countryCode'] = countryCode;
    data['countryName'] = countryName;
    data['currencySymbol'] = currencySymbol;
    data['isSelectedCurrency'] = isSelectedCurrency?.value;
    return data;
  }
}
