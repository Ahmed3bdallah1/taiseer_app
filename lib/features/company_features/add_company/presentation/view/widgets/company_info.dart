import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:taiseer/config/app_font.dart';
import 'package:taiseer/features/company_features/add_company/data/model/add_company_model.dart';
import 'package:taiseer/ui/shared_widgets/custom_text_field.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../../../ui/shared_widgets/image_or_svg.dart';

class CompanyInfo extends StatefulWidget {
  const CompanyInfo({super.key, required this.scrollController, required this.addCompanyModel});

  final ScrollController scrollController;
  final AddCompanyModel addCompanyModel;

  @override
  State<CompanyInfo> createState() => _CompanyInfoState();
}

class _CompanyInfoState extends State<CompanyInfo> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: widget.scrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: CustomTextField(
                  formControlName: "arabic_company_name",
                  labelText: ("Arabic company name".tr),
                  hintText: ("Arabic company name".tr),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              Gap(8.w),
              Expanded(
                child: CustomTextField(
                  formControlName: "english_company_name",
                  labelText: ("English company name".tr),
                  hintText: ("English company name".tr),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ],
          ),
          Gap(16.h),
          CustomTextField(
            formControlName: "email",
            labelText: ("Email".tr),
            hintText: ("Email".tr),
            inputType: TextInputType.emailAddress,
            inputFormatter: [
              FilteringTextInputFormatter.deny(RegExp(r'\s')),
            ],
          ),
          Gap(16.h),
          ReactiveFormConsumer(builder: (context, form, _) {
            final max = addCompanyModel.countries!
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
                  items: addCompanyModel.countries!.map((e) {
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
          Gap(16.h),
          CustomTextField(
            formControlName: "license_number",
            labelText: ("License number".tr),
            hintText: "License number".tr,
            inputType: TextInputType.number,
            inputFormatter: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(16),
            ],
          ),
          Gap(16.h),
          CustomTextField(
            formControlName: "company_description",
            hintText: "Company description".tr,
            labelText: ("Company description".tr),
            maxLines: 6,
            inputType: TextInputType.number,
          ),
          Gap(50.h),
        ],
      ),
    );
  }
}
