import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:taiseer/config/app_font.dart';

import '../../../../../../gen/assets.gen.dart';

class SettingsItem extends StatelessWidget {
  const SettingsItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.color,
    this.isSupport = false,
  });

  final String title;
  final bool isSupport;
  final IconData icon;
  final Color? color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          height: 55.h,
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
              isSupport
                  ? SvgPicture.asset(
                      Assets.navigationBar.messageQuestion,
                      height: 21.h,
                      color: color ?? AppColor.primaryDark,
                    )
                  : Icon(
                      icon,
                      color: color ?? AppColor.primaryDark,
                    ),
              Gap(20.w),
              Text(
                title,
                style: AppFont.font14W700Black,
              ),
            ],
          )),
    );
  }
}
