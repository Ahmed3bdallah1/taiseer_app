import 'package:taiseer/features/user_features/home/domain/entities/ad_entity.dart';
import 'package:taiseer/gen/assets.gen.dart';
import '../../domain/entity/attributes_entity.dart';
import '../../domain/entity/comment_entity.dart';
import '../../domain/entity/shipping_methods_entity.dart';

class UserCompanyModel {
  final int id;
  final String? backgroundImage;
  final String? image;
  final String? title;
  final double? rating;
  final int? likes;
  final int? shipment;
  final String? description;
  final List<AdEntity>? ads;
  final List<AttributesEntity>? attributes;
  final List<CommentsEntity>? comment;
  final List<ShippingMethodsEntity>? shippingMethods;

  UserCompanyModel(
      {required this.id,
      this.backgroundImage,
      this.image,
      this.title,
      this.rating,
      this.likes,
      this.shipment,
      this.description,
      this.ads,
      this.attributes,
      this.comment,
      this.shippingMethods});

  factory UserCompanyModel.fromJson(Map<String, dynamic> json) {
    return UserCompanyModel(
        id: json['id'],
        ads: json['ads'],
        description: json['description'],
        backgroundImage: json['background_image'],
        image: json['image'],
        title: json['title'],
        rating: json['rating'],
        likes: json['likes'],
        shipment: json['shipment'],
        attributes: json["attributes"],
        comment: json["comments"],
        shippingMethods: json['shipping_methods']);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      'ads': ads,
      'attributes': attributes,
      'description': description,
      "background_image": backgroundImage,
      'image': image,
      "title": title,
      "rating": rating,
      "likes": likes,
      "shipment": shipment,
      "comments": comment,
    };
  }
}

final companies = [
  UserCompanyModel(
    id: 1,
    backgroundImage: Assets.base.loanContainer.path,
    image: Assets.onboard.vector,
    title: 'بوسطة',
    rating: 4.5,
    likes: 100,
    shipment: 5,
    description:
        'هذا نص افتراضي فقط هذا نص افتراضي فقط هذا نص افتراضي فقط هذا نص افتراضي فقط هذا نص افتراضي فقط هذا نص افتراضي فقط هذا نص افتراضي فقط هذا نص افتراضي فقط هذا نص افتراضي فقط ... قراءة المزيد',
    ads: ads,
    attributes: attributes,
    comment: comments,
    shippingMethods: shippingMethods,
  ),
  UserCompanyModel(
    id: 2,
    backgroundImage: Assets.base.loanContainer.path,
    image: Assets.onboard.vector,
    title: 'بوسطة',
    rating: 4.5,
    likes: 100,
    shipment: 5,
    description:
        'هذا نص افتراضي فقط هذا نص افتراضي فقط هذا نص افتراضي فقط هذا نص افتراضي فقط هذا نص افتراضي فقط هذا نص افتراضي فقط هذا نص افتراضي فقط هذا نص افتراضي فقط هذا نص افتراضي فقط ... قراءة المزيد',
    ads: ads,
    attributes: attributes,
    comment: comments,
    shippingMethods: shippingMethods,
  ),
  UserCompanyModel(
    id: 3,
    backgroundImage: Assets.base.loanContainer.path,
    image: Assets.onboard.vector,
    title: 'بوسطة',
    rating: 4.5,
    likes: 100,
    shipment: 5,
    description:
        'هذا نص افتراضي فقط هذا نص افتراضي فقط هذا نص افتراضي فقط هذا نص افتراضي فقط هذا نص افتراضي فقط هذا نص افتراضي فقط هذا نص افتراضي فقط هذا نص افتراضي فقط هذا نص افتراضي فقط ... قراءة المزيد',
    ads: ads,
    attributes: attributes,
    comment: comments,
    shippingMethods: shippingMethods,
  ),
];
