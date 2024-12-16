import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:reactive_forms/reactive_forms.dart';
import '../../../../../../config/app_font.dart';
import '../../../../../../ui/shared_widgets/custom_reactive_form_consumer.dart';
import '../../../../../../ui/shared_widgets/custom_text_field.dart';
import '../../../../../../ui/shared_widgets/image_or_svg.dart';
import '../../../../../../ui/ui.dart';
import '../../../../../shared/auth/domain/entities/auth_entity.dart';
import '../widgets/selectable_tile.dart';

class ShipmentFromWidget extends StatelessWidget {
  final List<CountryEntity>? country;

  const ShipmentFromWidget({super.key, this.country});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                          List value2 = [elements[0], elements[2], elements[1]];
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
                        form.control("shipment_type").value = "specific",
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
                .where((e) => e.id == form.control('from_country_id').value)
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
                            width: 40,
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
                      e.id == form.control('sender_number_country').value)
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
                items: country!.map((e) {
                  return DropdownMenuItem(
                    value: e.id,
                    child: Row(
                      children: [
                        ImageOrSvg(
                          e.countryImage,
                          height: 30,
                          width: 30,
                          fit: BoxFit.fill,
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
      ],
    );
  }
}

class ShipmentToWidget extends StatelessWidget {
  final List<CountryEntity>? country;

  const ShipmentToWidget({super.key, this.country});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ReactiveFormConsumer(builder: (context, form, _) {
          CountryEntity? cities;
          if (form.control('to_country_id').value != null) {
            cities = country!
                .where((e) => e.id == form.control('to_country_id').value)
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
                            width: 40,
                            fit: BoxFit.fill,
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
                      e.id == form.control('receiver_phone_country').value)
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
                items: country!.map((e) {
                  return DropdownMenuItem(
                    value: e.id,
                    child: Row(
                      children: [
                        ImageOrSvg(
                          e.countryImage,
                          height: 30,
                          width: 30,
                          fit: BoxFit.fill,
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
    );
  }
}
