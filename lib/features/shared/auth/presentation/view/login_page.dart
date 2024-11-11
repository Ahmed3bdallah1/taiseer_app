import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:learning/core/service/auth_service.dart';
import 'package:learning/core/service/local_data_manager.dart';
import 'package:learning/features/company_features/company_root/view/company_root_view.dart';
import 'package:learning/features/shared/auth/presentation/view/register_page.dart';
import 'package:learning/features/shared/forget_password/presentation/pages/forget_password_view.dart';
import 'package:learning/features/user_features/root/view/root_view.dart';
import 'package:learning/gen/assets.gen.dart';
import 'package:learning/main.dart';
import 'package:learning/ui/shared_widgets/custom_filled_button.dart';
import 'package:learning/ui/shared_widgets/custom_logo_app_bar.dart';
import 'package:learning/ui/shared_widgets/custom_text_field.dart';
import 'package:learning/ui/shared_widgets/image_or_svg.dart';
import 'package:learning/ui/shared_widgets/select_language_tile.dart';
import 'package:local_auth/local_auth.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../../../../../config/app_font.dart';
import '../../../../../ui/shared_widgets/custom_reactive_form_consumer.dart';
import '../../../../../ui/shared_widgets/toggle_show_password_icon.dart';
import '../../../../../ui/ui.dart';
import '../../../../company_features/add_company/presentation/view/add_company_screen.dart';
import '../manager/auth_provuder.dart';

final securePasswordProvider =
    StateProvider.family.autoDispose<bool, dynamic>((ref, _) => true);

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  late final FormGroup formGroup;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (dataManager.getFingerprintEnabled() &&
          ref.read(userProvider)?.id != null) {
        _localAuth();
      }
    });

    formGroup = FormGroup({
      'email': FormControl<String>(validators: [Validators.email],value: null),
      'password': FormControl(validators: [Validators.required], value: "12341234"),
    });

    // formGroup = FormGroup({
    //   'password': FormControl(validators: [Validators.required], value: null),
    //   'country': FormControl<int>(),
    // });
    // formGroup.addAll({
    //   'phone': FormControl(validators: [
    //     Validators.compose([
    //       Validators.required,
    //       Validators.delegate((controls) {
    //         final res = formGroup.control('country').value is int;
    //         if (res) {
    //           return null;
    //         } else {
    //           return {'please select country'.tr: 'please select country'};
    //         }
    //       })
    //     ])
    //   ], value: "98758256"),
    // });

    super.initState();
  }

  _localAuth() async {
    final local = getIt<LocalAuthentication>();
    if (await local.authenticate(localizedReason: "Authenticate To Login".tr)) {
      Get.offAll(() => isCompany ? const CompanyRootView() : const RootView());
    }
  }

  @override
  Widget build(BuildContext context) {
    // final provider = ref.watch(fetchCountryProvider);
    // ref.listen(fetchCountryProvider, (ds, next) {
    //   if (next.hasValue && next.value?.isNotEmpty == true) {
    //     formGroup.control('country').value = next.value?.first.id;
    //   }
    // });
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
                  Gap(24.h),
                  Row(
                    children: [
                      Text(
                        "Login".tr,
                        style: AppFont.font20W700Black,
                      ),
                    ],
                  ),
                  Gap(32.h),
                  CustomTextField(
                    formControlName: "email",
                    labelText: "Email".tr,
                    hintText: "ahmed@gmail.com",
                  ),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: ReactiveFormConsumer(
                  //           builder: (context, form, _) {
                  //             final max = country
                  //                 .firstWhereOrNull((e) =>
                  //             e.id == form.control('country').value)
                  //                 ?.numberLength ??
                  //                 5;
                  //             return CustomTextField(
                  //               iconButton: SizedBox(
                  //                 width: 110.w,
                  //                 height: 55,
                  //                 child: ReactiveDropdownField(
                  //                   onChanged: (_) {},
                  //                   decoration: const InputDecoration(
                  //                     focusedBorder: InputBorder.none,
                  //                     enabledBorder: InputBorder.none,
                  //                   ),
                  //                   iconEnabledColor: AppColor.primary,
                  //                   iconDisabledColor: AppColor.disabled,
                  //                   itemHeight: kMinInteractiveDimension,
                  //                   isDense: false,
                  //                   style: AppFont.textFiled,
                  //                   formControlName: "country",
                  //                   items: country.map((e) {
                  //                     return DropdownMenuItem(
                  //                       value: e.id,
                  //                       child: Row(
                  //                         children: [
                  //                           ImageOrSvg(
                  //                             e.countryImage,
                  //                             isLocal: true,
                  //                             height: 30,
                  //                           ),
                  //                           Gap(8.w),
                  //                           Text(
                  //                             e.iso ?? "",
                  //                             style: AppFont.font14W600Primary,
                  //                           )
                  //                         ],
                  //                       ),
                  //                     );
                  //                   }).toList(),
                  //                 ),
                  //               ),
                  //               formControlName: "phone",
                  //               hintText: "000 000 000",
                  //               labelText: "Phone number".tr,
                  //               inputType: TextInputType.number,
                  //               inputFormatter: [
                  //                 FilteringTextInputFormatter.digitsOnly,
                  //                 LengthLimitingTextInputFormatter(max)
                  //               ],
                  //             );
                  //           }),
                  //     ),
                  //   ],
                  // ),
                  Gap(24.h),
                  Consumer(builder: (context, ref, _) {
                    return CustomTextField(
                      formControlName: "password",
                      labelText: "Password".tr,
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
                  Gap(8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () => Get.to(const ForgetPasswordView()),
                        child: Text(
                          "Forget Password".tr,
                          style: AppFont.font10w400Primary,
                        ),
                      ),
                    ],
                  ),
                  Gap(24.h),
                  CustomReactiveFormValidationConsumer(
                      formGroup: formGroup,
                      builder: (context, _, child) {
                        return Consumer(builder: (context, ref, child) {
                          final isLoading = ref.watch(authNotifierProvider);
                          return CustomFilledButton(
                            isLoading: isLoading,
                            isValid: formGroup.valid,
                            text: "Login".tr,
                            onPressed: () async {
                              if (formGroup.valid) {
                                try {
                                  await ref
                                      .read(authNotifierProvider.notifier)
                                      .login(formGroup.value);
                                } catch (e) {
                                  UIHelper.showAlert(e.toString(),
                                      type: DialogType.error);
                                }
                              } else {
                                formGroup.markAllAsTouched();
                              }
                            },
                          );
                        });
                      }),
                  Gap(16.h),
                  if (dataManager.getFingerprintEnabled() &&
                      ref.watch(userProvider)?.id != null) ...[
                    Row(
                      children: [
                        const Expanded(
                            child: Divider(
                          thickness: 1,
                          color: Colors.grey,
                        )),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            "Or Login with fingerprint".tr,
                            style: AppFont.font10w400Black,
                          ),
                        ),
                        const Expanded(
                            child: Divider(
                          thickness: 1,
                          color: Colors.grey,
                        )),
                      ],
                    ),
                    Gap(24.h),
                    InkWell(
                      onTap: _localAuth,
                      child: Center(
                          child: SvgPicture.asset(
                        Assets.base.fingerScan,
                      )),
                    ),
                  ],
                ],
              ),
            ),
          )),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Don't have an account? ".tr, style: AppFont.font16W600Black),
            InkWell(
              onTap: () => Get.offAll(
                  isCompany ? const AddCompanyScreen() : const RegisterPage()),
              child: Text(
                  isCompany
                      ? "Register as new company".tr
                      : "Create account".tr,
                  style: AppFont.font14W600Primary),
            ),
          ],
        ),
      ),
    );
  }
}

// body: ReactiveForm(
//         formGroup: formGroup,
//         child: provider.customWhen(
//             ref: ref,
//             refreshable: fetchCountryProvider.future,
//             data: (country) {
//               return SingleChildScrollView(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 24),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Gap(24.h),
//                       Row(
//                         children: [
//                           Text(
//                             "Login".tr,
//                             style: AppFont.font20W700Black,
//                           ),
//                         ],
//                       ),
//                       Gap(32.h),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: ReactiveFormConsumer(
//                                 builder: (context, form, _) {
//                               final max = country
//                                       .firstWhereOrNull((e) =>
//                                           e.id == form.control('country').value)
//                                       ?.numberLength ??
//                                   5;
//                               return CustomTextField(
//                                 iconButton: SizedBox(
//                                   width: 110.w,
//                                   height: 55,
//                                   child: ReactiveDropdownField(
//                                     onChanged: (_) {},
//                                     decoration: const InputDecoration(
//                                       focusedBorder: InputBorder.none,
//                                       enabledBorder: InputBorder.none,
//                                     ),
//                                     iconEnabledColor: AppColor.primary,
//                                     iconDisabledColor: AppColor.disabled,
//                                     itemHeight: kMinInteractiveDimension,
//                                     isDense: false,
//                                     style: AppFont.textFiled,
//                                     formControlName: "country",
//                                     items: country.map((e) {
//                                       return DropdownMenuItem(
//                                         value: e.id,
//                                         child: Row(
//                                           children: [
//                                             ImageOrSvg(
//                                               e.countryImage,
//                                               isLocal: true,
//                                               height: 30,
//                                             ),
//                                             Gap(8.w),
//                                             Text(
//                                               e.iso ?? "",
//                                               style: AppFont.font14W600Primary,
//                                             )
//                                           ],
//                                         ),
//                                       );
//                                     }).toList(),
//                                   ),
//                                 ),
//                                 formControlName: "phone",
//                                 hintText: "000 000 000",
//                                 labelText: "Phone number".tr,
//                                 inputType: TextInputType.number,
//                                 inputFormatter: [
//                                   FilteringTextInputFormatter.digitsOnly,
//                                   LengthLimitingTextInputFormatter(max)
//                                 ],
//                               );
//                             }),
//                           ),
//                         ],
//                       ),
//                       Gap(24.h),
//                       Consumer(builder: (context, ref, _) {
//                         return CustomTextField(
//                           formControlName: "password",
//                           labelText: "Password".tr,
//                           hintText: "**********",
//                           iconButton: ToggleShowPasswordButton(
//                             onTap: () {
//                               ref
//                                       .read(securePasswordProvider("password")
//                                           .notifier)
//                                       .state =
//                                   !ref.read(securePasswordProvider("password"));
//                             },
//                             showPass:
//                                 ref.watch(securePasswordProvider("password")),
//                           ),
//                           obscure:
//                               ref.watch(securePasswordProvider("password")),
//                         );
//                       }),
//                       Gap(8.h),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           InkWell(
//                             onTap: () => Get.to(const ForgetPasswordView()),
//                             child: Text(
//                               "Forget Password".tr,
//                               style: AppFont.font10w400Primary,
//                             ),
//                           ),
//                         ],
//                       ),
//                       Gap(24.h),
//                       CustomReactiveFormValidationConsumer(
//                           formGroup: formGroup,
//                           builder: (context, _, child) {
//                             return Consumer(builder: (context, ref, child) {
//                               final isLoading = ref.watch(authNotifierProvider);
//                               return CustomFilledButton(
//                                 isLoading: isLoading,
//                                 isValid: formGroup.valid,
//                                 text: "Login".tr,
//                                 onPressed: () async {
//                                   if (formGroup.valid) {
//                                     try {
//                                       await ref
//                                           .read(authNotifierProvider.notifier)
//                                           .login(formGroup.value);
//                                     } catch (e) {
//                                       UIHelper.showAlert(e.toString(),
//                                           type: DialogType.error);
//                                     }
//                                   } else {
//                                     formGroup.markAllAsTouched();
//                                   }
//                                 },
//                               );
//                             });
//                           }),
//                       Gap(16.h),
//                       if (dataManager.getFingerprintEnabled() &&
//                           ref.watch(userProvider)?.id != null) ...[
//                         Row(
//                           children: [
//                             const Expanded(
//                                 child: Divider(
//                               thickness: 1,
//                               color: Colors.grey,
//                             )),
//                             Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 8),
//                               child: Text(
//                                 "Or Login with fingerprint".tr,
//                                 style: AppFont.font10w400Black,
//                               ),
//                             ),
//                             const Expanded(
//                                 child: Divider(
//                               thickness: 1,
//                               color: Colors.grey,
//                             )),
//                           ],
//                         ),
//                         Gap(24.h),
//                         InkWell(
//                           onTap: _localAuth,
//                           child: Center(
//                               child: SvgPicture.asset(
//                             Assets.base.fingerScan,
//                           )),
//                         ),
//                       ],
//                     ],
//                   ),
//                 ),
//               );
//             }),
//       ),
