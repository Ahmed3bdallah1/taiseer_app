import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:taiseer/config/app_font.dart';
import 'package:taiseer/features/user_features/order/domain/entity/order_entity.dart';
import 'package:taiseer/ui/shared_widgets/custom_filled_button.dart';

final changed =
    StateProvider.family<bool, dynamic>((ref, _) => false);

class HistoryContainer extends ConsumerWidget {
  final OrderEntity historyEntity;

  const HistoryContainer({super.key, required this.historyEntity});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      // onTap: historyEntity.status.id == 2 ? () async {} : null,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: AppColor.grey1)
            // image: DecorationImage(
            //   fit: BoxFit.fitWidth,
            //   image: AssetImage(Assets.base.loanContainer.path),
            // ),
            ),
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
                children: [
                  Container(
                    height: 25.h,
                    width: 25.h,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: historyEntity.status.id == 0
                                ? AppColor.primary
                                : historyEntity.status.id == 1
                                    ? AppColor.orange
                                    : historyEntity.status.id == 2
                                        ? AppColor.green
                                        : historyEntity.status.id == 3
                                            ? AppColor.danger
                                            : AppColor.primary,
                            width: 2),
                        borderRadius: BorderRadius.circular(8.r)),
                    child: Center(
                      child: Icon(Icons.circle,
                          size: 20,
                          color: historyEntity.status.id == 0
                              ? AppColor.primary
                              : historyEntity.status.id == 1
                                  ? AppColor.orange
                                  : historyEntity.status.id == 2
                                      ? AppColor.green
                                      : historyEntity.status.id == 3
                                          ? AppColor.danger
                                          : AppColor.primary),
                    ),
                  ),
                  Gap(10.w),
                  Text("order number".tr),
                  Text(" #${historyEntity.id.toString()}"),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: historyEntity.subTotal,
                            style: AppFont.font14W600Black),
                        TextSpan(
                            text: " ${"SR".tr}",
                            style: AppFont.font14W600Black),
                      ])),
                    ],
                  ),
                ],
              ),
              Gap(10.h),
              Container(
                decoration: BoxDecoration(
                  color: historyEntity.status.id == 0
                      ? AppColor.primary.withOpacity(.2)
                      : historyEntity.status.id == 1
                          ? AppColor.orange.withOpacity(.2)
                          : historyEntity.status.id == 2
                              ? AppColor.green.withOpacity(.2)
                              : historyEntity.status.id == 3
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
                        color: historyEntity.status.id == 0
                            ? AppColor.primary
                            : historyEntity.status.id == 1
                                ? AppColor.orange
                                : historyEntity.status.id == 2
                                    ? AppColor.green
                                    : historyEntity.status.id == 3
                                        ? AppColor.danger
                                        : AppColor.primary,
                      ),
                      Gap(10.w),
                      Flexible(
                        child: Text(
                          historyEntity.status.description,
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
                        historyEntity.orderDescription,
                        maxLines:
                            ref.watch(changed("more${historyEntity.id}")) ==
                                    false
                                ? 2
                                : 10,
                      ),
                      ref.watch(changed("more${historyEntity.id}")) == false
                          ? const SizedBox()
                          : Column(
                              children: [
                                Gap(20.h),
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        Text("from".tr),
                                        Gap(10.h),
                                        Text("to".tr),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.location_on_outlined,
                                              color: AppColor.grey1,
                                            ),
                                            Gap(10.w),
                                            Text(
                                              historyEntity.from,
                                              style: AppFont.font12w500Grey2,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.location_on_outlined,
                                              color: AppColor.grey1,
                                            ),
                                            Gap(10.w),
                                            Text(
                                              historyEntity.from,
                                              style: AppFont.font12w500Grey2,
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                      Gap(20.h),
                      SizedBox(
                        height: 40.h,
                        child: ref.watch(changed("more${historyEntity.id}")) ==
                                true
                            ? CustomFilledButton(
                                text: "Less".tr,
                                widget: const Icon(Icons.keyboard_arrow_up),
                                color: AppColor.grey1,
                                onPressed: () {
                                  ref
                                          .read(
                                              changed("more${historyEntity.id}")
                                                  .notifier)
                                          .state =
                                      !ref.read(
                                          changed("more${historyEntity.id}"));
                                },
                              )
                            : CustomFilledButton(
                                text: "More".tr,
                                widget: const Icon(Icons.keyboard_arrow_down),
                                color: AppColor.grey1,
                                onPressed: () {
                                  ref
                                          .read(
                                              changed("more${historyEntity.id}")
                                                  .notifier)
                                          .state =
                                      !ref.read(
                                          changed("more${historyEntity.id}"));
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
    );
  }
}
