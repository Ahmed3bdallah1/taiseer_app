import 'package:taiseer/features/user_features/user_company/data/model/company_model.dart';
import 'package:taiseer/models/user_model.dart';
import '../../domain/entities/address.dart';

class ShipmentPaginationModel {
  final int currentPage;
  final List<ShipmentModel> data;
  final int perPage;
  final int total;
  final int lastPage;

  ShipmentPaginationModel({
    required this.currentPage,
    required this.data,
    required this.perPage,
    required this.total,
    required this.lastPage,
  });

  factory ShipmentPaginationModel.fromJson(Map<String, dynamic> json) => ShipmentPaginationModel(
    currentPage: json["current_page"],
    data: List<ShipmentModel>.from(json["data"].map((x) => ShipmentModel.fromJson(x))),
    perPage: json["per_page"],
    total: json["total"],
    lastPage: json["last_page"],
  );
}

class ShipmentModel {
  final int? id;
  final int? userId;
  final int? companyId;
  final String? shipmentType;
  final String? contentDescription;
  final String? expectedDeliveryDate;
  final int? fromAddressId;
  final int? toAddressId;
  final String? receiverName;
  final String? receiverPhone;
  final String? status;
  final String? paymentMethod;
  final String? trackingNumber;
  final num? rating;
  final String? rejectionReason;
  final String? createdAt;
  final String? updatedAt;
  final String? typeActivityId;
  final UserModel? user;
  final UserCompanyModel2? company;
  final Address? addressTo;
  final Address? addressFrom;
  final List<String>? shipmentImage;

  ShipmentModel({
    this.id,
    this.userId,
    this.companyId,
    this.shipmentType,
    this.contentDescription,
    this.expectedDeliveryDate,
    this.fromAddressId,
    this.toAddressId,
    this.receiverName,
    this.receiverPhone,
    this.status,
    this.paymentMethod,
    this.trackingNumber,
    this.rating,
    this.rejectionReason,
    this.createdAt,
    this.updatedAt,
    this.typeActivityId,
    this.user,
    this.company,
    this.addressTo,
    this.addressFrom,
    this.shipmentImage,
  });

  factory ShipmentModel.fromJson(Map<String, dynamic> json) => ShipmentModel(
    id: json["id"],
    userId: json["user_id"],
    companyId: json["company_id"],
    shipmentType: json["shipment_type"],
    contentDescription: json["content_description"],
    expectedDeliveryDate: json["expected_delivery_date"],
    fromAddressId: json["from_address_id"],
    toAddressId: json["to_address_id"],
    receiverName: json["receiver_name"],
    receiverPhone: json["receiver_phone"],
    status: json["status"],
    paymentMethod: json["payment_method"],
    trackingNumber: json["tracking_number"],
    rating: json["rating"],
    rejectionReason: json["rejection_reason"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    typeActivityId: json["typeActivity_id"],
    user: json["user"] == null ? null : UserModel.fromJson(json["user"]),
    company: json["company"] == null ? null : UserCompanyModel2.fromJson(json["company"]),
    addressTo: json["address_to"] == null ? null : Address.fromJson(json["address_to"]),
    addressFrom: json["address_from"] == null ? null : Address.fromJson(json["address_from"]),
    shipmentImage: json["shipment_image"] == null ? [] : List<String>.from(json["shipment_image"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "company_id": companyId,
    "shipment_type": shipmentType,
    "content_description": contentDescription,
    "from_address_id": fromAddressId,
    "to_address_id": toAddressId,
    "receiver_name": receiverName,
    "receiver_phone": receiverPhone,
    "status": status,
    "payment_method": paymentMethod,
    "tracking_number": trackingNumber,
    "rating": rating,
    "rejection_reason": rejectionReason,
    // "created_at": createdAt?.toIso8601String(),
    // "updated_at": updatedAt?.toIso8601String(),
    "typeActivity_id": typeActivityId,
    "user": user?.toJson(),
    "company": company?.toJson(),
    "address_to": addressTo?.toJson(),
    "address_from": addressFrom?.toJson(),
    "shipment_image": shipmentImage == null ? [] : List<dynamic>.from(shipmentImage!.map((x) => x)),
  };
}