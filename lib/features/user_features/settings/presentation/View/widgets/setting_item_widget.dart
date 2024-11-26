import 'package:flutter/material.dart';
import 'package:taiseer/config/app_font.dart';

class SettingsItem extends StatelessWidget {
  const SettingsItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.color,
  });

  final String title;
  final IconData icon;
  final Color? color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          height: 60,
          decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: const BorderRadius.all(
                Radius.circular(15),
              ),
              border: Border.all(color: AppColor.primaryDark.withOpacity(0.4)),
              boxShadow: [
                BoxShadow(
                  color: AppColor.primaryDark.withOpacity(0.5),
                  spreadRadius: 2.5,
                )
              ]),
          child: Row(
            children: [
              Icon(
                icon,
                color: color ?? AppColor.primaryDark,
              ),
              const SizedBox(width: 20),
              Text(title,style: AppFont.font14W700Black,),
            ],
          )),
    );
  }
}
