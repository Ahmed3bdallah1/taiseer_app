import '../../../../../models/user_model.dart';

class CommentsEntity {
  final int id;
  final int userId;
  final int companyId;
  final int shipmentId;
  final int rate;
  final String comment;
  final DateTime createdAt;
  final DateTime updatedAt;
  final UserModel user;

  CommentsEntity({
    required this.id,
    required this.userId,
    required this.companyId,
    required this.shipmentId,
    required this.rate,
    required this.comment,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  factory CommentsEntity.fromJson(Map<String, dynamic> json) => CommentsEntity(
    id: json["id"],
    userId: json["user_id"],
    companyId: json["company_id"],
    shipmentId: json["shipment_id"],
    rate: json["rate"],
    comment: json["comment"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    user: UserModel.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "company_id": companyId,
    "shipment_id": shipmentId,
    "rate": rate,
    "comment": comment,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "user": user.toJson(),
  };
}
