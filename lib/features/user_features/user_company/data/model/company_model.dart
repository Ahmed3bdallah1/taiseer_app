import 'package:taiseer/features/user_features/home/domain/entities/ad_entity.dart';
import '../../../../../gen/assets.gen.dart';
import '../../domain/entity/attributes_entity.dart';
import '../../domain/entity/comment_entity.dart';
import '../../domain/entity/shipping_methods_entity.dart';

class UserCompanyModel2 {
  final int id;
  final String nameAr;
  final String nameEn;
  final String? email;
  final String? code;
  final String? phone;
  final String? bl;
  final String? blImage;
  final String? idFrontImage;
  final String? aboutAr;
  final String? aboutEn;
  final int? companyStatusId;
  final String? logo;
  final String? cover;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? followersCount;
  final String? ratingAvgRate;
  final double? averageRating;
  final List<ShippingMethodsEntity> typeActivityCompanies;

  UserCompanyModel2({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    this.email,
    this.code,
    this.phone,
    this.bl,
    this.blImage,
    this.idFrontImage,
    this.aboutAr,
    this.aboutEn,
    this.companyStatusId,
    this.logo,
    this.cover,
    this.createdAt,
    this.updatedAt,
    this.followersCount,
    this.ratingAvgRate,
    this.averageRating,
    required this.typeActivityCompanies,
  });

  factory UserCompanyModel2.fromJson(Map<String, dynamic> json) => UserCompanyModel2(
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
    ratingAvgRate: json["rating_avg_rate"],
    averageRating: (json["average_rating"]?? 0 ).toDouble(),
    typeActivityCompanies: List<ShippingMethodsEntity>.from(json["type_activity_companies"].map((x) => ShippingMethodsEntity.fromJson(x))),
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
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "followers_count": followersCount,
    "rating_avg_rate": ratingAvgRate,
    "average_rating": averageRating??0.0,
    "type_activity_companies": List<dynamic>.from(typeActivityCompanies.map((x) => x.toJson())),
  };
}