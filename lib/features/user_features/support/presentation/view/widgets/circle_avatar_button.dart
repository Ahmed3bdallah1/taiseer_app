import 'package:flutter/material.dart';
import 'package:taiseer/config/app_color.dart';
import 'package:taiseer/ui/shared_widgets/image_or_svg.dart';

class CircleAvatarButton extends StatelessWidget {
  final Color? backgroundColor;
  final Color? iconColor;
  final double? radius;
  final bool? isImage;
  final double? iconSize;
  final String? imagePath;
  final IconData icon;
  final ImageProvider<Object>? backgroundImage;
  final void Function()? onTap;

  const CircleAvatarButton({
    super.key,
    this.backgroundColor,
    this.iconColor,
    this.backgroundImage,
    this.radius,
    this.iconSize,
    required this.icon,
    this.isImage,
    this.imagePath,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: CircleAvatar(
        radius: radius ?? 35.r,
        backgroundColor: backgroundColor ?? AppColor.black,
        backgroundImage: backgroundImage,
        child: isImage == true
            ? ImageOrSvg(
                imagePath,
                isLocal: true,height: iconSize??30,
              )
            : Icon(
                icon,
                size: iconSize ?? 20,
                color: iconColor,
              ),
      ),
    );
  }
}
