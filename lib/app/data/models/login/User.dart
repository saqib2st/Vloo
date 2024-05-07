class User {
  User({
      this.id, 
      this.email, 
      this.phoneNumber, 
      this.firstName, 
      this.city, 
      this.postCode, 
      this.language, 
      this.companyName, 
      this.companyCity, 
      this.useType, 
      this.deletedAt, 
      this.createdAt, 
      this.updatedAt,
      this.countryCode,
      this.country,
      this.dialCode,
  });

  User.fromJson(dynamic json) {
    id = json['id'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    firstName = json['first_name'];
    city = json['city'];
    postCode = json['post_code'];
    language = json['language'];
    companyName = json['company_name'];
    companyCity = json['company_city'];
    useType = json['use_type'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    countryCode = json['country_code'];
    country = json['country'];
    dialCode = json['dial_code'];
  }
  int? id;
  String? email;
  String? phoneNumber;
  String? firstName;
  String? city;
  String? postCode;
  String? language;
  String? companyName;
  String? companyCity;
  String? useType;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  String? countryCode;
  String? country;
  String? dialCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['email'] = email;
    map['phone_number'] = phoneNumber;
    map['first_name'] = firstName;
    map['city'] = city;
    map['post_code'] = postCode;
    map['language'] = language;
    map['company_name'] = companyName;
    map['company_city'] = companyCity;
    map['use_type'] = useType;
    map['deleted_at'] = deletedAt;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['country_code'] = countryCode;
    map['country'] = country;
    map['dial_code'] = dialCode;
    return map;
  }

}