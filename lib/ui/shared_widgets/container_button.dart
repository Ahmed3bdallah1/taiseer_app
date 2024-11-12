import 'package:flutter/material.dart';
import 'package:taiseer/config/app_color.dart';

class ContainerButton extends StatelessWidget {
  final void Function()? onTap;
  final Widget? widget;
  final IconData? icon;
  final double? size;
  final double? radius;
  final Color? color;
  final Color? iconColor;

  const ContainerButton({
    super.key,
    this.onTap,
    this.icon,
    this.size,
    this.color,
    this.widget,
    this.radius,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: size ?? 50,
        width: size ?? 50,
        decoration: BoxDecoration(
            color: color ?? Colors.green.withOpacity(.2),
            borderRadius: BorderRadius.circular(radius ?? 8),
            border: Border.all(
                color: color == Colors.transparent
                    ? AppColor.primary.withOpacity(.5)
                    : color ?? Colors.green.withOpacity(.2))),
        child: Center(
            child: widget ??
                Icon(
                  icon,
                  color: iconColor??AppColor.black,
                )),
      ),
    );
  }
}
