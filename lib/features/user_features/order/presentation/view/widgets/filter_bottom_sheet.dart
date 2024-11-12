import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:taiseer/config/app_translation.dart';
import 'package:taiseer/features/user_features/order/presentation/managers/filter_model_provider.dart';
import 'package:taiseer/features/user_features/user_company/presentation/view/search_filter_bottom_sheet.dart';
import 'package:taiseer/ui/shared_widgets/custom_filled_button.dart';

import '../../../../../../config/app_font.dart';
import '../../../../../../ui/shared_widgets/custom_app_bar.dart';
import '../../managers/history_filter_notifier_provider.dart';
import 'custom_action_chip.dart';

enum FilterSheetType { orderHistory, filterCompanies }

void showFilterBottomSheet(BuildContext context, {FilterSheetType? type}) {
  showModalBottomSheet(
    scrollControlDisabledMaxHeightRatio:
        type == FilterSheetType.filterCompanies ? .45 : .6,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) {
      if (type == FilterSheetType.filterCompanies) {
        return const SearchCompaniesUserFilterBottomSheet();
      } else {
        return const FilterBottomSheet();
      }
    },
  );
}

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final attr = ref.watch(fetchFilterModelProvider);
      return ClipRRect(
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(18), topLeft: Radius.circular(18)),
        child: Scaffold(
          backgroundColor: attr.hasValue ? Colors.transparent : null,
          body: attr.customWhen(
              ref: ref,
              refreshable: fetchFilterModelProvider.future,
              data: (data) {
                return Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Colors.white),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 13),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomAppBar(
                            title: "filter".tr,
                            isCenterTitle: true,
                          ),
                          Gap(10.h),
                          Wrap(
                            spacing: 0,
                            runSpacing: 0,
                            crossAxisAlignment: WrapCrossAlignment.start,
                            alignment: WrapAlignment.start,
                            runAlignment: WrapAlignment.start,
                            children: [
                              CustomActionChip(
                                onChange: (sad) {
                                  return sad.updateFilter;
                                },
                                value: const FilterAttributes(
                                    key: 'order_status',
                                    title: 'all',
                                    value: null),
                              ),
                              ...data.status.map((e) => CustomActionChip(
                                    onChange: (sad) {
                                      return sad.updateFilter;
                                    },
                                    value: FilterAttributes(
                                        value: e.id,
                                        key: 'order_status',
                                        title: e.title!),
                                  )),
                            ],
                          ),
                          Gap(30.h),
                          Row(
                            children: [
                              Text("order view".tr,
                                  style: AppFont.labelTextField.copyWith(
                                      fontSize: 20, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Wrap(
                            children: [
                              CustomActionChip(
                                onChange: (sad) {
                                  return sad.updateFilter;
                                },
                                value: const FilterAttributes(
                                    key: 'sort', value: 'desc', title: 'desc'),
                              ),
                              CustomActionChip(
                                onChange: (sad) {
                                  return sad.updateFilter;
                                },
                                value: const FilterAttributes(
                                    key: 'sort', value: 'asc', title: 'asc'),
                              ),
                            ],
                          ),
                          Gap(120.h),
                          // Row(
                          //   children: [
                          //     Text("program type".tr,
                          //         style: AppFont.labelTextField.copyWith(
                          //             fontSize: 20, fontWeight: FontWeight.bold)),
                          //   ],
                          // ),
                          // Wrap(
                          //   children: data.programType
                          //       .map(
                          //         (e) => CustomActionChip(
                          //           onChange: (sad) {
                          //             return sad.updateFilter;
                          //           },
                          //           value: FilterAttributes(
                          //               key: 'program_type_id',
                          //               value: e.id,
                          //               title: e.title!),
                          //         ),
                          //       )
                          //       .toList(),
                          // ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
          bottomSheet: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: CustomFilledButton(
                    widget: const Icon(Icons.delete),
                    onPressed: () {
                      return ref.refresh(historyProvider);
                    },
                  ),
                ),
                Gap(8.w),
                Expanded(
                  flex: 2,
                  child: CustomFilledButton(
                    text: "done".tr,
                    onPressed: () => Get.back(),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
