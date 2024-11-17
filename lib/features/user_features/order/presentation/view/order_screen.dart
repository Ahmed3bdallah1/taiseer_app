import 'dart:io';
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
import 'package:taiseer/features/user_features/order/presentation/view/widgets/selectable_tile.dart';
import 'package:taiseer/features/user_features/user_company/data/model/company_details_model.dart';
import 'package:taiseer/ui/shared_widgets/custom_filled_button.dart';
import 'package:taiseer/ui/shared_widgets/custom_text_field.dart';
import 'package:taiseer/ui/ui.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../../../../../config/app_font.dart';
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

  const OrderScreen(
      {super.key,
      required this.companyDetailsModel,
      required this.companyModel});

  @override
  ConsumerState<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends ConsumerState<OrderScreen> {
  late final FormGroup formGroup;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    formGroup = FormGroup({
      'company_id': FormControl(value: widget.companyDetailsModel.id),
      'shipping_id': FormControl<int>(validators: [Validators.required]),
      'is_fast_shipping':
          FormControl<bool>(validators: [Validators.required], value: false),
      'shipping_type':
          FormControl<int>(validators: [Validators.required], value: 1),
      "shipping_details": FormControl(validators: [Validators.required]),
      'shipping_date': FormControl(validators: [Validators.required]),
      'shipping_price': FormControl<String>(validators: [Validators.required]),
      'shipping_images':
          FormControl<List<String>>(validators: [Validators.required]),
      'shipping_address':
          FormControl<String>(validators: [Validators.required]),
      'delivery_address':
          FormControl<String>(validators: [Validators.required]),
      'delivery_country':
          FormControl<int>(validators: [Validators.required]),
      'delivery_government':
          FormControl<int>(validators: [Validators.required]),
      'sender_name': FormControl<String>(validators: [Validators.required]),
      'sender_number_country': FormControl<int>(),
      'sender_number': FormControl<String>(validators: [Validators.required]),
      'sender_country': FormControl<int>(validators: [Validators.required]),
      'sender_government':
          FormControl<int>(validators: [Validators.required]),
      'receiver_name': FormControl<String>(validators: [Validators.required]),
      'receiver_number': FormControl<String>(validators: [Validators.required]),
      'receiver_number_country': FormControl<int>(),
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

    formGroup.control('receiver_number').setValidators([
      Validators.compose([
        Validators.required,
        Validators.delegate((control) {
          final res = formGroup.control('receiver_number_country').value is int;
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
                CompanyContainer(companyModel: widget.companyModel),
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
                      if (form.control("shipping_id").value == null) {
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
                                  .firstWhereOrNull((e) =>
                                      e.id == form.control("shipping_id").value)
                                  ?.typeActivities
                                  ?.nameAr ??
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
                              final method = widget.companyDetailsModel
                                  .typeActivityCompanies[index];
                              if (index <
                                  widget.companyDetailsModel
                                          .typeActivityCompanies.length -
                                      1) {
                                return ReactiveFormConsumer(
                                  builder: (context, form, _) {
                                    final isSelected =
                                        form.control("shipping_id").value ==
                                            method.id;
                                    return ShippingMethodTile(
                                      color: AppColor.black,
                                      shippingMethodsEntity: method,
                                      hideSelectedItem: false,
                                      isSelected: isSelected,
                                      onTap: () => form
                                          .control("shipping_id")
                                          .value = method.id,
                                    );
                                  },
                                );
                              } else {
                                return ReactiveFormConsumer(
                                  builder: (context, form, _) {
                                    bool isSelected = form
                                            .control("is_fast_shipping")
                                            .value ==
                                        true;
                                    return FastShippingMethodTile(
                                      color: Colors.white,
                                      isSelected: isSelected,
                                      onTap: () {
                                        form.control("is_fast_shipping").value =
                                            !isSelected;
                                      },
                                      shippingMethodsEntity: method,
                                    );
                                  },
                                );
                              }
                            },
                            separatorBuilder: (context, index) {
                              return Gap(10.w);
                            },
                            itemCount: widget.companyDetailsModel
                                .typeActivityCompanies.length,
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
                  formControlName: "shipping_details",
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
                                  form.control("shipping_date").value =
                                      intl.DateFormat.yMd('en').format(value);
                                }
                              });
                            },
                            child: CustomTextField(
                              ignore: true,
                              labelText: "shipment date".tr,
                              hintText: "DD/MM/YYYY",
                              formControlName: "shipping_date",
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
                        formControlName: "shipping_price",
                      ),
                    ),
                  ],
                ),
                Gap(16.h),
                ReactiveFormConsumer(
                  builder: (context, form, _) {
                    final value = form.control("shipping_type").value;
                    return Row(
                      children: [
                        Expanded(
                          child: SelectableTile(
                            name: "Local shipping".tr,
                            isSelected: value == 0 ? true : false,
                            onTap: () =>
                                form.control("shipping_type").value = 0,
                          ),
                        ),
                        Gap(10.w),
                        Expanded(
                          child: SelectableTile(
                            name: "Global shipping".tr,
                            isSelected: value == 1 ? true : false,
                            onTap: () =>
                                form.control("shipping_type").value = 1,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                Gap(24.h),
                CustomTextField(
                  formControlName: "sender_name",
                  hintText: "User".tr,
                  labelText: "Sender name".tr,
                ),
                Gap(16.h),
                ReactiveFormConsumer(
                  builder: (context,form,_) {
                    CountryEntity? cities;
                    if(form.control('sender_country').value!=null){
                      cities = country!.where((e)=> e.id==form.control('sender_country').value).firstOrNull;
                    }                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: CustomTextField<int>(
                            labelText: "Sender country".tr,
                            formControlName: "sender_country",
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
                            formControlName: "sender_government",
                            hintText: "Cairo".tr,
                            type: TextFieldType.selectable,
                            items: cities==null?[] : cities.cities!.map((e) {
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
                  }
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
                        formControlName: "shipping_address",
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
                ReactiveFormConsumer(
                    builder: (context,form,_) {
                      CountryEntity? cities;
                      if(form.control('delivery_country').value!=null){
                        cities = country!.where((e)=> e.id==form.control('delivery_country').value).firstOrNull;
                      }
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: CustomTextField<int>(
                              labelText: "Delivery country".tr,
                              formControlName: "delivery_country",
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
                              formControlName: "delivery_government",
                              hintText: "Cairo".tr,
                              type: TextFieldType.selectable,
                              items: cities==null?[] : cities.cities!.map((e) {
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
                    }
                ),
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
                        formControlName: "delivery_address",
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
                ReactiveFormConsumer(builder: (context, form, _) {
                  final max = country!
                          .firstWhereOrNull((e) =>
                              e.id ==
                              form.control('receiver_number_country').value)
                          ?.numberLength ??
                      9;
                  return CustomTextField(
                    iconButton: SizedBox(
                      width: 124,
                      height: 55,
                      child: ReactiveDropdownField(
                        onChanged: (_) {
                          form.control('receiver_number').value = null;
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
                        formControlName: "receiver_number_country",
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
                    formControlName: "receiver_number",
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
                  if (isValid) {
                    // await getIt<SubmitOrderUseCase>().call(form.value);
                  } else {
                    form.markAllAsTouched();
                  }
                },
                isValid: isValid,
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

class GlobalOrderScreen extends ConsumerStatefulWidget {
  const GlobalOrderScreen({super.key});

  @override
  ConsumerState<GlobalOrderScreen> createState() => _GlobalOrderScreenState();
}

class _GlobalOrderScreenState extends ConsumerState<GlobalOrderScreen> {
  late final FormGroup formGroup;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    formGroup = FormGroup({
      'company_id': FormControl(value: 0),
      'shipping_id': FormControl<int>(validators: [Validators.required]),
      'is_fast_shipping':
          FormControl<bool>(validators: [Validators.required], value: false),
      'shipping_type':
          FormControl<int>(validators: [Validators.required], value: 1),
      "shipping_details": FormControl(validators: [Validators.required]),
      'shipping_date': FormControl(validators: [Validators.required]),
      'shipping_price': FormControl<String>(validators: [Validators.required]),
      'shipping_images':
          FormControl<List<String>>(validators: [Validators.required]),
      'shipping_address':
          FormControl<String>(validators: [Validators.required]),
      'delivery_address':
          FormControl<String>(validators: [Validators.required]),
      'delivery_country':
          FormControl<String>(validators: [Validators.required]),
      'delivery_government':
          FormControl<String>(validators: [Validators.required]),
      'sender_name': FormControl<String>(validators: [Validators.required]),
      'sender_number_country': FormControl<int>(),
      'sender_number': FormControl<String>(validators: [Validators.required]),
      'sender_country': FormControl<String>(validators: [Validators.required]),
      'sender_government':
          FormControl<String>(validators: [Validators.required]),
      'receiver_name': FormControl<String>(validators: [Validators.required]),
      'receiver_number': FormControl<String>(validators: [Validators.required]),
      'receiver_number_country': FormControl<int>(),
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

    formGroup.control('receiver_number').setValidators([
      Validators.compose([
        Validators.required,
        Validators.delegate((control) {
          final res = formGroup.control('receiver_number_country').value is int;
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
                // CompanyContainer(companyModel: widget.companyModel),
                // Gap(24.h),
                // Row(
                //   children: [
                //     const Icon(
                //       CupertinoIcons.cube_box,
                //       color: AppColor.primary,
                //     ),
                //     Gap(10.w),
                //     Text(
                //       "Select service".tr,
                //       style: AppFont.font18W700Black,
                //     ),
                //     Gap(10.w),
                //     ReactiveFormConsumer(builder: (context, form, _) {
                //       if (form.control("shipping_id").value == null) {
                //         return const SizedBox.shrink();
                //       }
                //       return Container(
                //         decoration: BoxDecoration(
                //             color: AppColor.grey1,
                //             borderRadius: BorderRadius.circular(20)),
                //         child: Padding(
                //           padding: const EdgeInsets.symmetric(
                //               horizontal: 12, vertical: 2),
                //           child: Text(widget.companyModel.shippingMethods!
                //                   .firstWhereOrNull((e) =>
                //                       e.id == form.control("shipping_id").value)
                //                   ?.name ??
                //               ''),
                //         ),
                //       );
                //     })
                //   ],
                // ),
                // Gap(16.h),
                // SizedBox(
                //   height: 95,
                //   child: Padding(
                //     padding: const EdgeInsets.symmetric(vertical: 5),
                //     child: Row(
                //       children: [
                //         Expanded(
                //           child: ListView.separated(
                //             scrollDirection: Axis.horizontal,
                //             shrinkWrap: true,
                //             itemBuilder: (context, index) {
                //               final method =
                //                   widget.companyModel.shippingMethods![index];
                //               if (index < widget.companyModel.shippingMethods!.length - 1) {
                //                 return ReactiveFormConsumer(
                //                   builder: (context, form, _) {
                //                     final isSelected =
                //                         form.control("shipping_id").value ==
                //                             method.id;
                //                     return ShippingMethodTile(
                //                       color: AppColor.black,
                //                       shippingMethodsEntity: method,
                //                       hideSelectedItem: false,
                //                       isSelected: isSelected,
                //                       onTap: () => form
                //                           .control("shipping_id")
                //                           .value = method.id!,
                //                     );
                //                   },
                //                 );
                //               } else {
                //                 return ReactiveFormConsumer(
                //                   builder: (context, form, _) {
                //                     bool isSelected = form
                //                             .control("is_fast_shipping")
                //                             .value ==
                //                         true;
                //                     return FastShippingMethodTile(
                //                       color: Colors.white,
                //                       isSelected: isSelected,
                //                       onTap: () {
                //                         form.control("is_fast_shipping").value = !isSelected;
                //                       },
                //                       shippingMethodsEntity: method,
                //                     );
                //                   },
                //                 );
                //               }
                //             },
                //             separatorBuilder: (context, index) {
                //               return Gap(10.w);
                //             },
                //             itemCount: widget.companyModel.shippingMethods?.length ?? 0,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
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
                  formControlName: "shipping_details",
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
                                  form.control("shipping_date").value =
                                      intl.DateFormat.yMd('en').format(value);
                                }
                              });
                            },
                            child: CustomTextField(
                              ignore: true,
                              labelText: "shipment date".tr,
                              hintText: "DD/MM/YYYY",
                              formControlName: "shipping_date",
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
                        formControlName: "shipping_price",
                      ),
                    ),
                  ],
                ),
                Gap(16.h),
                ReactiveFormConsumer(
                  builder: (context, form, _) {
                    final value = form.control("shipping_type").value;
                    return Row(
                      children: [
                        Expanded(
                          child: SelectableTile(
                            name: "Local shipping".tr,
                            isSelected: value == 0 ? true : false,
                            onTap: () =>
                                form.control("shipping_type").value = 0,
                          ),
                        ),
                        Gap(10.w),
                        Expanded(
                          child: SelectableTile(
                            name: "Global shipping".tr,
                            isSelected: value == 1 ? true : false,
                            onTap: () =>
                                form.control("shipping_type").value = 1,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                Gap(24.h),
                CustomTextField(
                  formControlName: "sender_name",
                  hintText: "User".tr,
                  labelText: "Sender name".tr,
                ),
                Gap(16.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: CustomTextField(
                        labelText: "Sender country".tr,
                        formControlName: "sender_country",
                        hintText: "Egypt".tr,
                        type: TextFieldType.selectable,
                        items: country!.map((e) {
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
                    Gap(10.w),
                    Expanded(
                      child: CustomTextField(
                        labelText: "Sender government".tr,
                        formControlName: "sender_government",
                        hintText: "Cairo".tr,
                        items: []
                      ),
                    ),
                  ],
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
                        formControlName: "shipping_address",
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
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        labelText: "Delivery country".tr,
                        formControlName: "delivery_country",
                        hintText: "Egypt".tr,
                      ),
                    ),
                    Gap(10.w),
                    Expanded(
                      child: CustomTextField(
                        labelText: "Delivery government".tr,
                        formControlName: "delivery_government",
                        hintText: "Cairo".tr,
                      ),
                    ),
                  ],
                ),
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
                        formControlName: "delivery_address",
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
                ReactiveFormConsumer(builder: (context, form, _) {
                  final country = ref.watch(fetchCountryProvider).value;
                  final max = country!
                          .firstWhereOrNull((e) =>
                              e.id ==
                              form.control('receiver_number_country').value)
                          ?.numberLength ??
                      9;
                  return CustomTextField(
                    iconButton: SizedBox(
                      width: 124,
                      height: 55,
                      child: ReactiveDropdownField(
                        onChanged: (_) {
                          form.control('receiver_number').value = null;
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
                        formControlName: "receiver_number_country",
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
                                  e.nameEn ?? "",
                                  style: AppFont.font14W600Primary,
                                )
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    formControlName: "receiver_number",
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
                  if (isValid) {
                    // await getIt<SubmitOrderUseCase>().call(form.value);
                  } else {
                    form.markAllAsTouched();
                  }
                },
                isValid: isValid,
              );
            },
          ),
        ),
      ),
    );
  }
}
