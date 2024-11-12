import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taiseer/gen/assets.gen.dart';

class ShippingMethodsEntity {
  final int? id;
  final String? name;
  final String? backgroundImage;
  final IconData? icon;

  ShippingMethodsEntity({
    required this.id,
    required this.name,
    required this.backgroundImage,
    required this.icon,
  });

  factory ShippingMethodsEntity.fromJson(Map<String, dynamic> json) {
    return ShippingMethodsEntity(
      id: json['id'],
      name: json['name'],
      backgroundImage: json["background_image"],
      icon: json["icon"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      'name': name,
      'background_image': backgroundImage,
      'icon': icon,
    };
  }
}

List<ShippingMethodsEntity> shippingMethods = [
  ShippingMethodsEntity(
    id: 1,
    name: 'بحرى',
    backgroundImage: Assets.base.background.path,
    icon: Icons.directions_boat_filled_outlined,
  ),
  ShippingMethodsEntity(
    id: 2,
    name: 'تريلا',
    backgroundImage: Assets.base.background.path,
    icon: Icons.local_shipping_outlined,
  ),
  ShippingMethodsEntity(
    id: 3,
    name: 'جوى',
    backgroundImage: Assets.base.background.path,
    icon: Icons.flight_takeoff,
  ),
  ShippingMethodsEntity(
    id: 4,
    name: 'برى',
    backgroundImage: Assets.base.background.path,
    icon: CupertinoIcons.car_detailed,
  ),
  ShippingMethodsEntity(
    id: 5,
    name: 'شحن سريع',
    backgroundImage: Assets.base.background.path,
    icon: Icons.flash_auto_sharp,
  ),
];
