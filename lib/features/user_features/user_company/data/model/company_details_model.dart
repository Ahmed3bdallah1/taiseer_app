import 'package:taiseer/features/user_features/user_company/domain/entity/comment_entity.dart';
import 'package:taiseer/features/user_features/user_company/domain/entity/shipping_methods_entity.dart';

class CompanyDetailsModel {
  final int id;
  final String nameAr;
  final String nameEn;
  final String email;
  final String code;
  final String phone;
  final String bl;
  final String blImage;
  final String idFrontImage;
  final String aboutAr;
  final String aboutEn;
  final int companyStatusId;
  final String logo;
  final String cover;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int followersCount;
  final int averageRating;
  final List<ShippingMethodsEntity> typeActivityCompanies;
  final List<CommentsEntity> rating;

  CompanyDetailsModel({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.email,
    required this.code,
    required this.phone,
    required this.bl,
    required this.blImage,
    required this.idFrontImage,
    required this.aboutAr,
    required this.aboutEn,
    required this.companyStatusId,
    required this.logo,
    required this.cover,
    required this.createdAt,
    required this.updatedAt,
    required this.followersCount,
    required this.averageRating,
    required this.typeActivityCompanies,
    required this.rating,
  });

  factory CompanyDetailsModel.fromJson(Map<String, dynamic> json) => CompanyDetailsModel(
    id: json["id"],
    nameAr: json["name_ar"],
    nameEn: json["name_en"],
    email: json["email"],
    code: json["code"],
    phone: json["phone"],
    bl: json["BL"],
    blImage: json["BL_image"],
    idFrontImage: json["id_front_image"],
    aboutAr: json["about_ar"],
    aboutEn: json["about_en"],
    companyStatusId: json["company_status_id"],
    logo: json["logo"],
    cover: json["cover"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    followersCount: json["followers_count"],
    averageRating: json["average_rating"],
    typeActivityCompanies: List<ShippingMethodsEntity>.from(json["type_activity_companies"].map((x) => ShippingMethodsEntity.fromJson(x))),
    rating: List<CommentsEntity>.from(json["rating"].map((x) => CommentsEntity.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name_ar": nameAr,
    "name_en": nameEn,
    "email": email,
    "code": code,
    "phone": phone,
    "BL": bl,
    "BL_image": blImage,
    "id_front_image": idFrontImage,
    "about_ar": aboutAr,
    "about_en": aboutEn,
    "company_status_id": companyStatusId,
    "logo": logo,
    "cover": cover,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "followers_count": followersCount,
    "average_rating": averageRating,
    "type_activity_companies": List<dynamic>.from(typeActivityCompanies.map((x) => x.toJson())),
    "rating": List<dynamic>.from(rating.map((x) => x.toJson())),
  };
}