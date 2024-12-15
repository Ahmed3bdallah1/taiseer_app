class ChatsPaginationModel {
  final int? currentPage;
  final List<ConversationModel>? data;
  final int? from;
  final int? lastPage;
  final int? perPage;
  final int? to;
  final int? total;

  ChatsPaginationModel({
    this.currentPage,
    this.data,
    this.from,
    this.lastPage,
    this.perPage,
    this.to,
    this.total,
  });

  factory ChatsPaginationModel.fromJson(Map<String, dynamic> json) => ChatsPaginationModel(
    currentPage: json["current_page"],
    data: json["data"] == null ? [] : List<ConversationModel>.from(json["data"]!.map((x) => ConversationModel.fromJson(x))).reversed.toList(),
    from: json["from"],
    lastPage: json["last_page"],
    perPage: json["per_page"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "from": from,
    "last_page": lastPage,
    "per_page": perPage,
    "to": to,
    "total": total,
  };
}

class ConversationModel {
  final int? id;
  final String? name;
  final int? shipmentId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? chatName;

  ConversationModel({
    this.id,
    this.name,
    this.shipmentId,
    this.createdAt,
    this.updatedAt,
    this.chatName,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) => ConversationModel(
    id: json["id"],
    name: json["name"],
    shipmentId: json["shipment_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    chatName: json["chat_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "shipment_id": shipmentId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "chat_name": chatName,
  };
}
