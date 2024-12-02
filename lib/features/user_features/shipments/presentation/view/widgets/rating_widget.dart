import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../../../config/app_color.dart';
import '../../../../../../config/app_font.dart';
import '../../../../../../core/service/loading_provider.dart';
import '../../../../../../main.dart';
import '../../../../../../ui/shared_widgets/add_rating_widget.dart';
import '../../../../../../ui/shared_widgets/custom_filled_button.dart';
import '../../../../../../ui/shared_widgets/custom_outlined_button.dart';
import '../../../../../../ui/shared_widgets/custom_text_field.dart';
import '../../../../../../ui/shared_widgets/image_or_svg.dart';
import '../../../../../../ui/ui.dart';
import '../../../data/models/shipment_model.dart';
import '../../../domain/use_cases/shipment_use_cases.dart';

void showRatingDialog(BuildContext context,
    {required ShipmentModel order, required WidgetRef ref}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      final FormGroup formGroup = FormGroup({
        'comment': FormControl(
            validators: [Validators.required],
            asyncValidatorsDebounceTime: 100,
            value: ""),
        'rate': FormControl<double>(validators: [Validators.required]),
      });
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(16.0),
          child: ReactiveForm(
            formGroup: formGroup,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                            radius: 30,
                            child: ImageOrSvg(
                              order.user?.profilePhotoUrl ?? "",
                              pickImageOnNull: true,
                            )),
                        Gap(10.w),
                        Text(order.user!.name ?? "",
                            style: AppFont.font16W600Black),
                      ],
                    ),
                    Text(order.paymentMethod ?? ""),
                  ],
                ),
                Gap(10.h),
                ReactiveFormConsumer(builder: (context, form, _) {
                  return AddRatingWidget(
                      initRate: form.control("rate").value ?? 0.0,
                      onChanged: (value) {
                        form.control("rate").updateValue(value);
                        print(form.control("rate").value);
                      },
                      title: "Rate :".tr);
                }),
                Gap(10.h),
                ReactiveFormConsumer(builder: (context, form, _) {
                  return CustomTextField(
                    formControlName: "comment",
                    onChanged: (control) {
                      form.control("comment").updateValue(control.value);
                    },
                  );
                }),
                Gap(10.h),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Divider(
                    color: AppColor.grey1,
                    thickness: 1,
                  ),
                ),
                ReactiveFormConsumer(builder: (context, form, _) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 7,
                        child: CustomFilledButton(
                          onPressed: () async {
                            if (formGroup.valid) {
                              try {
                                ref
                                    .read(isLoadingProvider("submit").notifier)
                                    .state = true;
                                final res = await getIt<SubmitRateUseCase>().call({
                                  ...formGroup.value,
                                  "company_id": order.company?.id ?? 0,
                                  "shipment_id": order.id
                                });
                                res.fold((l) async {
                                  await UIHelper.showAlert(l.message,
                                      type: DialogType.error);
                                  Get.back();
                                }, (r) async {
                                  await UIHelper.showAlert(
                                      "Rate submitted successfully".tr);
                                  Get.back();
                                });
                              } finally {
                                ref
                                    .read(isLoadingProvider("submit").notifier)
                                    .state = false;
                              }
                            } else {
                              form.markAllAsTouched();
                            }
                          },
                          height: 50,
                          text: 'Rate Us'.tr,
                          isValid: formGroup.valid,
                          isExpanded: true,
                          widget: const Icon(CupertinoIcons.hand_thumbsup_fill),
                        ),
                      ),
                      Gap(10.w),
                      Expanded(
                        flex: 2,
                        child: CustomOutlinedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          height: 50,
                          isExpanded: true,
                          text: "Cancel".tr,
                          hideText: true,
                          widget: const Icon(Icons.close),
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
        ),
      );
    },
  );
}
