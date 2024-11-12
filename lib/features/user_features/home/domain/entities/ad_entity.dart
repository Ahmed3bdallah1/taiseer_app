import 'package:taiseer/gen/assets.gen.dart';

class AdEntity {
  final String photo;
  final String navTo;
  final AdType adType;

  AdEntity({
    required this.photo,
    required this.navTo,
    this.adType = AdType.none,
  });

  Map<String, dynamic> toJson() {
    return {
      "photo": photo,
      'navTo': navTo,
    };
  }
}

enum AdType {
  none(0),
  category(1),
  service(2),
  link(3);

  final int value;

  const AdType(this.value);
}

final ads = [
  AdEntity(photo: Assets.onboard.onboard1.path, navTo: "navTo"),
  AdEntity(photo: Assets.onboard.onboard2.path, navTo: "navTo"),
  AdEntity(photo: Assets.onboard.onboard3.path, navTo: "navTo"),
];
