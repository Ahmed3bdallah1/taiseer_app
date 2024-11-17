import 'package:taiseer/gen/assets.gen.dart';

class CountryEntity {
  final int? id;
  final String? nameAr;
  final String? nameEn;

  // final String? countryCode;
  final String? countryImage;
  final int? numberLength;

  final List<CitesEntity>? cities;

  // final String? iso;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  CountryEntity({
    this.id,
    this.nameAr,
    this.nameEn,
    // this.countryCode,
    this.countryImage,
    this.numberLength,
    // this.iso,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.cities,
  });

  factory CountryEntity.fromJson(Map<String, dynamic> json) => CountryEntity(
        id: json["id"],
        nameAr: json["name_ar"],
        nameEn: json["name_en"],
        // countryCode: json["country_code"],
        countryImage: json["flag"],
        numberLength: json["number_length"],
        // iso: json["iso"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        cities: List<CitesEntity>.from(
            json["city"].map((x) => CitesEntity.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name_ar": nameAr,
        "name_en": nameAr,
        // "country_code": countryCode,
        "flag": countryImage,
        "number_length": numberLength,
        // "iso": iso,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "city": cities
      };
}

class CitesEntity {
  final int? id;
  final String? titleAr;
  final String? titleEn;
  final int? status;
  final int? countryId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  CitesEntity({
    this.id,
    this.titleAr,
    this.titleEn,
    this.status,
    this.countryId,
    this.createdAt,
    this.updatedAt,
  });

  factory CitesEntity.fromJson(Map<String, dynamic> json) => CitesEntity(
        id: json["id"],
        titleAr: json["title_ar"],
        titleEn: json["title_en"],
        status: json["status"],
        countryId: json["country_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title_ar": titleAr,
        "title_en": titleEn,
        "status": status,
        "country_id": countryId,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}

final countries = [
  CountryEntity(
    id: 1,
    nameAr: 'Egypt',
    // countryCode: 'EG',
    countryImage: Assets.onboard.flag.path,
    numberLength: 11,
    // iso: 'EGY',
    status: 1,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  CountryEntity(
    id: 2,
    nameAr: 'United States',
    // countryCode: 'US',
    numberLength: 10,
    countryImage: Assets.onboard.usa.path,
    // iso: 'USA',
    status: 1,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  CountryEntity(
    id: 3,
    nameAr: 'Kuwait',
    // countryCode: 'KW',
    countryImage: Assets.onboard.kawuit.path,
    numberLength: 9,
    // iso: 'KW',
    status: 1,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  )
];
