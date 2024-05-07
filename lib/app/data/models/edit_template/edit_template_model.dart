class EditTemplateModel {
  int? id;
  String? burgerPrice;
  String? discription;
  String? burgerIcon;
  String? burgerName;



  EditTemplateModel({
    this.id,
    this.burgerPrice,
    this.discription,
    this.burgerIcon,
    this.burgerName,

  });

  EditTemplateModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    burgerPrice = json['burgerPrice'] ?? '';
    discription = json['discription'] ?? '';
    burgerIcon = json['burgerIcon'] ?? '';
    burgerName = json['burgerName'] ?? '';

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['burgerPrice'] = burgerPrice;
    data['discription'] = discription;
    data['burgerIcon'] = burgerIcon;
    data['burgerName'] = burgerName;


    return data;
  }
}
