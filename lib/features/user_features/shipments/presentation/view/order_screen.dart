import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:taiseer/core/service/loading_provider.dart';
import 'package:taiseer/features/shared/auth/presentation/manager/auth_provuder.dart';
import 'package:taiseer/features/user_features/root/view/root_view.dart';
import 'package:taiseer/features/user_features/shipments/data/models/shipment_model.dart';
import 'package:taiseer/features/user_features/shipments/domain/use_cases/shipment_use_cases.dart';
import 'package:taiseer/features/user_features/shipments/presentation/view/widgets/selectable_tile.dart';
import 'package:taiseer/features/user_features/user_company/data/model/company_details_model.dart';
import 'package:taiseer/ui/shared_widgets/custom_filled_button.dart';
import 'package:taiseer/ui/shared_widgets/custom_text_field.dart';
import 'package:taiseer/ui/ui.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../../../../../config/app_font.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../main.dart';
import '../../../../../ui/shared_widgets/custom_logo_app_bar.dart';
import '../../../../../ui/shared_widgets/custom_reactive_form_consumer.dart';
import '../../../../../ui/shared_widgets/image_or_svg.dart';
import '../../../../company_features/add_company/presentation/manager/image_notifier.dart';
import '../../../../shared/auth/domain/entities/auth_entity.dart';
import '../../../user_company/data/model/company_model.dart';
import '../../../user_company/presentation/view/widgets/company_container.dart';
import '../../../user_company/presentation/view/shipping_method_tile.dart';

class OrderScreen extends ConsumerStatefulWidget {
  final CompanyDetailsModel companyDetailsModel;
  final UserCompanyModel2 companyModel;
  final bool isGlobal;
  final bool viewOnly;

  const OrderScreen({
    super.key,
    required this.companyDetailsModel,
    required this.companyModel,
    this.isGlobal = false,
    this.viewOnly = false,
  });

  @override
  ConsumerState<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends ConsumerState<OrderScreen> {
  late final FormGroup formGroup;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    formGroup = FormGroup({
      'company_id': FormControl(
        value: widget.isGlobal ? 0 : widget.companyDetailsModel.id,
      ),
      'typeActivity_id': FormControl<List<int>?>(
          validators: [Validators.required],
          value: widget.isGlobal ? [1] : null),
      'is_fast_shipping':
          FormControl<bool>(validators: [Validators.required], value: false),
      'shipment_type': FormControl<String>(
          validators: [Validators.required], value: "general"),
      "content_description": FormControl(validators: [Validators.required]),
      'expected_delivery_date': FormControl(validators: [Validators.required]),
      'amount': FormControl<String>(validators: [Validators.required]),
      'payment_method':
          FormControl<String>(validators: [Validators.required], value: "cash"),
      'from_area': FormControl<String>(validators: [Validators.required]),
      'from_city_id': FormControl<int>(validators: [Validators.required]),
      'from_country_id': FormControl<int>(validators: [Validators.required]),
      'from_latitude': FormControl<double>(
          validators: [Validators.required], value: 40.712776),
      'from_longitude': FormControl<double>(
          validators: [Validators.required], value: -74.005974),
      'from_address_line':
          FormControl<String>(validators: [Validators.required]),
      // دى متستقبلهاش
      'sender_number_country': FormControl<int>(),
      'sender_number': FormControl<String>(validators: [Validators.required]),
      'to_address_line': FormControl<String>(validators: [Validators.required]),
      'to_country_id': FormControl<int>(validators: [Validators.required]),
      'to_city_id': FormControl<int>(validators: [Validators.required]),
      'to_area': FormControl<String>(validators: [Validators.required]),
      'to_latitude': FormControl<double>(
          validators: [Validators.required], value: 40.712776),
      'to_longitude': FormControl<double>(
          validators: [Validators.required], value: -74.005974),
      'receiver_name': FormControl<String>(validators: [Validators.required]),
      // دى متستقبلهاش
      'receiver_phone_country': FormControl<int>(),
      'receiver_phone': FormControl<String>(validators: [Validators.required]),

      'shipping_images': FormControl<List<String>>(validators: []),
    });

    formGroup.control('sender_number').setValidators([
      Validators.compose([
        Validators.required,
        Validators.delegate((controls) {
          final res = formGroup.control('sender_number_country').value is int;
          if (res) {
            return null;
          } else {
            return {'please select country'.tr: 'please select country'};
          }
        })
      ])
    ]);

    formGroup.control('receiver_phone').setValidators([
      Validators.compose([
        Validators.required,
        Validators.delegate((control) {
          final res = formGroup.control('receiver_phone_country').value is int;
          if (res) {
            return null;
          } else {
            return {'please select country'.tr: 'sdfdsfds'};
          }
        })
      ])
    ]);

    // formGroup.control('index').valueChanges.listen((event) {
    //   controller.jumpToPage(event);
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final country = ref.watch(fetchCountryProvider).value;
    return Scaffold(
      backgroundColor: AppColor.primaryWhite,
      appBar: CustomLogoAppbar(
        scrollController: scrollController,
        hideActions: true,
        customTitleWidget: Text(
          "apply".tr,
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 60),
        child: SingleChildScrollView(
          child: ReactiveForm(
            formGroup: formGroup,
            child: Column(
              children: [
                widget.isGlobal
                    ? SizedBox(
                        height: 70,
                        child: ListView.separated(
                          itemCount: 5,
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (context, index) {
                            return const Gap(2);
                          },
                          itemBuilder: (context, index) {
                            return Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: index % 2 == 0
                                    ? AppColor.grey1.withOpacity(.5)
                                    : AppColor.grey_3.withOpacity(.5),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ImageOrSvg(Assets.onboard.vector,
                                  isLocal: true, width: 60, height: 60),
                            );
                          },
                        ),
                      )
                    : CompanyContainer(companyModel: widget.companyModel),
                Gap(24.h),
                Row(
                  children: [
                    const Icon(
                      CupertinoIcons.cube_box,
                      color: AppColor.primary,
                    ),
                    Gap(10.w),
                    Text(
                      "Select service".tr,
                      style: AppFont.font18W700Black,
                    ),
                    Gap(10.w),
                    ReactiveFormConsumer(builder: (context, form, _) {
                      final value =
                          form.control("typeActivity_id").value as List<int>? ??
                              [];
                      if (form.control("typeActivity_id").value == null) {
                        return const SizedBox.shrink();
                      }
                      return Container(
                        decoration: BoxDecoration(
                            color: AppColor.grey1,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 2),
                          child: Text(widget.companyModel.typeActivityCompanies!
                                  .firstWhereOrNull((e) => value.contains(e.id))
                                  ?.typeActivities
                                  ?.infoAr ??
                              ''),
                        ),
                      );
                    })
                  ],
                ),
                Gap(16.h),
                SizedBox(
                  height: 95,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: [
                        Expanded(
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return ReactiveFormConsumer(
                                builder: (context, form, _) {
                                  final value = form
                                          .control("typeActivity_id")
                                          .value as List<int>? ??
                                      [];
                                  if (index !=
                                      widget.companyDetailsModel
                                          .typeActivityCompanies.length) {
                                    final isSelected = value.contains(widget
                                        .companyDetailsModel
                                        .typeActivityCompanies[index]
                                        .id);
                                    return ShippingMethodTile(
                                      color: AppColor.black.withOpacity(.1),
                                      shippingMethodsEntity: widget
                                          .companyDetailsModel
                                          .typeActivityCompanies[index],
                                      hideSelectedItem: false,
                                      isSelected: isSelected,
                                      onTap: () {
                                        if (isSelected) {
                                          value.removeWhere((e) =>
                                              e ==
                                              widget
                                                  .companyDetailsModel
                                                  .typeActivityCompanies[index]
                                                  .id);
                                          form
                                              .control("typeActivity_id")
                                              .updateValue(value);
                                        } else {
                                          value.add(widget.companyDetailsModel
                                              .typeActivityCompanies[index].id);
                                          form
                                              .control("typeActivity_id")
                                              .updateValue(value);
                                        }
                                        setState(() {});
                                      },
                                    );
                                  } else {
                                    return ReactiveFormConsumer(
                                      builder: (context, form, _) {
                                        bool isFastSelected = form
                                                .control("is_fast_shipping")
                                                .value ==
                                            true;
                                        return FastShippingMethodTile(
                                          color: Colors.white,
                                          isSelected: isFastSelected,
                                          onTap: () {
                                            form
                                                .control("is_fast_shipping")
                                                .value = !isFastSelected;
                                          },
                                        );
                                      },
                                    );
                                  }
                                },
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Gap(10.w);
                            },
                            itemCount: widget.companyDetailsModel
                                    .typeActivityCompanies.length +
                                1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Gap(24.h),
                Row(
                  children: [
                    const Icon(
                      FontAwesomeIcons.image,
                      color: AppColor.primary,
                    ),
                    Gap(10.w),
                    Text(
                      "Shipment images".tr,
                      style: AppFont.font18W700Black,
                    ),
                  ],
                ),
                Gap(16.h),
                ReactiveFormConsumer(builder: (context, form, _) {
                  final images =
                      form.control("shipping_images").value as List<String>? ??
                          [];
                  final isLoadingImages =
                      ref.watch(isLoadingProvider("shipping_images"));
                  ref.watch(uploadFileNotifierProvider3(''));
                  final newImageProvider =
                      ref.read(uploadFileNotifierProvider3('').notifier);
                  return SizedBox(
                    width: double.infinity,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () async {
                              final imageFile =
                                  await newImageProvider.pickImage();
                              if (imageFile != null) {
                                try {
                                  ref
                                      .read(isLoadingProvider("add_button")
                                          .notifier)
                                      .state = true;

                                  final uploaded = await newImageProvider
                                      .uploadFile(File(imageFile.path));
                                  images.add(uploaded);
                                  form.control("shipping_images").value =
                                      images;
                                } finally {
                                  if (context.mounted) {
                                    ref
                                        .read(isLoadingProvider("add_button")
                                            .notifier)
                                        .state = false;
                                  }
                                }
                              }
                            },
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .disabledColor
                                    .withOpacity(.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Icon(
                                  Icons.add_photo_alternate_outlined,
                                  size: 50,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ),
                          Gap(6.w),
                          ...images.asMap().entries.map(
                            (entry) {
                              final imageUrl = entry.value;

                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColor.primary.withOpacity(.8),
                                      ),
                                      child: ImageOrSvg(
                                        width: 80,
                                        height: 80,
                                        // fit: BoxFit.fill,
                                        imageUrl,
                                        isLoading: isLoadingImages,
                                      ),
                                    ),
                                    PositionedDirectional(
                                        bottom: 0,
                                        end: 0,
                                        child: InkWell(
                                          onTap: () {
                                            final list = List<String>.from(form
                                                .control('shipping_images')
                                                .value);
                                            list.remove(imageUrl);
                                            form
                                                .control('shipping_images')
                                                .updateValue(list);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: AppColor.danger,
                                                borderRadius:
                                                    const BorderRadiusDirectional
                                                        .only(
                                                        bottomEnd:
                                                            Radius.circular(10),
                                                        topStart:
                                                            Radius.circular(
                                                                8))),
                                            child: Icon(
                                              Icons.close,
                                              color: AppColor.white,
                                            ),
                                          ),
                                        ))
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }),
                Gap(24.h),
                CustomTextField(
                  formControlName: "content_description",
                  hintText: "Editing field".tr,
                  labelText: "Shipment details".tr,
                ),
                Gap(24.h),
                Row(
                  children: [
                    Expanded(
                      child: CustomReactiveFormConsumer(
                        builder: (context, form, _) {
                          return InkWell(
                            onTap: () {
                              UIHelper.pickDate(
                                context: context,
                                date: null,
                              ).then((value) {
                                if (value != null) {
                                  final elements = intl.DateFormat.yMd('en')
                                      .format(value)
                                      .split("/")
                                      .reversed
                                      .toList();
                                  List value2 = [
                                    elements[0],
                                    elements[2],
                                    elements[1]
                                  ];
                                  print(value2.join("-"));
                                  form.control("expected_delivery_date").value =
                                      value2.join("-");
                                }
                              });
                            },
                            child: CustomTextField(
                              ignore: true,
                              labelText: "shipment date".tr,
                              hintText: "DD/MM/YYYY",
                              formControlName: "expected_delivery_date",
                            ),
                          );
                        },
                      ),
                    ),
                    Gap(10.w),
                    Expanded(
                      child: CustomTextField(
                        labelText: "shipment price".tr,
                        hintText: "Expected price".tr,
                        formControlName: "amount",
                      ),
                    ),
                  ],
                ),
                Gap(16.h),

                /// this will be replaced with string
                ReactiveFormConsumer(
                  builder: (context, form, _) {
                    final value = form.control("shipment_type").value;
                    return Row(
                      children: [
                        Expanded(
                          child: SelectableTile(
                            name: "Local shipping".tr,
                            isSelected: value == "general" ? false : true,
                            onTap: () =>
                                form.control("shipment_type").value = "",
                          ),
                        ),
                        Gap(10.w),
                        Expanded(
                          child: SelectableTile(
                            name: "Global shipping".tr,
                            isSelected: value == "general" ? true : false,
                            onTap: () =>
                                form.control("shipment_type").value = "general",
                          ),
                        ),
                      ],
                    );
                  },
                ),
                Gap(24.h),
                ReactiveFormConsumer(builder: (context, form, _) {
                  CountryEntity? cities;
                  if (form.control('from_country_id').value != null) {
                    cities = country!
                        .where((e) =>
                            e.id == form.control('from_country_id').value)
                        .firstOrNull;
                  }
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: CustomTextField<int>(
                          labelText: "Sender country".tr,
                          formControlName: "from_country_id",
                          hintText: "Egypt".tr,
                          type: TextFieldType.selectable,
                          items: country!.map((e) {
                            return DropdownMenuItem<int>(
                              value: e.id,
                              child: Row(
                                children: [
                                  ImageOrSvg(
                                    e.countryImage,
                                    height: 30,
                                  ),
                                  Gap(8.w),
                                  Text(
                                    e.nameAr ?? "",
                                    style: AppFont.font14W600Primary,
                                  )
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      Gap(10.w),
                      Expanded(
                        child: CustomTextField(
                          labelText: "Sender government".tr,
                          formControlName: "from_city_id",
                          hintText: "Cairo".tr,
                          type: TextFieldType.selectable,
                          items: cities == null
                              ? []
                              : cities.cities!.map((e) {
                                  return DropdownMenuItem(
                                    value: e.id,
                                    child: Text(
                                      e.titleAr ?? "",
                                      style: AppFont.font14W600Primary,
                                    ),
                                  );
                                }).toList(),
                        ),
                      ),
                    ],
                  );
                }),
                Gap(24.h),
                CustomTextField(
                  formControlName: "from_area",
                  hintText: "Sender area".tr,
                  labelText: "Sender area".tr,
                ),
                Gap(16.h),
                ReactiveFormConsumer(builder: (context, form, _) {
                  final max = country!
                          .firstWhereOrNull((e) =>
                              e.id ==
                              form.control('sender_number_country').value)
                          ?.numberLength ??
                      9;
                  return CustomTextField(
                    iconButton: SizedBox(
                      width: 124,
                      height: 55,
                      child: ReactiveDropdownField(
                        onChanged: (_) {
                          form.control('sender_number').value = null;
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
                        formControlName: "sender_number_country",
                        items: country.map((e) {
                          return DropdownMenuItem(
                            value: e.id,
                            child: Row(
                              children: [
                                ImageOrSvg(
                                  e.countryImage,
                                  height: 30,
                                ),
                                Gap(8.w),
                                Text(
                                  e.nameAr ?? "",
                                  style: AppFont.font14W600Primary,
                                )
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    formControlName: "sender_number",
                    hintText: "000 000 000",
                    labelText: "sender number".tr,
                    inputType: TextInputType.number,
                    inputFormatter: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(max)
                    ],
                  );
                }),
                Gap(16.h),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        formControlName: "from_address_line",
                        hintText: "Editing field".tr,
                        labelText: "Shipping address".tr,
                        maxLines: 4,
                      ),
                    ),
                    Gap(10.w),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: AppColor.primary,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Icon(Icons.location_on_outlined,
                            color: AppColor.whiteOrGrey),
                      ),
                    )
                  ],
                ),
                Gap(16.h),
                ReactiveFormConsumer(builder: (context, form, _) {
                  CountryEntity? cities;
                  if (form.control('to_country_id').value != null) {
                    cities = country!
                        .where(
                            (e) => e.id == form.control('to_country_id').value)
                        .firstOrNull;
                  }
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: CustomTextField<int>(
                          labelText: "Delivery country".tr,
                          formControlName: "to_country_id",
                          hintText: "Egypt".tr,
                          type: TextFieldType.selectable,
                          items: country!.map((e) {
                            return DropdownMenuItem<int>(
                              value: e.id,
                              child: Row(
                                children: [
                                  ImageOrSvg(
                                    e.countryImage,
                                    height: 30,
                                  ),
                                  Gap(8.w),
                                  Text(
                                    e.nameAr ?? "",
                                    style: AppFont.font14W600Primary,
                                  )
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      Gap(10.w),
                      Expanded(
                        child: CustomTextField(
                          labelText: "Delivery government".tr,
                          formControlName: "to_city_id",
                          hintText: "Cairo".tr,
                          type: TextFieldType.selectable,
                          items: cities == null
                              ? []
                              : cities.cities!.map((e) {
                                  return DropdownMenuItem(
                                    value: e.id,
                                    child: Text(
                                      e.titleAr ?? "",
                                      style: AppFont.font14W600Primary,
                                    ),
                                  );
                                }).toList(),
                        ),
                      ),
                    ],
                  );
                }),
                Gap(16.h),
                CustomTextField(
                  formControlName: "receiver_name",
                  hintText: "User".tr,
                  labelText: "Receiver name".tr,
                ),
                Gap(16.h),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        formControlName: "to_address_line",
                        hintText: "Editing field".tr,
                        labelText: "delivery address".tr,
                        maxLines: 4,
                      ),
                    ),
                    Gap(10.w),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: AppColor.primary,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Icon(Icons.location_on_outlined,
                            color: AppColor.whiteOrGrey),
                      ),
                    )
                  ],
                ),
                Gap(16.h),
                CustomTextField(
                  formControlName: "to_area",
                  hintText: "receiver area".tr,
                  labelText: "receiver area".tr,
                ),
                Gap(16.h),
                ReactiveFormConsumer(builder: (context, form, _) {
                  final max = country!
                          .firstWhereOrNull((e) =>
                              e.id ==
                              form.control('receiver_phone_country').value)
                          ?.numberLength ??
                      9;
                  return CustomTextField(
                    iconButton: SizedBox(
                      width: 124,
                      height: 55,
                      child: ReactiveDropdownField(
                        onChanged: (_) {
                          form.control('receiver_phone').value = null;
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
                        formControlName: "receiver_phone_country",
                        items: country.map((e) {
                          return DropdownMenuItem(
                            value: e.id,
                            child: Row(
                              children: [
                                ImageOrSvg(
                                  e.countryImage,
                                  height: 30,
                                ),
                                Gap(8.w),
                                Text(
                                  e.nameAr ?? "",
                                  style: AppFont.font14W600Primary,
                                )
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    formControlName: "receiver_phone",
                    hintText: "000 000 000",
                    labelText: "receiver number".tr,
                    inputType: TextInputType.number,
                    inputFormatter: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(max)
                    ],
                  );
                }),
                Gap(70.h)
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ReactiveForm(
          formGroup: formGroup,
          child: ReactiveFormConsumer(
            builder: (BuildContext context, FormGroup form, Widget? child) {
              final isValid = form.valid;
              return CustomFilledButton(
                text: "next".tr,
                onPressed: () async {
                  if (form.valid) {
                    try {
                      ref.read(isLoadingProvider("submit").notifier).state =
                          true;
                      final res = await getIt<SubmitShipmentUseCase>().call(
                        {...form.value}
                          ..removeWhere((key, value) => value == null),
                      );
                      res.fold((l) {
                        UIHelper.showAlert(l.message, type: DialogType.error);
                      }, (r) async {
                        await UIHelper.showAlert(
                            "Shipment submitted successfully".tr);
                        Get.offAll(() => const RootView());
                      });
                    } finally {
                      ref.read(isLoadingProvider("submit").notifier).state =
                          false;
                    }
                  } else {
                    form.markAllAsTouched();
                  }
                },
                isValid: isValid,
                isLoading: ref.watch(isLoadingProvider("submit")),
              );
            },
          ),
        ),
      ),
    );
  }
}

///
///
///
///
///
///
///
///
///
///
///
//
// class GlobalOrderScreen extends ConsumerStatefulWidget {
//   const GlobalOrderScreen({super.key});
//
//   @override
//   ConsumerState<GlobalOrderScreen> createState() => _GlobalOrderScreenState();
// }
//
// class _GlobalOrderScreenState extends ConsumerState<GlobalOrderScreen> {
//   late final FormGroup formGroup;
//   final ScrollController scrollController = ScrollController();
//
//   @override
//   void initState() {
//     formGroup = FormGroup({
//       'company_id': FormControl(value: 0),
//       'typeActivity_id[]': FormControl<int>(validators: [Validators.required]),
//       'is_fast_shipping':
//           FormControl<bool>(validators: [Validators.required], value: false),
//       'shipment_type':
//           FormControl<int>(validators: [Validators.required], value: 1),
//       "content_description": FormControl(validators: [Validators.required]),
//       'expected_delivery_date': FormControl(validators: [Validators.required]),
//       'amount': FormControl<String>(validators: [Validators.required]),
//       'payment_method':
//           FormControl<String>(validators: [Validators.required], value: "cash"),
//       'from_area': FormControl<String>(validators: [Validators.required]),
//       'from_city_id': FormControl<int>(validators: [Validators.required]),
//       'from_country_id': FormControl<int>(validators: [Validators.required]),
//       'from_latitude': FormControl<double>(
//           validators: [Validators.required], value: 40.712776),
//       'from_longitude': FormControl<double>(
//           validators: [Validators.required], value: -74.005974),
//       'from_address_line':
//           FormControl<String>(validators: [Validators.required]),
//       // دى متستقبلهاش
//       'sender_number_country': FormControl<int>(),
//       'sender_number': FormControl<String>(validators: [Validators.required]),
//       'to_address_line': FormControl<String>(validators: [Validators.required]),
//       'to_country_id': FormControl<int>(validators: [Validators.required]),
//       'to_city_id': FormControl<int>(validators: [Validators.required]),
//       'to_area': FormControl<int>(validators: [Validators.required]),
//       'to_latitude': FormControl<double>(
//           validators: [Validators.required], value: 40.712776),
//       'to_longitude': FormControl<double>(
//           validators: [Validators.required], value: -74.005974),
//       'receiver_name': FormControl<String>(validators: [Validators.required]),
//       // دى متستقبلهاش
//       'receiver_phone_country': FormControl<int>(),
//       'receiver_phone': FormControl<String>(validators: [Validators.required]),
//
//       'shipping_images':
//           FormControl<List<String>>(validators: [Validators.required]),
//     });
//
//     formGroup.control('sender_number').setValidators([
//       Validators.compose([
//         Validators.required,
//         Validators.delegate((controls) {
//           final res = formGroup.control('sender_number_country').value is int;
//           if (res) {
//             return null;
//           } else {
//             return {'please select country'.tr: 'please select country'};
//           }
//         })
//       ])
//     ]);
//
//     formGroup.control('receiver_phone').setValidators([
//       Validators.compose([
//         Validators.required,
//         Validators.delegate((control) {
//           final res = formGroup.control('receiver_phone_country').value is int;
//           if (res) {
//             return null;
//           } else {
//             return {'please select country'.tr: 'sdfdsfds'};
//           }
//         })
//       ])
//     ]);
//
//     // formGroup.control('index').valueChanges.listen((event) {
//     //   controller.jumpToPage(event);
//     // });
//
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final country = ref.watch(fetchCountryProvider).value;
//     return Scaffold(
//       backgroundColor: AppColor.primaryWhite,
//       appBar: CustomLogoAppbar(
//         scrollController: scrollController,
//         hideActions: true,
//         customTitleWidget: Text(
//           "apply".tr,
//         ),
//       ),
//       body: Padding(
//         padding:
//             const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 60),
//         child: SingleChildScrollView(
//           child: ReactiveForm(
//             formGroup: formGroup,
//             child: Column(
//               children: [
//                 // CompanyContainer(companyModel: widget.companyModel),
//                 // Gap(24.h),
//                 // Row(
//                 //   children: [
//                 //     const Icon(
//                 //       CupertinoIcons.cube_box,
//                 //       color: AppColor.primary,
//                 //     ),
//                 //     Gap(10.w),
//                 //     Text(
//                 //       "Select service".tr,
//                 //       style: AppFont.font18W700Black,
//                 //     ),
//                 //     Gap(10.w),
//                 //     ReactiveFormConsumer(builder: (context, form, _) {
//                 //       if (form.control("typeActivity_id[]").value == null) {
//                 //         return const SizedBox.shrink();
//                 //       }
//                 //       return Container(
//                 //         decoration: BoxDecoration(
//                 //             color: AppColor.grey1,
//                 //             borderRadius: BorderRadius.circular(20)),
//                 //         child: Padding(
//                 //           padding: const EdgeInsets.symmetric(
//                 //               horizontal: 12, vertical: 2),
//                 //           child: Text(widget.companyModel.typeActivityCompanies!
//                 //                   .firstWhereOrNull((e) =>
//                 //                       e.id ==
//                 //                       form.control("typeActivity_id[]").value)
//                 //                   ?.typeActivities
//                 //                   ?.infoAr ??
//                 //               ''),
//                 //         ),
//                 //       );
//                 //     })
//                 //   ],
//                 // ),
//                 // Gap(16.h),
//                 // SizedBox(
//                 //   height: 95,
//                 //   child: Padding(
//                 //     padding: const EdgeInsets.symmetric(vertical: 5),
//                 //     child: Row(
//                 //       children: [
//                 //         Expanded(
//                 //           child: ListView.separated(
//                 //             scrollDirection: Axis.horizontal,
//                 //             shrinkWrap: true,
//                 //             itemBuilder: (context, index) {
//                 //               return ReactiveFormConsumer(
//                 //                 builder: (context, form, _) {
//                 //                   if (index !=
//                 //                       widget.companyDetailsModel
//                 //                           .typeActivityCompanies.length) {
//                 //                     final isSelected =
//                 //                         form.control("typeActivity_id[]").value ==
//                 //                             widget
//                 //                                 .companyDetailsModel
//                 //                                 .typeActivityCompanies[index]
//                 //                                 .id;
//                 //                     return ShippingMethodTile(
//                 //                       color: AppColor.black.withOpacity(.1),
//                 //                       shippingMethodsEntity: widget
//                 //                           .companyDetailsModel
//                 //                           .typeActivityCompanies[index],
//                 //                       hideSelectedItem: false,
//                 //                       isSelected: isSelected,
//                 //                       onTap: () {
//                 //                         if (isSelected) {
//                 //                           form.control("typeActivity_id[]").value =
//                 //                               null;
//                 //                         } else {
//                 //                           form.control("typeActivity_id[]").value =
//                 //                               widget
//                 //                                   .companyDetailsModel
//                 //                                   .typeActivityCompanies[index]
//                 //                                   .id;
//                 //                         }
//                 //                       },
//                 //                     );
//                 //                   } else {
//                 //                     return ReactiveFormConsumer(
//                 //                       builder: (context, form, _) {
//                 //                         bool isFastSelected = form
//                 //                                 .control("is_fast_shipping")
//                 //                                 .value ==
//                 //                             true;
//                 //                         return FastShippingMethodTile(
//                 //                           color: Colors.white,
//                 //                           isSelected: isFastSelected,
//                 //                           onTap: () {
//                 //                             form
//                 //                                 .control("is_fast_shipping")
//                 //                                 .value = !isFastSelected;
//                 //                           },
//                 //                         );
//                 //                       },
//                 //                     );
//                 //                   }
//                 //                 },
//                 //               );
//                 //             },
//                 //             separatorBuilder: (context, index) {
//                 //               return Gap(10.w);
//                 //             },
//                 //             itemCount: widget.companyDetailsModel
//                 //                     .typeActivityCompanies.length +
//                 //                 1,
//                 //           ),
//                 //         ),
//                 //       ],
//                 //     ),
//                 //   ),
//                 // ),
//                 Gap(24.h),
//                 Row(
//                   children: [
//                     const Icon(
//                       FontAwesomeIcons.image,
//                       color: AppColor.primary,
//                     ),
//                     Gap(10.w),
//                     Text(
//                       "Shipment images".tr,
//                       style: AppFont.font18W700Black,
//                     ),
//                   ],
//                 ),
//                 Gap(16.h),
//                 ReactiveFormConsumer(builder: (context, form, _) {
//                   final images =
//                       form.control("shipping_images").value as List<String>? ??
//                           [];
//                   final isLoadingImages =
//                       ref.watch(isLoadingProvider("shipping_images"));
//                   ref.watch(uploadFileNotifierProvider3(''));
//                   final newImageProvider =
//                       ref.read(uploadFileNotifierProvider3('').notifier);
//                   return SizedBox(
//                     width: double.infinity,
//                     child: SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           InkWell(
//                             onTap: () async {
//                               final imageFile =
//                                   await newImageProvider.pickImage();
//                               if (imageFile != null) {
//                                 try {
//                                   ref
//                                       .read(isLoadingProvider("add_button")
//                                           .notifier)
//                                       .state = true;
//
//                                   final uploaded = await newImageProvider
//                                       .uploadFile(File(imageFile.path));
//                                   images.add(uploaded);
//                                   form.control("shipping_images").value =
//                                       images;
//                                 } finally {
//                                   if (context.mounted) {
//                                     ref
//                                         .read(isLoadingProvider("add_button")
//                                             .notifier)
//                                         .state = false;
//                                   }
//                                 }
//                               }
//                             },
//                             child: Container(
//                               width: 80,
//                               height: 80,
//                               decoration: BoxDecoration(
//                                 color: Theme.of(context)
//                                     .disabledColor
//                                     .withOpacity(.1),
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(10),
//                                 child: Icon(
//                                   Icons.add_photo_alternate_outlined,
//                                   size: 50,
//                                   color: Theme.of(context).primaryColor,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Gap(6.w),
//                           ...images.asMap().entries.map(
//                             (entry) {
//                               final imageUrl = entry.value;
//
//                               return Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 4.0),
//                                 child: Stack(
//                                   children: [
//                                     Container(
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(10),
//                                         color: AppColor.primary.withOpacity(.8),
//                                       ),
//                                       child: ImageOrSvg(
//                                         width: 80,
//                                         height: 80,
//                                         // fit: BoxFit.fill,
//                                         imageUrl,
//                                         isLoading: isLoadingImages,
//                                       ),
//                                     ),
//                                     PositionedDirectional(
//                                         bottom: 0,
//                                         end: 0,
//                                         child: InkWell(
//                                           onTap: () {
//                                             final list = List<String>.from(form
//                                                 .control('shipping_images')
//                                                 .value);
//                                             list.remove(imageUrl);
//                                             form
//                                                 .control('shipping_images')
//                                                 .updateValue(list);
//                                           },
//                                           child: Container(
//                                             decoration: BoxDecoration(
//                                                 color: AppColor.danger,
//                                                 borderRadius:
//                                                     const BorderRadiusDirectional
//                                                         .only(
//                                                         bottomEnd:
//                                                             Radius.circular(10),
//                                                         topStart:
//                                                             Radius.circular(
//                                                                 8))),
//                                             child: Icon(
//                                               Icons.close,
//                                               color: AppColor.white,
//                                             ),
//                                           ),
//                                         ))
//                                   ],
//                                 ),
//                               );
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 }),
//                 Gap(24.h),
//                 CustomTextField(
//                   formControlName: "content_description",
//                   hintText: "Editing field".tr,
//                   labelText: "Shipment details".tr,
//                 ),
//                 Gap(24.h),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: CustomReactiveFormConsumer(
//                         builder: (context, form, _) {
//                           return InkWell(
//                             onTap: () {
//                               UIHelper.pickDate(
//                                 context: context,
//                                 date: null,
//                               ).then((value) {
//                                 if (value != null) {
//                                   form.control("expected_delivery_date").value =
//                                       intl.DateFormat.yMd('en').format(value);
//                                 }
//                               });
//                             },
//                             child: CustomTextField(
//                               ignore: true,
//                               labelText: "shipment date".tr,
//                               hintText: "DD/MM/YYYY",
//                               formControlName: "expected_delivery_date",
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                     Gap(10.w),
//                     Expanded(
//                       child: CustomTextField(
//                         labelText: "shipment price".tr,
//                         hintText: "Expected price".tr,
//                         formControlName: "amount",
//                       ),
//                     ),
//                   ],
//                 ),
//                 Gap(16.h),
//                 ReactiveFormConsumer(
//                   builder: (context, form, _) {
//                     final value = form.control("shipment_type").value;
//                     return Row(
//                       children: [
//                         Expanded(
//                           child: SelectableTile(
//                             name: "Local shipping".tr,
//                             isSelected: value == 0 ? true : false,
//                             onTap: () =>
//                                 form.control("shipment_type").value = 0,
//                           ),
//                         ),
//                         Gap(10.w),
//                         Expanded(
//                           child: SelectableTile(
//                             name: "Global shipping".tr,
//                             isSelected: value == 1 ? true : false,
//                             onTap: () =>
//                                 form.control("shipment_type").value = 1,
//                           ),
//                         ),
//                       ],
//                     );
//                   },
//                 ),
//                 Gap(24.h),
//                 ReactiveFormConsumer(builder: (context, form, _) {
//                   CountryEntity? cities;
//                   if (form.control('from_country_id').value != null) {
//                     cities = country!
//                         .where((e) =>
//                             e.id == form.control('from_country_id').value)
//                         .firstOrNull;
//                   }
//                   return Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Expanded(
//                         child: CustomTextField<int>(
//                           labelText: "Sender country".tr,
//                           formControlName: "from_country_id",
//                           hintText: "Egypt".tr,
//                           type: TextFieldType.selectable,
//                           items: country!.map((e) {
//                             return DropdownMenuItem<int>(
//                               value: e.id,
//                               child: Row(
//                                 children: [
//                                   ImageOrSvg(
//                                     e.countryImage,
//                                     height: 30,
//                                   ),
//                                   Gap(8.w),
//                                   Text(
//                                     e.nameAr ?? "",
//                                     style: AppFont.font14W600Primary,
//                                   )
//                                 ],
//                               ),
//                             );
//                           }).toList(),
//                         ),
//                       ),
//                       Gap(10.w),
//                       Expanded(
//                         child: CustomTextField(
//                           labelText: "Sender government".tr,
//                           formControlName: "from_city_id",
//                           hintText: "Cairo".tr,
//                           type: TextFieldType.selectable,
//                           items: cities == null
//                               ? []
//                               : cities.cities!.map((e) {
//                                   return DropdownMenuItem(
//                                     value: e.id,
//                                     child: Text(
//                                       e.titleAr ?? "",
//                                       style: AppFont.font14W600Primary,
//                                     ),
//                                   );
//                                 }).toList(),
//                         ),
//                       ),
//                     ],
//                   );
//                 }),
//                 Gap(24.h),
//                 CustomTextField(
//                   formControlName: "from_area",
//                   hintText: "Sender area".tr,
//                   labelText: "Sender area".tr,
//                 ),
//                 Gap(16.h),
//                 ReactiveFormConsumer(builder: (context, form, _) {
//                   final max = country!
//                           .firstWhereOrNull((e) =>
//                               e.id ==
//                               form.control('sender_number_country').value)
//                           ?.numberLength ??
//                       9;
//                   return CustomTextField(
//                     iconButton: SizedBox(
//                       width: 124,
//                       height: 55,
//                       child: ReactiveDropdownField(
//                         onChanged: (_) {
//                           form.control('sender_number').value = null;
//                         },
//                         decoration: const InputDecoration(
//                           focusedBorder: InputBorder.none,
//                           enabledBorder: InputBorder.none,
//                         ),
//                         iconEnabledColor: AppColor.primary,
//                         iconDisabledColor: AppColor.disabled,
//                         itemHeight: kMinInteractiveDimension,
//                         isDense: false,
//                         style: AppFont.textFiled,
//                         formControlName: "sender_number_country",
//                         items: country.map((e) {
//                           return DropdownMenuItem(
//                             value: e.id,
//                             child: Row(
//                               children: [
//                                 ImageOrSvg(
//                                   e.countryImage,
//                                   height: 30,
//                                 ),
//                                 Gap(8.w),
//                                 Text(
//                                   e.nameAr ?? "",
//                                   style: AppFont.font14W600Primary,
//                                 )
//                               ],
//                             ),
//                           );
//                         }).toList(),
//                       ),
//                     ),
//                     formControlName: "sender_number",
//                     hintText: "000 000 000",
//                     labelText: "sender number".tr,
//                     inputType: TextInputType.number,
//                     inputFormatter: [
//                       FilteringTextInputFormatter.digitsOnly,
//                       LengthLimitingTextInputFormatter(max)
//                     ],
//                   );
//                 }),
//                 Gap(16.h),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: CustomTextField(
//                         formControlName: "from_address_line",
//                         hintText: "Editing field".tr,
//                         labelText: "Shipping address".tr,
//                         maxLines: 4,
//                       ),
//                     ),
//                     Gap(10.w),
//                     InkWell(
//                       onTap: () {},
//                       child: Container(
//                         height: 40,
//                         width: 40,
//                         decoration: BoxDecoration(
//                           color: AppColor.primary,
//                           borderRadius: BorderRadius.circular(4.r),
//                         ),
//                         child: Icon(Icons.location_on_outlined,
//                             color: AppColor.whiteOrGrey),
//                       ),
//                     )
//                   ],
//                 ),
//                 Gap(16.h),
//                 ReactiveFormConsumer(builder: (context, form, _) {
//                   CountryEntity? cities;
//                   if (form.control('to_country_id').value != null) {
//                     cities = country!
//                         .where(
//                             (e) => e.id == form.control('to_country_id').value)
//                         .firstOrNull;
//                   }
//                   return Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Expanded(
//                         child: CustomTextField<int>(
//                           labelText: "Delivery country".tr,
//                           formControlName: "to_country_id",
//                           hintText: "Egypt".tr,
//                           type: TextFieldType.selectable,
//                           items: country!.map((e) {
//                             return DropdownMenuItem<int>(
//                               value: e.id,
//                               child: Row(
//                                 children: [
//                                   ImageOrSvg(
//                                     e.countryImage,
//                                     height: 30,
//                                   ),
//                                   Gap(8.w),
//                                   Text(
//                                     e.nameAr ?? "",
//                                     style: AppFont.font14W600Primary,
//                                   )
//                                 ],
//                               ),
//                             );
//                           }).toList(),
//                         ),
//                       ),
//                       Gap(10.w),
//                       Expanded(
//                         child: CustomTextField(
//                           labelText: "Delivery government".tr,
//                           formControlName: "to_city_id",
//                           hintText: "Cairo".tr,
//                           type: TextFieldType.selectable,
//                           items: cities == null
//                               ? []
//                               : cities.cities!.map((e) {
//                                   return DropdownMenuItem(
//                                     value: e.id,
//                                     child: Text(
//                                       e.titleAr ?? "",
//                                       style: AppFont.font14W600Primary,
//                                     ),
//                                   );
//                                 }).toList(),
//                         ),
//                       ),
//                     ],
//                   );
//                 }),
//                 Gap(16.h),
//                 CustomTextField(
//                   formControlName: "receiver_name",
//                   hintText: "User".tr,
//                   labelText: "Receiver name".tr,
//                 ),
//                 Gap(16.h),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: CustomTextField(
//                         formControlName: "to_address_line",
//                         hintText: "Editing field".tr,
//                         labelText: "delivery address".tr,
//                         maxLines: 4,
//                       ),
//                     ),
//                     Gap(10.w),
//                     InkWell(
//                       onTap: () {},
//                       child: Container(
//                         height: 40,
//                         width: 40,
//                         decoration: BoxDecoration(
//                           color: AppColor.primary,
//                           borderRadius: BorderRadius.circular(4.r),
//                         ),
//                         child: Icon(Icons.location_on_outlined,
//                             color: AppColor.whiteOrGrey),
//                       ),
//                     )
//                   ],
//                 ),
//                 Gap(16.h),
//                 CustomTextField(
//                   formControlName: "to_area",
//                   hintText: "receiver area".tr,
//                   labelText: "receiver area".tr,
//                 ),
//                 Gap(16.h),
//                 ReactiveFormConsumer(builder: (context, form, _) {
//                   final max = country!
//                           .firstWhereOrNull((e) =>
//                               e.id ==
//                               form.control('receiver_phone_country').value)
//                           ?.numberLength ??
//                       9;
//                   return CustomTextField(
//                     iconButton: SizedBox(
//                       width: 124,
//                       height: 55,
//                       child: ReactiveDropdownField(
//                         onChanged: (_) {
//                           form.control('receiver_phone').value = null;
//                         },
//                         decoration: const InputDecoration(
//                           focusedBorder: InputBorder.none,
//                           enabledBorder: InputBorder.none,
//                         ),
//                         iconEnabledColor: AppColor.primary,
//                         iconDisabledColor: AppColor.disabled,
//                         itemHeight: kMinInteractiveDimension,
//                         isDense: false,
//                         style: AppFont.textFiled,
//                         formControlName: "receiver_phone_country",
//                         items: country.map((e) {
//                           return DropdownMenuItem(
//                             value: e.id,
//                             child: Row(
//                               children: [
//                                 ImageOrSvg(
//                                   e.countryImage,
//                                   height: 30,
//                                 ),
//                                 Gap(8.w),
//                                 Text(
//                                   e.nameAr ?? "",
//                                   style: AppFont.font14W600Primary,
//                                 )
//                               ],
//                             ),
//                           );
//                         }).toList(),
//                       ),
//                     ),
//                     formControlName: "receiver_phone",
//                     hintText: "000 000 000",
//                     labelText: "receiver number".tr,
//                     inputType: TextInputType.number,
//                     inputFormatter: [
//                       FilteringTextInputFormatter.digitsOnly,
//                       LengthLimitingTextInputFormatter(max)
//                     ],
//                   );
//                 }),
//                 Gap(70.h)
//               ],
//             ),
//           ),
//         ),
//       ),
//       bottomSheet: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: ReactiveForm(
//           formGroup: formGroup,
//           child: ReactiveFormConsumer(
//             builder: (BuildContext context, FormGroup form, Widget? child) {
//               final isValid = form.valid;
//               return CustomFilledButton(
//                 text: "next".tr,
//                 onPressed: () async {
//                   if (isValid) {
//                     // await getIt<SubmitOrderUseCase>().call(form.value);
//                   } else {
//                     form.markAllAsTouched();
//                   }
//                 },
//                 isValid: isValid,
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
