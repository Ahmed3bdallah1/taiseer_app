class Address {
  final int? id;
  final int? userId;
  final String? addressLine;
  final int? cityId;
  final int? countryId;
  final String? area;
  final String? latitude;
  final String? longitude;
  final String? createdAt;
  final String? updatedAt;

  Address({
    this.id,
    this.userId,
    this.addressLine,
    this.cityId,
    this.countryId,
    this.area,
    this.latitude,
    this.longitude,
    this.createdAt,
    this.updatedAt,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    id: json["id"],
    userId: json["user_id"],
    addressLine: json["address_line"],
    cityId: json["city_id"],
    countryId: json["country_id"],
    area: json["area"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "address_line": addressLine,
    "city_id": cityId,
    "country_id": countryId,
    "area": area,
    "latitude": latitude,
    "longitude": longitude,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}