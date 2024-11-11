import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:learning/config/app_font.dart';
import 'package:learning/config/app_translation.dart';
import 'package:learning/features/user_features/order/presentation/managers/fetch_order_history_provider.dart';
import 'package:learning/features/user_features/order/presentation/view/widgets/custom_action_chip.dart';
import 'package:learning/features/user_features/order/presentation/view/widgets/history_container.dart';
import 'package:learning/ui/shared_widgets/custom_app_bar.dart';
import 'package:learning/ui/shared_widgets/fade_in_animation.dart';
import 'package:learning/ui/shared_widgets/not_found_widget.dart';
import 'package:shimmer/shimmer.dart';
import '../managers/filter_model_provider.dart';

class OrderHistoryView extends ConsumerStatefulWidget {
  const OrderHistoryView({super.key});

  @override
  ConsumerState<OrderHistoryView> createState() => _OrderHistoryViewState();
}

class _OrderHistoryViewState extends ConsumerState<OrderHistoryView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Orders".tr,
        isCenterTitle: false,
        hideBackButton: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Consumer(builder: (context, ref, child) {
                      final attr = ref.watch(fetchFilterModelProvider);
                      return attr.customWhen(
                        ref: ref,
                        refreshable: fetchFilterModelProvider.future,
                        data: (data) {
                          return Row(
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
                          );
                        },
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
          Gap(10.h),
          Expanded(
            child: Consumer(builder: (context, ref, _) {
              final historyList = ref.watch(fetchOrderHistoryProvider);
              return historyList.customWhen(
                  ref: ref,
                  refreshable: fetchOrderHistoryProvider.future,
                  data: (history) {
                    if (history.isEmpty) {
                      return NotFoundWidget(title: "No orders right now.!".tr);
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            return FadeInAnimation(
                              direction: FadeInDirection.rightToLeft,
                              fadeOffset: 40,
                              delay: (index.toDouble() + 1) - (index - 1),
                              child: HistoryContainer(
                                  historyEntity: history[index]),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Gap(10);
                          },
                          itemCount: history.length),
                    );
                  },
                  loading: () {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[900]!,
                            highlightColor: Colors.green[100]!,
                            child: Container(
                              height: 180,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(.15),
                                borderRadius: BorderRadius.circular(35),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  });
            }),
          )
        ],
      ),
    );
  }
}
