import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:taiseer/features/user_features/chat/presentation/chats_screen.dart';
import 'package:taiseer/ui/shared_widgets/custom_text_field.dart';
import 'package:taiseer/ui/shared_widgets/image_or_svg.dart';
import 'package:tuple/tuple.dart';
import '../../../../../../config/app_font.dart';
import '../../../../../../core/service/loading_provider.dart';
import '../../../../../../main.dart';
import '../../../../../../ui/shared_widgets/custom_filled_button.dart';
import '../../../../../../ui/shared_widgets/custom_outlined_button.dart';
import '../../../../../../ui/ui.dart';
import '../../../../chat/domain/use_case/chats_use_cases.dart';
import 'custom_stepper_widget.dart';
import '../../../data/models/shipment_model.dart';

void showShipmentDialog(BuildContext context,
    {ShipmentModel? order, required WidgetRef ref}) {
  print(order!.id);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                      radius: 30,
                      child: ImageOrSvg(
                        order!.user?.profilePhotoUrl ?? "",
                        pickImageOnNull: true,
                      )),
                  Gap(6.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(order.user!.name ?? "",
                                style: AppFont.font16W600Black),
                            Text(order.paymentMethod ?? ""),
                          ],
                        ),
                        const Gap(6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                  color: AppColor.green1.withOpacity(.3),
                                  border: Border.all(color: AppColor.green1),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Center(
                                child: Text(order.shipmentType ?? "",
                                    style: AppFont.font14W600Black),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Gap(10.h),
              const CustomStepperWidget(status: 1),
              Gap(10.h),
              Row(
                children: [
                  Flexible(
                    child: Text(
                      order.contentDescription ?? "",
                      maxLines: 6,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: ImageOrSvg(
                      order.shipmentImage?.toString() ?? "",
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Divider(
                  color: AppColor.grey1,
                  thickness: 1,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomFilledButton(
                      onPressed: () async {
                        Get.back();
                        showTextDialog(context, ref: ref, order: order);
                      },
                      height: 50,
                      text: 'Message'.tr,
                      textSize: 20,
                      isExpanded: true,
                      widget: const Icon(CupertinoIcons.location),
                    ),
                  ),
                  Gap(10.w),
                  Expanded(
                    child: CustomOutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      height: 50,
                      isExpanded: true,
                      textSize: 20,
                      text: "Ok".tr,
                      widget: const Icon(Icons.close),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

void showTextDialog(BuildContext context,
    {required ShipmentModel order, required WidgetRef ref}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      final FormGroup formGroup = FormGroup({
        'text': FormControl(
            validators: [Validators.required],
            asyncValidatorsDebounceTime: 100,
            value: ""),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    CircleAvatar(
                        radius: 30,
                        child: ImageOrSvg(
                          order.user?.profilePhotoUrl ?? "",
                          pickImageOnNull: true,
                        )),
                    Text(order.user!.name ?? "",
                        style: AppFont.font16W600Black),
                    Text(order.paymentMethod ?? ""),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Gap(6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 4),
                                decoration: BoxDecoration(
                                    color: AppColor.green1.withOpacity(.3),
                                    border: Border.all(color: AppColor.green1),
                                    borderRadius: BorderRadius.circular(12)),
                                child: Center(
                                  child: Text(order.shipmentType ?? "",
                                      style: AppFont.font14W600Black),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Gap(10.h),
                const CustomStepperWidget(status: 1),
                Gap(10.h),
                ReactiveFormConsumer(builder: (context, form, _) {
                  return CustomTextField(
                    formControlName: "text",
                    onChanged: (control) {
                      form.control("text").updateValue(control.value);
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
                                final res = await getIt<SendMessageUseCase>()
                                    .call(Tuple2(order.id, formGroup.value.values.first));
                                res.fold((l) async {
                                  await UIHelper.showAlert(l.message,
                                      type: DialogType.error);
                                  Get.back();
                                }, (r) async {
                                  await UIHelper.showAlert(
                                      "Message submitted successfully".tr);
                                  Get.off(() => const ChatsScreen());
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
                          text: 'Send Message'.tr,
                          isValid: formGroup.valid,
                          isExpanded: true,
                          widget: const Icon(CupertinoIcons.location),
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
