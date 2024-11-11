import 'attributes_entity.dart';

class CommentsEntity {
  final int? id;
  final String? userName;
  final String? userImage;
  final String? comment;
  final int? userId;
  final double? rating;
  final List<AttributesEntity>? attributes;

  CommentsEntity({
    required this.id,
    required this.userName,
    required this.userImage,
    required this.comment,
    required this.userId,
    required this.rating,
    required this.attributes,
  });

  factory CommentsEntity.fromJson(Map<String, dynamic> json) {
    return CommentsEntity(
      id: json['id'],
      userName: json['user_name'],
      userImage: json['user_image'],
      comment: json['comment'],
      userId: json['user_id'],
      rating: json["rating"],
      attributes: json["attributes"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      'user_name': userName,
      'comment': comment,
      'rating': rating,
      'user_id': userId,
    };
  }
}

final comments = [
  CommentsEntity(
    id: 1,
    userName: "محمد سعيد",
    userImage: "assets/base/personal.png",
    comment: "Great product!",
    userId: 101,
    rating: 4.5,
    attributes: attributes,
  ),
  CommentsEntity(
    id: 2,
    userName: "حبشى",
    userImage: "assets/base/personal.png",
    comment: "Not satisfied with the service.",
    userId: 102,
    rating: 2.0,
    attributes: attributes,
  ),
];