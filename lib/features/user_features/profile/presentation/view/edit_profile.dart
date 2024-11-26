import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:taiseer/core/service/auth_service.dart';
import 'package:taiseer/core/service/loading_provider.dart';
import 'package:taiseer/features/shared/auth/presentation/view/login_page.dart';
import 'package:taiseer/features/user_features/profile/presentation/view/widgets/edit_personal_info.dart';
import 'package:taiseer/features/user_features/root/controller/root_controller.dart';
import 'package:taiseer/gen/assets.gen.dart';
import 'package:taiseer/ui/shared_widgets/container_button.dart';
import 'package:taiseer/ui/shared_widgets/custom_app_bar.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../../../../../config/app_font.dart';
import '../../../../../core/service/localization_service/localization_service.dart';
import '../../../../../helper/map_not_equals_validator.dart';
import '../../../../../main.dart';
import '../../../../../ui/shared_widgets/custom_filled_button.dart';
import '../../../../../ui/shared_widgets/custom_logo_app_bar.dart';
import '../../../../../ui/shared_widgets/custom_reactive_form_consumer.dart';
import '../../../../../ui/shared_widgets/image_or_svg.dart';
import '../../../../../ui/ui.dart';
import '../../domain/use_cases/update_profile_use_case.dart';
import '../manager/update_profile_provider.dart';
import '../manager/upload_file_notifier.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  late final FormGroup formGroup;

  @override
  void initState() {
    formGroup = FormGroup({
      'first_name': FormControl(
          validators: [Validators.required],
          value: ref.read(userProvider)?.name?.split(" ").first ?? ""),
      'last_name': FormControl(
          validators: [Validators.required],
          value: ref.read(userProvider)?.name?.split(" ").last ?? ""),
      'image': FormControl<String>(
          validators: [], value: ref.read(userProvider)?.profilePhotoUrl),
      'phone': FormControl(validators: [
        Validators.minLength(8),
        Validators.maxLength(8),
        Validators.required,
      ], value: ref.read(userProvider)?.phone),
      'country': FormControl<int>(),
      'email': FormControl(
          value: ref.read(userProvider)?.email,
          validators: [Validators.minLength(10), Validators.required]),
    });
    formGroup.setValidators([
      MapNotEqualsValidator(Map.from(formGroup.value)),
    ], autoValidate: true);

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomLogoAppbar(
        customTitleWidget: Text("Profile".tr),
        isCenterTitle: false,
        hideBackButton: true,
        buttonWidget: ContainerButton(
          icon: Icons.logout,
          iconColor: AppColor.danger,
          onTap: () {
            localeService.dataManager.removeLoggedUser();
            Get.offAll(() => const LoginPage());
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: ReactiveForm(
            formGroup: formGroup,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(200),
                        child: Consumer(
                          builder: (context, ref, child) {
                            return ImageOrSvg(
                              ref.watch(uploadFileNotifierProvider) ??
                                  Assets.base.personal.path,
                              fit: BoxFit.cover,
                              isLocal:
                                  ref.watch(uploadFileNotifierProvider) != null
                                      ? false
                                      : true,
                              height: 120.h,
                              width: 120.h,
                              isLoading:
                                  ref.watch(isLoadingProvider("setImage")),
                              magnifier: true,
                            );
                          },
                        ),
                      ),
                      Positioned.directional(
                          bottom: 10,
                          start: 0,
                          textDirection: TextDirection.rtl,
                          child: InkWell(
                            onTap: () async {
                              final newImageProvider =
                                  ref.read(uploadFileNotifierProvider.notifier);
                              final image = await newImageProvider.pickImage();
                              if (image != null) {
                                try {
                                  ref
                                      .read(isLoadingProvider("setImage")
                                          .notifier)
                                      .state = true;

                                  final uploaded = await newImageProvider
                                      .uploadFile(File(image.path));
                                  formGroup.control('image').value = uploaded;
                                } finally {
                                  ref
                                      .read(isLoadingProvider("setImage")
                                          .notifier)
                                      .state = false;
                                }
                              }
                            },
                            child: Container(
                              height: 30.h,
                              width: 30.h,
                              decoration: BoxDecoration(
                                  color: AppColor.primary,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: AppColor.primary, width: 2)),
                              child: const Icon(
                                FontAwesomeIcons.pen,
                                color: Colors.white,
                                size: 14,
                              ),
                            ),
                          ))
                    ],
                  ),
                  Text(
                    "ID: #${ref.read(userProvider)?.id}",
                    style: AppFont.subLabelTextField
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Gap(10.h),
                  SizedBox(
                    height: 60,
                    width: 200.w,
                    child: Center(
                      child:
                          ReactiveFormConsumer(builder: (context, form, child) {
                        final numOfErrors = formGroup.controls.entries
                            .where((ele) => !ele.key.contains("image_id"))
                            .map((e) => e.value)
                            .where((element) => element.invalid)
                            .length;
                        return SizedBox(
                          child: Column(
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text("Personal info".tr),
                                  Gap(5.w),
                                  ImageOrSvg(
                                    Assets.base.frame195,
                                    isLocal: true,
                                  ),
                                  Gap(5.w),
                                  if (numOfErrors != 0)
                                    Badge(
                                      label: Text("$numOfErrors"),
                                    ),
                                ],
                              ),
                              const Divider(
                                thickness: 2,
                                color: AppColor.primary,
                              )
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                  EditPersonalInfo(formGroup: formGroup),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.paddingOf(context).bottom,
          left: 12,
          right: 12,
        ),
        child: CustomReactiveFormValidationConsumer(
            formGroup: formGroup,
            builder: (BuildContext context, FormGroup form, Widget? child) {
              return Consumer(
                builder: (BuildContext context, ref, Widget? child) {
                  final isLoading =
                      ref.watch(isLoadingProvider("updateProfile"));
                  return CustomFilledButton(
                    isLoading: isLoading,
                    isValid: form.valid,
                    onPressed: () async {
                      if (form.valid) {
                        try {
                          ref
                              .read(isLoadingProvider("updateProfile").notifier)
                              .state = true;
                          final res = await getIt<UpdateProfileUseCase>().call(
                            {...form.value}
                              ..removeWhere((key, value) => value == null),
                          );
                          res.fold((l) {
                            UIHelper.showAlert(l.message,
                                type: DialogType.error);
                          }, (r) {
                            UIHelper.showAlert(r);
                            ref.read(rootIndex.notifier).setSelectedIndex(0);
                            return ref.refresh(refreshProfileProvider.future);
                          });
                        } finally {
                          ref
                              .read(isLoadingProvider("updateProfile").notifier)
                              .state = false;
                        }
                      } else {
                        form.markAllAsTouched();
                      }
                    },
                    text: "Save".tr,
                  );
                },
              );
            }),
      ),
    );
  }
}
