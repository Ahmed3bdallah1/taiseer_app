import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:taiseer/features/company_features/add_company/domain/use_case/add_company_use_case.dart';
import 'package:taiseer/features/company_features/add_company/presentation/manager/fetch_add_company_provider.dart';
import 'package:taiseer/features/company_features/add_company/presentation/view/widgets/company_activites_info.dart';
import 'package:taiseer/features/company_features/add_company/presentation/view/widgets/company_images.dart';
import 'package:taiseer/features/company_features/add_company/presentation/view/widgets/company_info.dart';
import 'package:taiseer/features/company_features/company_root/view/company_root_view.dart';
import 'package:taiseer/features/shared/auth/presentation/manager/auth_provuder.dart';
import 'package:taiseer/ui/shared_widgets/container_button.dart';
import 'package:taiseer/ui/shared_widgets/fade_in_animation.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../../config/app_color.dart';
import '../../../../../core/service/loading_provider.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../main.dart';
import '../../../../../ui/shared_widgets/custom_filled_button.dart';
import '../../../../../ui/shared_widgets/custom_logo_app_bar.dart';
import '../../../../../ui/shared_widgets/image_or_svg.dart';
import '../../../../../ui/shared_widgets/select_language_tile.dart';
import '../../../../../ui/ui.dart';
import '../../../../shared/auth/domain/entities/auth_entity.dart';
import '../../../../user_features/order/presentation/view/order_screen.dart';
import '../../../../user_features/order/presentation/view/widgets/selectable_tile.dart';
import '../../../../user_features/user_company/domain/entity/attributes_entity.dart';

class AddCompanyScreen extends ConsumerStatefulWidget {
  const AddCompanyScreen({super.key});

  @override
  ConsumerState<AddCompanyScreen> createState() => _AddCompanyScreenState();
}

class _AddCompanyScreenState extends ConsumerState<AddCompanyScreen> {
  final PageController controller = PageController(initialPage: 0);
  late final FormGroup formGroup;
  final ValueNotifier<double> currentPageNotifier = ValueNotifier<double>(0.0);

  @override
  void initState() {
    formGroup = FormGroup({
      'index': FormControl<int>(value: 0),
      'step0': FormGroup({
        'arabic_company_name': FormControl(validators: [Validators.required]),
        'english_company_name': FormControl(validators: [Validators.required]),
        'email': FormControl<String>(validators: [Validators.required]),
        'country': FormControl<int>(),
        'license_number': FormControl<int>(validators: [
          Validators.required,
        ]),
        'company_description': FormControl(validators: [
          Validators.required,
          Validators.minLength(8),
        ]),
      }),
      'step1': FormGroup({
        'countries': FormControl<List<CountryEntity>>(
            validators: [Validators.required], value: []),
        'attributes': FormControl<List<AttributesEntity>>(
            validators: [Validators.required], value: []),
        'manager_name': FormControl<String>(validators: [Validators.required]),
        'personal_id_image': FormControl<String>(),
      }),
      'step2': FormGroup({
        'company_logo_image': FormControl<String>(),
        'company_cover_image': FormControl<String>(),
        'official_license_image': FormControl<String>(),
      }),
    });

    final FormGroup form = formGroup.control("step0") as FormGroup;
    form.addAll({
      'phone': FormControl(validators: [
        Validators.compose([
          Validators.required,
          Validators.delegate((controls) {
            final res = form.control('country').value is int;
            if (res) {
              return null;
            } else {
              return {'please select country'.tr: 'please select country'};
            }
          })
        ])
      ], value: null),
    });

    formGroup.control('index').valueChanges.listen((event) {
      controller.jumpToPage(event);
    });

    super.initState();
  }

  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(fetchAddCompanyProvider);
    return Scaffold(
      backgroundColor: AppColor.primaryWhite,
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
      body: provider.customWhen(
          ref: ref,
          refreshable: fetchAddCompanyProvider.future,
          data: (addCompany) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                children: [
                  Gap(15.h),
                  SizedBox(
                    height: 40,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (controller.hasClients && controller.page != 0)
                          FadeInAnimation(
                            delay: .8,
                            fadeOffset: 30,
                            direction: FadeInDirection.rightToLeft,
                            child: Row(
                              children: [
                                ContainerButton(
                                  size: 35,
                                  color: Colors.transparent,
                                  icon: Icons.arrow_back,
                                  onTap: () {
                                    controller.jumpToPage(
                                        controller.page!.toInt() - 1);
                                    setState(() {});
                                  },
                                ),
                                Gap(8.w)
                              ],
                            ),
                          ),
                        Text("Register new company".tr,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Gap(16.h),
                  ValueListenableBuilder<double>(
                    valueListenable: currentPageNotifier,
                    builder: (BuildContext context, double value, _) {
                      return LinearProgressIndicator(
                        minHeight: 8,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        value: (value + 1) / 3,
                        color: AppColor.primary,
                        backgroundColor: AppColor.gray_3,
                      );
                    },
                  ),
                  Gap(20.h),
                  Expanded(
                    child: PageView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      onPageChanged: (val) {
                        formGroup.control('index').updateValue(val);
                        currentPageNotifier.value = val.toDouble();
                      },
                      itemCount: 3,
                      controller: controller,
                      itemBuilder: (BuildContext context, int index) {
                        return ReactiveForm(
                            formGroup:
                                formGroup.control('step$index') as FormGroup,
                            child: [
                              CompanyInfo(
                                scrollController: scrollController,
                                addCompanyModel: addCompany,
                              ),
                              CompanyActivitiesInfo(
                                  scrollController: scrollController,
                                  addCompanyModel: addCompany),
                              CompanyImagesInfo(
                                  scrollController: scrollController)
                              // OfficialContracts(
                              //   scrollController: scrollController,
                              //   loanDetailsEntity: widget.loanEntity,
                              // )
                            ][index]);
                      },
                    ),
                  )
                ],
              ),
            );
          }),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ReactiveForm(
          formGroup: formGroup,
          child: ReactiveFormConsumer(
            builder: (BuildContext context, FormGroup bigForm, Widget? child) {
              final index = bigForm.control('index').value;
              final smallFormGroup =
                  (bigForm.control("step$index") as FormGroup);
              final isValid = smallFormGroup.valid;
              return Consumer(
                builder: (context, ref, child) {
                  final isLastPage =
                      controller.hasClients && controller.page?.toInt() == 2;
                  return CustomFilledButton(
                    isLoading: ref.watch(isLoadingProvider("addCompany")),
                    text: isLastPage ? "submit".tr : "next".tr,
                    onPressed: () async {
                      if (isValid) {
                        if (isLastPage) {
                          final data =
                              _handle(flattenMap({...formGroup.value}));

                          try {
                            ref
                                .read(isLoadingProvider("addCompany").notifier)
                                .state = true;
                            final res = await getIt<AddCompanyUseCase>()(data);
                            return res.fold((l) async {
                              UIHelper.showAlert(
                                l.message,
                                type: DialogType.error,
                              );
                            }, (r) async {
                              await UIHelper.showAlert(
                                "Company Added Successfully".tr,
                                type: DialogType.success,
                              );
                              Get.offAll(() => const CompanyRootView());
                            });
                          } finally {
                            ref
                                .read(isLoadingProvider("addCompany").notifier)
                                .state = false;
                          }
                        } else {
                          controller.jumpToPage(index + 1);
                          setState(() {});
                        }
                      } else {
                        smallFormGroup.markAllAsTouched();
                      }
                    },
                    isValid: isValid,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

Map<String, dynamic> _handle(Map<String, dynamic> data) {
  final map = {
    ...data,
    'contracts': jsonEncode([
      for (final item in data.entries.where((e) => e.key.contains("contract")))
        {
          'id': item.key.numericOnly(),
          'signature': item.value,
        }
    ])
  };
  map.removeWhere(
      (key, value) => key.contains("contract[") || key.contains('index'));
  return map;
}
