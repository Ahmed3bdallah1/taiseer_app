import 'package:learning/gen/assets.gen.dart';

class CountryEntity {
  final int? id;
  final String? title;
  final String? countryCode;
  final String? countryImage;
  final int? numberLength;
  final String? iso;
  final int? status;
  final dynamic? createdAt;
  final dynamic? updatedAt;

  CountryEntity({
    this.id,
    this.title,
    this.countryCode,
    this.countryImage,
    this.numberLength,
    this.iso,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory CountryEntity.fromJson(Map<String, dynamic> json) => CountryEntity(
        id: json["id"],
        title: json["title"],
        countryCode: json["country_code"],
        countryImage: json["country_image"],
        numberLength: json["number_length"],
        iso: json["iso"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "country_code": countryCode,
        "country_image": countryImage,
        "number_length": numberLength,
        "iso": iso,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

final countries = [
  CountryEntity(
    id: 1,
    title: 'Egypt',
    countryCode: 'EG',
    countryImage: Assets.onboard.flag.path,
    numberLength: 11,
    iso: 'EGY',
    status: 1,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  CountryEntity(
    id: 2,
    title: 'United States',
    countryCode: 'US',
    numberLength: 10,
    countryImage: Assets.onboard.usa.path,
    iso: 'USA',
    status: 1,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  CountryEntity(
    id: 3,
    title: 'Kuwait',
    countryCode: 'KW',
    countryImage: Assets.onboard.kawuit.path,
    numberLength: 9,
    iso: 'KW',
    status: 1,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  )
];
