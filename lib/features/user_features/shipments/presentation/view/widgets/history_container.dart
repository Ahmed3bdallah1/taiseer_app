import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:taiseer/config/app_font.dart';
import 'package:taiseer/features/user_features/shipments/data/models/shipment_model.dart';
import 'package:taiseer/ui/shared_widgets/custom_filled_button.dart';

final changed = StateProvider.family<bool, dynamic>((ref, _) => false);

class ShipmentContainer extends ConsumerWidget {
  final ShipmentModel shipment;

  const ShipmentContainer({super.key, required this.shipment});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        // onTap: historyEntity.status.id == 2 ? () async {} : null,
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: AppColor.grey1)),
          child: Padding(
            padding: EdgeInsets.only(
              left: 10.w,
              right: 10.w,
              bottom: 4.h,
              top: 12.h,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 25.h,
                          width: 25.h,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: shipment.status == "new"
                                      ? AppColor.primary
                                      : shipment.status == "in_transit"
                                          ? AppColor.orange
                                          : shipment.status == "accepted" ||
                                                  shipment.status ==
                                                      "delivered"
                                              ? AppColor.green
                                              : shipment.status ==
                                                          "rejected" ||
                                                      shipment.status ==
                                                          "closed"
                                                  ? AppColor.danger
                                                  : AppColor.primary,
                                  width: 2),
                              borderRadius: BorderRadius.circular(8.r)),
                          child: Center(
                            child: Icon(
                              Icons.circle,
                              size: 20,
                              color: shipment.status == "new"
                                  ? AppColor.primary
                                  : shipment.status == "in_transit"
                                      ? AppColor.orange
                                      : shipment.status == "accepted" ||
                                              shipment.status == "delivered"
                                          ? AppColor.green
                                          : shipment.status == "rejected" ||
                                                  shipment.status == "closed"
                                              ? AppColor.danger
                                              : AppColor.primary,
                            ),
                          ),
                        ),
                        Gap(10.w),
                        Text("order number".tr),
                        Text(" #${shipment.id.toString()}"),
                      ],
                    ),
                    if (shipment.status == "accepted" ||
                        shipment.status == "delivered")
                      Text(
                        shipment.status!.tr,
                        style: AppFont.font13w400Green,
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: shipment.paymentMethod,
                              style: AppFont.font14W600Black),
                        ])),
                      ],
                    ),
                  ],
                ),
                Gap(10.h),
                Container(
                  decoration: BoxDecoration(
                    color: shipment.status == "new"
                        ? AppColor.primary.withOpacity(.2)
                        : shipment.status == "in_transit"
                            ? AppColor.orange.withOpacity(.2)
                            : shipment.status == "accepted" ||
                                    shipment.status == "delivered"
                                ? AppColor.green.withOpacity(.2)
                                : shipment.status == "rejected" ||
                                        shipment.status == "closed"
                                    ? AppColor.danger.withOpacity(.2)
                                    : AppColor.primary.withOpacity(.2),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outlined,
                          color: shipment.status == "new"
                              ? AppColor.primary
                              : shipment.status == "in_transit"
                                  ? AppColor.orange
                                  : shipment.status == "accepted" ||
                                          shipment.status == "delivered"
                                      ? AppColor.green
                                      : shipment.status == "rejected" ||
                                              shipment.status == "closed"
                                          ? AppColor.danger
                                          : AppColor.primary,
                        ),
                        Gap(10.w),
                        Flexible(
                          child: Text(
                            shipment.status ?? "",
                            style: AppFont.font14W500Black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Gap(15.h),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColor.grey1),
                      borderRadius: BorderRadius.circular(12.r)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          shipment.contentDescription ?? "",
                          maxLines:
                              ref.watch(changed("more${shipment.id}")) ==
                                      false
                                  ? 2
                                  : 10,
                        ),
                        ref.watch(changed("more${shipment.id}")) == false
                            ? const SizedBox()
                            : Column(
                                children: [
                                  Gap(20.h),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      // Column(
                                      //   children: [
                                      //     // Text("from".tr),
                                      //     Gap(10.h),
                                      //     Text("to".tr),
                                      //   ],
                                      // ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text("from".tr),
                                              Icon(
                                                Icons.location_on_outlined,
                                                color: AppColor.grey1,
                                              ),
                                              Gap(10.w),
                                              Text(
                                                "${shipment.addressFrom?.addressLine ?? ""} - ${shipment.addressFrom?.area ?? ""}",
                                                style: AppFont.font12w500Grey2,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text("to".tr),
                                              Icon(
                                                Icons.location_on_outlined,
                                                color: AppColor.grey1,
                                              ),
                                              Gap(10.w),
                                              Text(
                                                "${shipment.addressTo?.addressLine ?? ""} - ${shipment.addressTo?.area ?? ""}",
                                                style: AppFont.font12w500Grey2,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text("to".tr),
                                              Icon(
                                                CupertinoIcons.profile_circled,
                                                color: AppColor.grey1,
                                              ),
                                              Gap(10.w),
                                              Text(
                                                shipment.receiverName ?? "",
                                                style: AppFont.font12w500Grey2,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text("to".tr),
                                              Icon(
                                                CupertinoIcons.number_circle,
                                                color: AppColor.grey1,
                                              ),
                                              Gap(10.w),
                                              Text(
                                                shipment.receiverPhone ?? "",
                                                style: AppFont.font12w500Grey2,
                                              ),
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                        Gap(20.h),
                        SizedBox(
                          height: 40.h,
                          child: ref.watch(changed("more${shipment.id}")) ==
                                  true
                              ? CustomFilledButton(
                                  text: "Less".tr,
                                  isCirclar: true,
                                  widget: const Icon(Icons.keyboard_arrow_up),
                                  color: AppColor.grey1,
                                  onPressed: () {
                                    ref
                                            .read(
                                                changed("more${shipment.id}")
                                                    .notifier)
                                            .state =
                                        !ref.read(
                                            changed("more${shipment.id}"));
                                  },
                                )
                              : CustomFilledButton(
                                  text: "More".tr,
                                  isCirclar: true,
                                  widget: const Icon(Icons.keyboard_arrow_down),
                                  color: AppColor.grey1,
                                  onPressed: () {
                                    ref
                                            .read(
                                                changed("more${shipment.id}")
                                                    .notifier)
                                            .state =
                                        !ref.read(
                                            changed("more${shipment.id}"));
                                  },
                                ),
                        )
                      ],
                    ),
                  ),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     historyEntity.status.id == 2
                //         ? Container(
                //             decoration: BoxDecoration(
                //               color: Colors.indigoAccent,
                //               borderRadius: BorderRadius.circular(20),
                //             ),
                //             child: Padding(
                //               padding: const EdgeInsets.symmetric(
                //                   vertical: 10, horizontal: 15),
                //               child: Row(
                //                 children: [
                //                   Text(
                //                     "Installment".tr,
                //                     style: AppFont.font14W500White,
                //                   ),
                //                   Gap(10.w),
                //                   const Icon(
                //                     CupertinoIcons.arrow_up_left,
                //                     color: Colors.white,
                //                   )
                //                 ],
                //               ),
                //             ),
                //           )
                //         : historyEntity.status.id == 1
                //             ? InkWell(
                //                 onTap: () async {
                //                   final res = await UIHelper.showSelectableDialog(
                //                     "are you sure you want to cancel order?".tr,
                //                     "Cancel".tr,
                //                     "Confirm".tr,
                //                   );
                //                   if (res == true) {
                //                     try {
                //                       ref
                //                           .read(isLoadingProvider(
                //                                   "Cancel${historyEntity.id}")
                //                               .notifier)
                //                           .state = true;
                //
                //                       final history =
                //                           await getIt<FetchDeleteOrderUseCase>()
                //                               .call(historyEntity.id);
                //
                //                       return history.fold((l) {
                //                         ref
                //                             .read(isLoadingProvider(
                //                                     "Cancel${historyEntity.id}")
                //                                 .notifier)
                //                             .state = false;
                //                         UIHelper.showAlert(l.message,
                //                             type: DialogType.error);
                //                       }, (r) {
                //                         ref.invalidate(fetchOrderHistoryProvider);
                //                       });
                //                     } finally {
                //                       ref
                //                           .read(isLoadingProvider(
                //                                   "Cancel${historyEntity.id}")
                //                               .notifier)
                //                           .state = false;
                //                     }
                //                   }
                //                 },
                //                 child: Container(
                //                   decoration: BoxDecoration(
                //                     color: AppColor.danger,
                //                     borderRadius: BorderRadius.circular(20),
                //                   ),
                //                   child: Padding(
                //                     padding: const EdgeInsets.symmetric(
                //                         vertical: 10, horizontal: 15),
                //                     child: Consumer(
                //                       child: Row(
                //                         children: [
                //                           Text(
                //                             "Cancel".tr,
                //                             style: AppFont.font14W500White,
                //                           ),
                //                           Gap(10.w),
                //                           const Icon(
                //                             Icons.cancel,
                //                             color: Colors.white,
                //                           )
                //                         ],
                //                       ),
                //                       builder: (context, ref, child) {
                //                         final isLoading = ref.watch(
                //                             isLoadingProvider(
                //                                 "Cancel${historyEntity.id}"));
                //                         if (isLoading) {
                //                           return LoadingWidget(
                //                             color: AppColor.white,
                //                             size: 25,
                //                           );
                //                         }
                //
                //                         return child!;
                //                       },
                //                     ),
                //                   ),
                //                 ),
                //               )
                //             : const SizedBox(),
                //     Container(
                //       decoration: BoxDecoration(
                //           color: Colors.white,
                //           borderRadius: BorderRadius.circular(20),
                //           border: Border.all(color: historyEntity.status.color)),
                //       child: Padding(
                //         padding: const EdgeInsets.symmetric(
                //             vertical: 6, horizontal: 8),
                //         child: Row(
                //           children: [
                //             Text(
                //               historyEntity.status.title,
                //               style: AppFont.subLabelBlackTextField.copyWith(
                //                 color: historyEntity.status.color,
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                const Gap(10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
