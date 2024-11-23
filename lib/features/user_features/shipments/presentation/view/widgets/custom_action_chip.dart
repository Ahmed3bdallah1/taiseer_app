import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:taiseer/config/app_translation.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../../config/app_font.dart';
import '../../../../../shared/notifications/presentation/managers/notifications_filter.dart';
import '../../../../order/presentation/managers/history_filter_notifier_provider.dart';

class CustomActionChip extends ConsumerWidget {
  const CustomActionChip({
    super.key,
    required this.value,
    required this.onChange,
    this.alwaysActive = false,
  });

  final FilterAttributes value;
  final bool alwaysActive;
  final Function(HistoryFilterNotifier data) onChange;

  @override
  Widget build(BuildContext context, ref) {
    final isSelected =
        alwaysActive || ref.watch(historyProvider)[value.key] == value.value;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: ActionChip(
        onPressed: () {
          onChange.call(ref.read(historyProvider.notifier))(value);
        },
        label: Text(
          value.title.tr,
          style: AppFont.labelTextField.copyWith(
              color: !isSelected ? AppColor.black : AppColor.white,
              fontSize: 14),
        ),
        backgroundColor: (isSelected
            ? value.value == 0
                ? AppColor.primary
                : value.value == 1
                    ? AppColor.orange
                    : value.value == 2
                        ? AppColor.green
                        : value.value == 3
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
