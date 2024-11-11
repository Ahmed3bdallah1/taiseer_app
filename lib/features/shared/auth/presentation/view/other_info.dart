import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:learning/features/shared/auth/presentation/view/required_papers.dart';
import 'package:learning/gen/assets.gen.dart';
import 'package:learning/ui/shared_widgets/custom_reactive_form_consumer.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../../../../../config/app_font.dart';
import '../../../../../ui/shared_widgets/custom_app_bar.dart';
import '../../../../../ui/shared_widgets/custom_filled_button.dart';
import '../../../../../ui/shared_widgets/custom_text_field.dart';
import '../../../../../ui/ui.dart';

class OtherInfo extends StatefulWidget {
  const OtherInfo({super.key});

  @override
  State<OtherInfo> createState() => _OtherInfoState();
}

class _OtherInfoState extends State<OtherInfo> {
  final FormGroup formGroup = FormGroup({
    'address': FormControl(validators: [
      Validators.required,
      Validators.minLength(10),
    ]),
    'birth_day': FormControl<DateTime>(validators: [Validators.required]),
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "",
        customTitleWidget: SvgPicture.asset(Assets.base.logo.path),
      ),
      body: ReactiveForm(
        formGroup: formGroup,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(16.h),
                Text("additional info".tr,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                Gap(8.h),
                Text(
                    "Verification completed successfully, complete the following information data"
                        .tr,
                    style: AppFont.font13W600Grey2),
                Gap(16.h),
                LinearProgressIndicator(
                  minHeight: 10.h,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  value: 0.4,
                  color: AppColor.primary,
                  backgroundColor: Colors.white,
                ),
                // Gap(48.h),
                // RichText(
                //     text: TextSpan(children: [
                //   TextSpan(text: ("gender".tr), style: AppFont.labelTextField),
                //   TextSpan(
                //       text: "*",
                //       style: AppFont.subLabelTextField
                //           .copyWith(color: AppColor.danger)),
                // ])),
                // Gap(20.h),
                // ReactiveFormConsumer(
                //   builder: (context, form, child) {
                //     final isMale = form.control("gender").value == 0;
                //     return GenderPicker(
                //       isMale: isMale,
                //       onChanged: (value) {
                //         form.control("gender").updateValue(value);
                //       },
                //     );
                //   },
                // ),
                Gap(20.h),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: ("birthday".tr), style: AppFont.labelTextField),
                  TextSpan(
                      text: "*",
                      style: AppFont.labelTextField
                          .copyWith(color: Colors.red, fontSize: 18)),
                ])),
                Gap(15.h),
                CustomReactiveFormConsumer(builder: (context, form, _) {
                  return InkWell(
                    onTap: () {
                      UIHelper.pickDate(
                        context: context,
                        date: (ReactiveForm.of(context) as FormGroup)
                            .control('birth_day')
                            .value,
                      ).then((value) {
                        if (value != null) {
                          (ReactiveForm.of(context) as FormGroup)
                              .control("birth_day")
                              .value = value;
                        }
                      });
                    },
                    child: const CustomTextField(
                      ignore: true,
                      hintText: "DD/MM/YYYY",
                      formControlName: "birth_day",
                    ),
                  );
                }),
                Gap(16.h),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(text: ("address".tr), style: AppFont.labelTextField),
                  TextSpan(
                      text: "*",
                      style: AppFont.labelTextField
                          .copyWith(color: Colors.red, fontSize: 18)),
                ])),
                Gap(16.h),
                const CustomTextField(
                  formControlName: "address",
                ),
                Gap(24.h),
                ReactiveFormConsumer(builder: (context, form, _) {
                  bool isValid = form.valid;
                  return CustomFilledButton(
                    text: "next".tr,
                    onPressed: () => Get.to(const RequiredPapersRegister()),
                    isValid: isValid,
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
