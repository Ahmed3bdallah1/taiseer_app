import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../config/app_color.dart';

class CustomOTP extends StatelessWidget {
  const CustomOTP({
    super.key,
    this.onCompleted,
    this.onChanged,
    this.controller,
  });

  final ValueChanged<String>? onCompleted;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    responsiveInit(context);
    return Directionality(
      textDirection: TextDirection.ltr,
      child: PinCodeTextField(
        controller: controller,
        length: 4,
        obscureText: false,
        animationType: AnimationType.fade,
        backgroundColor: Colors.transparent,
        enableActiveFill: true,
        pinTheme: PinTheme(
          borderRadius: BorderRadius.zero,
          shape: PinCodeFieldShape.underline,
          selectedFillColor: Colors.transparent,
          inactiveFillColor: Colors.transparent,
          activeFillColor: Colors.transparent,
          activeColor: AppColor.primary,
          inactiveColor: AppColor.grey2,
          selectedColor: AppColor.primary,
          fieldWidth: 71,
          borderWidth: 0,
        ),
        onCompleted: onCompleted,
        onChanged: onChanged,
        appContext: context,
      ),
    );
  }
}
