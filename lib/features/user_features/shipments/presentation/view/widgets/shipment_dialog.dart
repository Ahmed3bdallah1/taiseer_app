import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:taiseer/ui/shared_widgets/image_or_svg.dart';
import '../../../../../../config/app_font.dart';
import '../../../../../../gen/assets.gen.dart';
import '../../../../../../ui/shared_widgets/custom_filled_button.dart';
import '../../../../../../ui/shared_widgets/custom_outlined_button.dart';
import 'custom_stepper_widget.dart';
import '../../../data/models/shipment_model.dart';

void showShipmentDialog(BuildContext context,{ShipmentModel? order}) {
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
                      child: ImageOrSvg(order!.user?.profilePhotoUrl??"")),
                  Gap(6.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(order.user!.name??"",
                                style: AppFont.font16W600Black),
                            Text(order.paymentMethod??"")
                          ],
                        ),
                        const Gap(6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 4),
                              decoration: BoxDecoration(
                                  color: AppColor.green1.withOpacity(.3),
                                  border: Border.all(color: AppColor.green1),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Center(
                                child: Text(order.shipmentType??"",
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
                      order.contentDescription??"",
                      maxLines: 6,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: ImageOrSvg(
                      order.shipmentImage?.toString()??"",
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
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      height: 50,
                      text: 'Track'.tr,
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