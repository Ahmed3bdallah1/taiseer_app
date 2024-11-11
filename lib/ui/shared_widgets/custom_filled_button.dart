import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../config/app_font.dart';
import 'loading_widget.dart';

class CustomFilledButton extends StatelessWidget {
  const CustomFilledButton({
    super.key,
    this.text,
    this.isLoading = false,
    this.isExpanded = false,
    this.color,
    this.fontColor,
    this.height,
    this.onPressed,
    this.textSize,
    this.width,
    this.widget,
    this.ignorePressOnNotValid = false,
    this.isValid = true,
  });

  final bool isLoading;

  final Color? color;
  final Color? fontColor;
  final String? text;
  final Widget? widget;
  final void Function()? onPressed;
  final bool isValid;
  final bool isExpanded;
  final double? height;
  final double? width;
  final double? textSize;
  final bool ignorePressOnNotValid;

  @override
  Widget build(BuildContext context) {
    responsiveInit(context);
    return FilledButton(
      style: ButtonStyle(
          fixedSize:
              WidgetStateProperty.all(Size(width ?? 1.sw, height ?? 54.h)),
          backgroundColor: WidgetStateProperty.all(
              !isValid ? AppColor.disabled : color ?? AppColor.primary),
          shape: WidgetStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.r)))),
      onPressed:
          isLoading || (ignorePressOnNotValid && !isValid) ? null : onPressed,
      child: isLoading
          ? LoadingWidget(
              color: AppColor.white,
            )
          : widget != null && text != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      text!,
                      style: AppFont.font20W600White.copyWith(
                          overflow: TextOverflow.ellipsis,
                          color: fontColor ?? AppColor.white,
                          fontSize: textSize ?? 20.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    isExpanded ? const Spacer() : Gap(5.w),
                    widget!
                  ],
                )
              : widget != null
                  ? widget!
                  : Text(
                      text!,
                      style: AppFont.font20W600White.copyWith(
                          overflow: TextOverflow.ellipsis,
                          color: fontColor ?? AppColor.white,
                          fontSize: textSize ?? 20.sp,
                          fontWeight: FontWeight.w600),
                    ),
    );
  }
}
