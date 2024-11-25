class MessagesPaginationModel {
  final int? currentPage;
  final List<MessageEntity>? data;
  final int? from;
  final int? lastPage;
  final int? perPage;
  final int? to;
  final int? total;

  MessagesPaginationModel({
    this.currentPage,
    this.data,
    this.from,
    this.lastPage,
    this.perPage,
    this.to,
    this.total,
  });

  factory MessagesPaginationModel.fromJson(Map<String, dynamic> json) => MessagesPaginationModel(
    currentPage: json["current_page"],
    data: json["data"] == null ? [] : List<MessageEntity>.from(json["data"]!.map((x) => MessageEntity.fromJson(x))),
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

class MessageEntity {
  final int? id;
  final int? chatId;
  final int? senderId;
  final String? messageText;
  final int? isRead;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  MessageEntity({
    this.id,
    this.chatId,
    this.senderId,
    this.messageText,
    this.isRead,
    this.createdAt,
    this.updatedAt,
  });

  factory MessageEntity.fromJson(Map<String, dynamic> json) => MessageEntity(
    id: json["id"],
    chatId: json["chat_id"],
    senderId: json["sender_id"],
    messageText: json["message_text"],
    isRead: json["is_read"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "chat_id": chatId,
    "sender_id": senderId,
    "message_text": messageText,
    "is_read": isRead,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}