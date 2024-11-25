import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../config/app_color.dart';
import '../../config/app_font.dart';
import 'loading_widget.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton(
      {super.key,
      this.text,
      this.height,
      this.color,
      this.textSize,
      this.isLoading = false,
      this.isExpanded = false,
      this.onPressed,
      this.padding,
      this.ignorePressOnNotValid = false,
      this.width,
      this.widget,
      this.isValid = true,
      this.hideText = false});

  final double? height;
  final bool isLoading;
  final bool isExpanded;
  final double? width;
  final Widget? widget;
  final Color? color;
  final bool hideText;
  final bool isValid;
  final String? text;
  final EdgeInsetsGeometry? padding;
  final void Function()? onPressed;
  final bool ignorePressOnNotValid;

  final double? textSize;

  @override
  Widget build(BuildContext context) {
    responsiveInit(context);
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: padding,
        fixedSize: Size(width ?? 1.sw, height ?? 54.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.r),
        ),
        side: BorderSide(
            width: 1.0,
            color: isValid
                ? color != null
                    ? color!
                    : AppColor.primary
                : AppColor.disabled),
      ),
      onPressed:
          isLoading || (ignorePressOnNotValid && !isValid) ? null : onPressed,
      child: isLoading
          ? LoadingWidget(
              color: AppColor.white,
            )
          : hideText
              ? widget
              : widget != null && text != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          text!,
                          style: AppFont.font20W700Primary.copyWith(
                              overflow: TextOverflow.ellipsis,
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
                          style: AppFont.font20W700Primary.copyWith(
                              overflow: TextOverflow.ellipsis,
                              fontSize: textSize ?? 20.sp,
                              fontWeight: FontWeight.w600),
                        ),
    );
  }
}
