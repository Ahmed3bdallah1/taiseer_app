import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taiseer/gen/assets.gen.dart';

class ShippingMethodsEntity {
  final int id;
  final int companyId;
  final int? typeActivityId;
  final String? infoAr;
  final String? infoEn;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final TypeActivities? typeActivities;

  ShippingMethodsEntity({
    required this.id,
    required this.companyId,
    this.typeActivityId,
    this.infoAr,
    this.infoEn,
    this.createdAt,
    this.updatedAt,
    this.typeActivities,
  });

  factory ShippingMethodsEntity.fromJson(Map<String, dynamic> json) => ShippingMethodsEntity(
    id: json["id"],
    companyId: json["company_id"],
    typeActivityId: json["type_activity_id"],
    infoAr: json["info_ar"],
    infoEn: json["info_en"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    typeActivities: TypeActivities.fromJson(json["type_activities"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "company_id": companyId,
    "type_activity_id": typeActivityId,
    "info_ar": infoAr,
    "info_en": infoEn,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "type_activities": typeActivities!.toJson(),
  };
}

class TypeActivities {
  final int id;
  final String? nameAr;
  final String? nameEn;
  final String? imageFront;
  final String? imageBack;
  final String? infoAr;
  final String? infoEn;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  TypeActivities({
    required this.id,
    this.nameAr,
    this.nameEn,
    this.imageFront,
    this.imageBack,
    this.infoAr,
    this.infoEn,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory TypeActivities.fromJson(Map<String, dynamic> json) => TypeActivities(
    id: json["id"],
    nameAr: json["name_ar"],
    nameEn: json["name_en"],
    imageFront: json["image_front"],
    imageBack: json["image_back"],
    infoAr: json["info_ar"],
    infoEn: json["info_en"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name_ar": nameAr,
    "name_en": nameEn,
    "image_front": imageFront,
    "image_back": imageBack,
    "info_ar": infoAr,
    "info_en": infoEn,
    "status": status,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}

// class ShippingMethodsEntity {
//   final int? id;
//   final String? name;
//   final String? backgroundImage;
//   final IconData? icon;
//
//   ShippingMethodsEntity({
//     required this.id,
//     required this.name,
//     required this.backgroundImage,
//     required this.icon,
//   });
//
//   factory ShippingMethodsEntity.fromJson(Map<String, dynamic> json) {
//     return ShippingMethodsEntity(
//       id: json['id'],
//       name: json['name'],
//       backgroundImage: json["background_image"],
//       icon: json["icon"],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       "id": id,
//       'name': name,
//       'background_image': backgroundImage,
//       'icon': icon,
//     };
//   }
// }
//
// List<ShippingMethodsEntity> shippingMethods = [
//   ShippingMethodsEntity(
//     id: 1,
//     companyId:2,
//     typeActivities: TypeActivities(id: 1,nameAr: ),
//     backgroundImage: Assets.base.background.path,
//     icon: Icons.directions_boat_filled_outlined,
//   ),
//   ShippingMethodsEntity(
//     id: 2,
//     name: 'تريلا',
//     backgroundImage: Assets.base.background.path,
//     icon: Icons.local_shipping_outlined,
//   ),
//   ShippingMethodsEntity(
//     id: 3,
//     name: 'جوى',
//     backgroundImage: Assets.base.background.path,
//     icon: Icons.flight_takeoff,
//   ),
//   ShippingMethodsEntity(
//     id: 4,
//     name: 'برى',
//     backgroundImage: Assets.base.background.path,
//     icon: CupertinoIcons.car_detailed,
//   ),
//   ShippingMethodsEntity(
//     id: 5,
//     name: 'شحن سريع',
//     backgroundImage: Assets.base.background.path,
//     icon: Icons.flash_auto_sharp,
//   ),
// ];
