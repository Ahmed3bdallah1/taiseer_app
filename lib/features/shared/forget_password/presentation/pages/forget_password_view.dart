import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:taiseer/ui/shared_widgets/container_button.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../../../../../config/app_font.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../main.dart';
import '../../../../../ui/shared_widgets/custom_filled_button.dart';
import '../../../../../ui/shared_widgets/custom_logo_app_bar.dart';
import '../../../../../ui/shared_widgets/custom_reactive_form_consumer.dart';
import '../../../../../ui/shared_widgets/custom_text_field.dart';
import '../../../../../ui/shared_widgets/image_or_svg.dart';
import '../../../../../ui/shared_widgets/select_language_tile.dart';
import '../../../../../ui/ui.dart';
import '../../../auth/presentation/manager/auth_provuder.dart';
import '../../../verify/domain/repositories/verification_repo.dart';
import '../../../verify/presentation/pages/verify_view.dart';

class ForgetPasswordView extends ConsumerStatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  ConsumerState<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends ConsumerState<ForgetPasswordView> {
  late final FormGroup formGroup;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    formGroup = FormGroup({
      'country': FormControl<int>(),
      'phone': FormControl(validators: [Validators.required]),
    });

    formGroup.control('phone').setValidators([
      Validators.compose([
        Validators.required,
        Validators.delegate((controls) {
          final res = formGroup.control('country').value is int;
          if (res) {
            return null;
          } else {
            return {'please select country'.tr: 'please select country'};
          }
        })
      ])
    ]);
  }

  @override
  void dispose() {
    formGroup.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final country = ref.watch(fetchCountryProvider).value;
    return Scaffold(
      appBar: CustomLogoAppbar(
        customTitleWidget: ImageOrSvg(
          Assets.base.tayseerLogo.path,
          isLocal: true,
          height: 65.h,
        ),
        isCenterTitle: false,
        hideBackButton: true,
        buttonWidget: const Padding(
          padding: EdgeInsets.only(bottom: 18, top: 2),
          child: SelectLanguageTile(),
        ),
      ),
      body: ReactiveForm(
        formGroup: formGroup,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Gap(32.h),

                Gap(32.h),
                Row(
                  children: [
                    ContainerButton(
                      size: 40,
                      onTap: () => Get.back(),
                      icon: Icons.arrow_back,
                      color: Colors.transparent,
                    ),
                    Gap(8.w),
                    Text(
                      "Forget password".tr,
                      style: AppFont.font20W700Black,
                    ),
                  ],
                ),
                Gap(32.h),
                ReactiveFormConsumer(builder: (context, form, _) {
                  final max = country!
                          .firstWhereOrNull(
                              (e) => e.id == form.control('country').value)
                          ?.numberLength ??
                      5;
                  return CustomTextField(
                    iconButton: SizedBox(
                      width: 110.w,
                      height: 55,
                      child: ReactiveDropdownField(
                        onChanged: (_) {
                          form.control('phone').value = null;
                        },
                        decoration: const InputDecoration(
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                        ),
                        iconEnabledColor: AppColor.primary,
                        iconDisabledColor: AppColor.disabled,
                        itemHeight: kMinInteractiveDimension,
                        isDense: false,
                        style: AppFont.textFiled,
                        formControlName: "country",
                        items: country.map((e) {
                          return DropdownMenuItem(
                            value: e.id,
                            child: Row(
                              children: [
                                ImageOrSvg(
                                  e.countryImage,
                                  isLocal: true,
                                  height: 30,
                                ),
                                Gap(8.w),
                                Text(
                                  e.iso ?? "",
                                  style: AppFont.font14W600Primary,
                                )
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    formControlName: "phone",
                    hintText: "000 000 000",
                    labelText: "Phone number".tr,
                    inputType: TextInputType.number,
                    inputFormatter: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(max)
                    ],
                  );
                }),
                Gap(8.h),
                Text(
                  "please enter your number to send a verification code and retrieve your account data"
                      .tr,
                  style: AppFont.font12w500Grey2,
                ),
                // Row(
                //   children: [
                //     const CountyCodeContainer(),
                //     Gap(10.w),
                //     Expanded(
                //       child: CustomTextField(
                //         hintText: "000 000 000",
                //         inputType: TextInputType.number,
                //         control: phoneController,
                //         inputFormatter: [
                //           FilteringTextInputFormatter.digitsOnly,
                //           LengthLimitingTextInputFormatter(8)
                //         ],
                //       ),
                //     ),
                //   ],
                // ),
                Gap(48.h),
                CustomReactiveFormValidationConsumer(
                    formGroup: formGroup,
                    builder: (context, form, _) {
                      bool isValid = form.valid;
                      return CustomFilledButton(
                        text: 'next'.tr,
                        isValid: isValid,
                        onPressed: () {
                          Get.to(
                            () => VerifyView(
                              repo: getIt<VerificationRepo>(
                                instanceName: "forget",
                                param1: form.control("phone").value,
                              ),
                            ),
                          );
                        },
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
