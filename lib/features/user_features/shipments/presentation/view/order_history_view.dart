import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:taiseer/config/app_font.dart';
import 'package:taiseer/config/app_translation.dart';
import 'package:taiseer/features/user_features/chat/data/models/conversation_model.dart';
import 'package:taiseer/features/user_features/chat/domain/use_case/chats_use_cases.dart';
import 'package:taiseer/features/user_features/chat/presentation/chats_screen.dart';
import 'package:taiseer/features/user_features/order/presentation/managers/fetch_order_history_provider.dart';
import 'package:taiseer/features/user_features/shipments/presentation/view/order_screen.dart';
import 'package:taiseer/features/user_features/shipments/presentation/view/widgets/custom_action_chip.dart';
import 'package:taiseer/features/user_features/shipments/presentation/view/widgets/history_container.dart';
import 'package:taiseer/features/user_features/shipments/data/models/shipment_model.dart';
import 'package:taiseer/features/user_features/shipments/domain/use_cases/shipment_use_cases.dart';
import 'package:taiseer/features/user_features/shipments/presentation/managers/fetch_shipment_providers.dart';
import 'package:taiseer/features/user_features/shipments/presentation/view/widgets/shipment_dialog.dart';
import 'package:taiseer/ui/shared_widgets/custom_app_bar.dart';
import 'package:taiseer/ui/shared_widgets/fade_in_animation.dart';
import 'package:taiseer/ui/shared_widgets/not_found_widget.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../main.dart';
import '../../../../../ui/shared_widgets/container_button.dart';
import '../../../order/presentation/managers/filter_model_provider.dart';

class OrderHistoryView extends ConsumerStatefulWidget {
  const OrderHistoryView({super.key});

  @override
  ConsumerState<OrderHistoryView> createState() => _OrderHistoryViewState();
}

class _OrderHistoryViewState extends ConsumerState<OrderHistoryView> {
  final PagingController<int, ShipmentModel> _pagingController =
      PagingController(firstPageKey: 1);

  Future<void> _fetchPage(int pageKey) async {
    final response = await getIt<FetchShipmentsUseCase>().call(pageKey);
    response.fold((l) {
      _pagingController.error = l;
    }, (r) {
      final isLastPage = r.total < 15;
      if (isLastPage) {
        _pagingController.appendLastPage(r.data);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(r.data, nextPageKey);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: "Orders".tr,
          isCenterTitle: false,
          hideBackButton: true,
          customWidget: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: ContainerButton(
                color: Colors.transparent,
                iconColor: AppColor.primary,
                icon: Icons.chat,
                onTap: () => Get.to(() => const ChatsScreen()),
              ),
            ),
          ]),
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
                        error: (e, ei) => const SizedBox.shrink(),
                        loading: () => Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: List.generate(
                                3,
                                (_) => Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                          end: 8.0),
                                      child: Shimmer.fromColors(
                                        baseColor: Colors.grey[900]!,
                                        highlightColor: Colors.green[100]!,
                                        child: Container(
                                          height: 40,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(.15),
                                            borderRadius:
                                                BorderRadius.circular(35),
                                          ),
                                        ),
                                      ),
                                    ))),
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
              final historyList = ref.watch(fetchShipmentsProvider(1));
              return historyList.customWhen(
                  ref: ref,
                  refreshable: fetchShipmentsProvider(1).future,
                  data: (history) {
                    if (history.data.isEmpty) {
                      return NotFoundWidget(title: "No orders right now.!".tr);
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: PagedListView<int, ShipmentModel>(
                        pagingController: _pagingController,
                        builderDelegate:
                            PagedChildBuilderDelegate<ShipmentModel>(
                          itemBuilder: (context, shipment, index) {
                            return FadeInAnimation(
                              direction: FadeInDirection.rightToLeft,
                              fadeOffset: 40,
                              delay: (index.toDouble() + 1) - (index - 1),
                              child: InkWell(
                                onTap: () => showShipmentDialog(context,
                                    ref: ref,
                                    order: shipment),
                                child: HistoryContainer(
                                    historyEntity: shipment),
                              ),
                            );
                          },
                          firstPageProgressIndicatorBuilder: (context) {
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
                          },
                          firstPageErrorIndicatorBuilder: (context) =>
                              Center(child: Text('Error loading data'.tr)),
                          newPageErrorIndicatorBuilder: (context) =>
                              Center(child: Text('Error loading more data'.tr)),
                        ),
                      ),
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
