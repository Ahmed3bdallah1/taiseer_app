import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:taiseer/config/app_color.dart';
import 'package:taiseer/features/user_features/shipments/presentation/managers/fetch_shipment_providers.dart';
import 'package:taiseer/features/user_features/shipments/presentation/view/widgets/last_shipment_container.dart';
import 'package:taiseer/features/user_features/shipments/presentation/view/widgets/shipment_dialog.dart';
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
            final provider = ref.watch(fetchLastShipmentProvider);
            return provider.customWhen(
                ref: ref,
                refreshable: fetchLastShipmentProvider.future,
                data: (orders) {
                  return InkWell(
                      onTap: () {
                        showShipmentDialog(context,order: orders,ref: ref);
                      },
                      child: LastShipmentContainer(shipment: orders));
                });
          })
        ],
      ),
    );
  }
}
