import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:learning/config/app_color.dart';
import 'package:learning/features/company_features/track_orders/presentation/view/order_dialog_widget.dart';
import 'package:learning/features/user_features/order/presentation/managers/fetch_last_order_provider.dart';
import 'package:learning/features/user_features/order/presentation/view/widgets/last_order_container.dart';
import '../../../../../ui/shared_widgets/custom_app_bar.dart';

class TrackOrderScreen extends ConsumerWidget {
  const TrackOrderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          CustomAppBar2(title: "Track Order".tr),
          Consumer(builder: (context, ref, _) {
            final provider = ref.watch(fetchLastOrderProvider);
            return provider.customWhen(
                ref: ref,
                refreshable: fetchLastOrderProvider.future,
                data: (orders) {
                  return InkWell(
                      onTap: () {
                        showOrderDialog(context,order: orders);
                      },
                      child: LastOrderContainer(orderEntity: orders));
                });
          })
        ],
      ),
    );
  }
}
