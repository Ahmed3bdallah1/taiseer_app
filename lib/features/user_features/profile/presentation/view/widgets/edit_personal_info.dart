import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../../../config/app_font.dart';
import '../../../../../../ui/shared_widgets/custom_text_field.dart';
import '../../../../../../ui/shared_widgets/image_or_svg.dart';
import '../../../../../../ui/ui.dart';
import '../../../../../shared/auth/presentation/manager/auth_provuder.dart';

class EditPersonalInfo extends ConsumerWidget {
  const EditPersonalInfo({
    super.key,
    required this.formGroup,
  });

  final FormGroup formGroup;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final country = ref.watch(fetchCountryProvider).value;
    ref.listen(fetchCountryProvider, (ds, next) {
      if (next.hasValue && next.value?.isNotEmpty == true) {
        formGroup.control('country').value = next.value?.first.id;
      }
    });
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(10),
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  formControlName: "first_name",
                  labelText: ("first name".tr),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              Gap(10.w),
              Expanded(
                child: CustomTextField(
                  formControlName: "last_name",
                  labelText: ("last name".tr),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ],
          ),
          Gap(20.h),
          CustomTextField(
            formControlName: "email",
            labelText: ("Email".tr),
          ),
          Gap(20.h),
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
          Gap(50.h),
        ],
      ),
    );
  }
}
