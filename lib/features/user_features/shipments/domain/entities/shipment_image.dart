class ShipmentImage {
  final int? id;
  final String? image;
  final int? shipmentId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ShipmentImage({
    this.id,
    this.image,
    this.shipmentId,
    this.createdAt,
    this.updatedAt,
  });

  factory ShipmentImage.fromJson(Map<String, dynamic> json) => ShipmentImage(
    id: json["id"],
    image: json["image"],
    shipmentId: json["shipment_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "shipment_id": shipmentId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}