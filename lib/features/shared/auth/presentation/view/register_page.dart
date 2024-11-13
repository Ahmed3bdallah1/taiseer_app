import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:taiseer/features/shared/auth/presentation/view/login_page.dart';
import 'package:taiseer/features/shared/auth/presentation/view/otp_screen.dart';
import 'package:taiseer/features/shared/verify/domain/repositories/verification_repo.dart';
import 'package:taiseer/main.dart';
import 'package:taiseer/ui/shared_widgets/custom_filled_button.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../../../../../config/app_font.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../ui/shared_widgets/custom_logo_app_bar.dart';
import '../../../../../ui/shared_widgets/custom_text_field.dart';
import '../../../../../ui/shared_widgets/image_or_svg.dart';
import '../../../../../ui/shared_widgets/select_language_dialog.dart';
import '../../../../../ui/shared_widgets/select_language_tile.dart';
import '../../../../../ui/shared_widgets/toggle_show_password_icon.dart';
import '../manager/auth_provuder.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  late final FormGroup formGroup;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    formGroup = FormGroup({
      'first_name': FormControl(validators: [Validators.required]),
      'last_name': FormControl(validators: [Validators.required]),
      'password': FormControl(validators: [Validators.required,Validators.minLength(8)]),
      'password_confirmation': FormControl(validators: [Validators.required,Validators.minLength(8)]),
      'email': FormControl(validators: [Validators.required, Validators.email]),
      'country': FormControl<int>(),
      'phone': FormControl(validators: [Validators.required]),
    }, validators: [
      Validators.mustMatch('password', 'password_confirmation'),
    ]);

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
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Create account".tr,
                      style: AppFont.font20W700Black,
                    ),
                  ],
                ),
                Gap(24.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: CustomTextField(
                        hintText: "محمود",
                        formControlName: "first_name",
                        labelText: "first name".tr,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    Gap(10.w),
                    Expanded(
                      flex: 1,
                      child: CustomTextField(
                        hintText: "ناصر",
                        formControlName: "last_name",
                        labelText: "last name".tr,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ],
                ),
                Gap(16.h),
                Row(
                  children: [
                    Expanded(
                      child: ReactiveFormConsumer(builder: (context, form, _) {
                        final max = country!
                                .firstWhereOrNull((e) =>
                                    e.id == form.control('country').value)
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
                          labelText: "phone number".tr,
                          inputType: TextInputType.number,
                          inputFormatter: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(max)
                          ],
                        );
                      }),
                    ),
                  ],
                ),
                Gap(16.h),
                CustomTextField(
                  hintText: "email@domain.com",
                  labelText: "Email".tr,
                  formControlName: "email",
                ),
                Gap(16.h),
                Consumer(builder: (context, ref, _) {
                  return CustomTextField(
                    formControlName: "password",
                    labelText: "password".tr,
                    hintText: "**********",
                    iconButton: ToggleShowPasswordButton(
                      onTap: () {
                        ref
                                .read(securePasswordProvider("password").notifier)
                                .state =
                            !ref.read(securePasswordProvider("password"));
                      },
                      showPass: ref.watch(securePasswordProvider("password")),
                    ),
                    obscure: ref.watch(securePasswordProvider("password")),
                  );
                }),
                Gap(16.h),
                Consumer(builder: (context, ref, _) {
                  return CustomTextField(
                    labelText: "confirm password".tr,
                    formControlName: "password_confirmation",
                    hintText: "**********",
                    iconButton: ToggleShowPasswordButton(
                      onTap: () {
                        ref
                                .read(securePasswordProvider("password_confirmation")
                                    .notifier)
                                .state =
                            !ref.read(
                                securePasswordProvider("password_confirmation"));
                      },
                      showPass:
                          ref.watch(securePasswordProvider("password_confirmation")),
                    ),
                    obscure:
                        ref.watch(securePasswordProvider("password_confirmation")),
                  );
                }),
                Gap(24.h),
                ReactiveFormConsumer(
                  builder:
                      (BuildContext context, FormGroup form, Widget? child) {
                    final isValid = form.valid;
                    return CustomFilledButton(
                      text: "next".tr,
                      onPressed: () {
                        if (isValid) {
                          Get.to(() => OtpScreen(
                                repo: getIt<VerificationRepo>(
                                  instanceName: "checkphone",
                                  param1: form.control('phone').value,
                                  param2: {...form.value},
                                ),
                              ));
                        } else {
                          formGroup.markAllAsTouched();
                        }
                      },
                      isValid: isValid,
                    );
                  },
                ),
                Gap(34.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account? ".tr,
                        style: AppFont.font14W600Black),
                    InkWell(
                      onTap: () => Get.offAll(const LoginPage()),
                      child: Text("Login".tr, style: AppFont.font14W600Primary),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
