import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import '../../../../../../config/app_font.dart';
import '../../../../../shared/notifications/presentation/managers/notifications_filter.dart';
import '../../managers/fetch_shipment_providers.dart';
import '../shipment_history_view.dart';

class CustomShipmentHistoryActionChip extends ConsumerWidget {
  const CustomShipmentHistoryActionChip({
    super.key,
    required this.value,
    this.alwaysActive = false,
  });

  final FilterShipmentProviderEnums value;
  final bool alwaysActive;

  @override
  Widget build(BuildContext context, ref) {
    final isSelected =
        alwaysActive || ref.watch(shipmentTypeProvider).name == value.name;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: ActionChip(
        onPressed: () {
          ref.read(shipmentTypeProvider.notifier).state = value;
        },
        label: Text(
          value.name.tr,
          style: AppFont.labelTextField.copyWith(
              color: !isSelected ? AppColor.black : AppColor.white,
              fontSize: 14),
        ),
        backgroundColor: (isSelected
            ? value.name.toLowerCase() == "new"
                ? AppColor.primary
                : value.name.toLowerCase() == "in_transit"
                    ? AppColor.orange
                    : value.name.toLowerCase() == "accepted" || value.name.toLowerCase() == "delivered"
                        ? AppColor.green
                        : value.name.toLowerCase() == "rejected" || value.name.toLowerCase() == "closed"
                            ? AppColor.danger
                            : AppColor.primary
            : AppColor.grey1.withOpacity(.4)),
      ),
    );
  }
}

class NotificationsCustomActionChip extends ConsumerWidget {
  const NotificationsCustomActionChip({
    super.key,
    required this.value,
    this.alwaysActive = false,
  });

  final NotificationFilterType value;
  final bool alwaysActive;

  @override
  Widget build(BuildContext context, ref) {
    final isSelected =
        alwaysActive || ref.watch(notificationsProvider)['status'] == value.key;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: ActionChip(
          onPressed: () {
            ref.read(notificationsProvider.notifier).updateStatus(value);
          },
          label: Text(
            value.name.tr,
            style: AppFont.labelTextField.copyWith(
                color: !isSelected ? AppColor.black : AppColor.grey1,
                fontSize: 14),
          ),
          backgroundColor:
              (isSelected ? AppColor.primary : AppColor.grey1.withOpacity(.4))),
    );
  }
}
