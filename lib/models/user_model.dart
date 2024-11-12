class UserAuthResponseModel {
  String? token;
  UserModel? user;
  UserAuthResponseModel({required this.token, required this.user});
}

class UserModel {
  final int id;
  final String? name;
  final String? email;
  final String? phone;
  final DateTime? emailVerifiedAt;
  final String? photo;
  final int? permissionsId;
  final int? status;
  final dynamic connectEmail;
  final dynamic connectPassword;
  final dynamic provider;
  final int? providerId;
  final String? accessToken;
  final int? createdBy;
  final int? updatedBy;
  final int? currentTeamId;
  final String? profilePhotoPath;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? userType;
  final int? companyId;
  final String? profilePhotoUrl;

  UserModel({
    required this.id,
    this.name,
    this.email,
    this.phone,
    this.emailVerifiedAt,
    this.photo,
    this.permissionsId,
    this.status,
    this.connectEmail,
    this.connectPassword,
    this.provider,
    this.providerId,
    this.accessToken,
    this.createdBy,
    this.updatedBy,
    this.currentTeamId,
    this.profilePhotoPath,
    this.createdAt,
    this.updatedAt,
    this.userType,
    this.companyId,
    this.profilePhotoUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    emailVerifiedAt: json["email_verified_at"],
    photo: json["photo"],
    permissionsId: json["permissions_id"],
    status: json["status"],
    connectEmail: json["connect_email"],
    connectPassword: json["connect_password"],
    provider: json["provider"],
    providerId: json["provider_id"],
    accessToken: json["access_token"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    currentTeamId: json["current_team_id"],
    profilePhotoPath: json["profile_photo_path"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    userType: json["user_type"],
    companyId: json["company_id"],
    profilePhotoUrl: json["profile_photo_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "email_verified_at": emailVerifiedAt,
    "photo": photo,
    "permissions_id": permissionsId,
    "status": status,
    "connect_email": connectEmail,
    "connect_password": connectPassword,
    "provider": provider,
    "provider_id": providerId,
    "access_token": accessToken,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "current_team_id": currentTeamId,
    "profile_photo_path": profilePhotoPath,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "user_type": userType,
    "company_id": companyId,
    "profile_photo_url": profilePhotoUrl,
  };
}

// class UserModel {
//   int? id;
//   String? name;
//   String? emailVerifiedAt;
//   String? gender;
//   String? email;
//   String? phone;
//   String? avtar;
//   String? address;
//   String? imageIdFront;
//   String? imageIdBack;
//   int? isVerified;
//   String? birthday;
//   int? status;
//   String? deletedAt;
//   String? createdAt;
//   String? updatedAt;
//
//   UserModel(
//       {this.id,
//       this.name,
//       this.emailVerifiedAt,
//       this.gender,
//       this.email,
//       this.phone,
//       this.avtar,
//       this.address,
//       this.imageIdFront,
//       this.imageIdBack,
//       this.isVerified,
//       this.birthday,
//       this.status,
//       this.deletedAt,
//       this.createdAt,
//       this.updatedAt});
//
//   UserModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     emailVerifiedAt = json['email_verified_at'];
//     gender = json['gender'];
//     email = json['email'];
//     phone = json['phone'];
//     avtar = json['avtar'];
//     address = json['address'];
//     imageIdFront = json['image_id_front'];
//     imageIdBack = json['image_id_back'];
//     isVerified = json['is_verified'];
//     birthday = json['birthday'];
//     status = json['status'];
//     deletedAt = json['deleted_at'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['name'] = name;
//     data['email_verified_at'] = emailVerifiedAt;
//     data['gender'] = gender;
//     data['email'] = email;
//     data['phone'] = phone;
//     data['avtar'] = avtar;
//     data['address'] = address;
//     data['image_id_front'] = imageIdFront;
//     data['image_id_back'] = imageIdBack;
//     data['is_verified'] = isVerified;
//     data['birthday'] = birthday;
//     data['status'] = status;
//     data['deleted_at'] = deletedAt;
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     return data;
//   }
// }
