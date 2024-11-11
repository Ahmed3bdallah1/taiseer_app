class UserAuthResponseModel {
  String? token;
  UserModel? user;
  UserAuthResponseModel({required this.token, required this.user});
}

class UserModel {
  int? id;
  String? name;
  String? emailVerifiedAt;
  String? gender;
  String? email;
  String? phone;
  String? avtar;
  String? address;
  String? imageIdFront;
  String? imageIdBack;
  int? isVerified;
  String? birthday;
  int? status;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  UserModel(
      {this.id,
      this.name,
      this.emailVerifiedAt,
      this.gender,
      this.email,
      this.phone,
      this.avtar,
      this.address,
      this.imageIdFront,
      this.imageIdBack,
      this.isVerified,
      this.birthday,
      this.status,
      this.deletedAt,
      this.createdAt,
      this.updatedAt});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    emailVerifiedAt = json['email_verified_at'];
    gender = json['gender'];
    email = json['email'];
    phone = json['phone'];
    avtar = json['avtar'];
    address = json['address'];
    imageIdFront = json['image_id_front'];
    imageIdBack = json['image_id_back'];
    isVerified = json['is_verified'];
    birthday = json['birthday'];
    status = json['status'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email_verified_at'] = emailVerifiedAt;
    data['gender'] = gender;
    data['email'] = email;
    data['phone'] = phone;
    data['avtar'] = avtar;
    data['address'] = address;
    data['image_id_front'] = imageIdFront;
    data['image_id_back'] = imageIdBack;
    data['is_verified'] = isVerified;
    data['birthday'] = birthday;
    data['status'] = status;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
