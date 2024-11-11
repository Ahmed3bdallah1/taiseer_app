import 'dart:convert';

class NotificationEntity {
  final int id;
  final String title;
  final String logo;
  final String description;
  final int seen;
  final int related;

  NotificationEntity({
    required this.id,
    required this.title,
    required this.logo,
    required this.description,
    required this.seen,
    required this.related,
  });

  factory NotificationEntity.fromNotificationModel(NotificationModel model) {
    return NotificationEntity(
      id: model.id,
      title: model.title,
      logo: model.logo,
      description: model.description,
      seen: model.seen,
      related: model.related,
    );
  }
}

class NotificationModel {
  final int id;
  final int customerId;
  final String title;
  final String logo;
  final String description;
  final String type;
  final int seen;
  final int related;
  final String createdAt;
  final String updatedAt;

  NotificationModel({
    required this.id,
    required this.customerId,
    required this.title,
    required this.logo,
    required this.description,
    required this.type,
    required this.seen,
    required this.related,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NotificationModel.fromRawJson(String str) =>
      NotificationModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        id: json["id"],
        customerId: json["customer_id"],
        title: json["title"],
        logo: json["logo"],
        description: json["description"],
        type: json["type"],
        seen: json["seen"],
        related: json["related"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_id": customerId,
        "title": title,
        "logo": logo,
        "description": description,
        "type": type,
        "seen": seen,
        "related": related,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
