import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import '../../../../../config/app_font.dart';
import '../../../../../config/app_translation.dart';
import '../mangers/search_filter_provider.dart';

class CustomCompanyFilterActionChip extends ConsumerWidget {
  const CustomCompanyFilterActionChip({
    super.key,
    required this.value,
    required this.onChange,
    this.alwaysActive = false,
  });

  final FilterAttributes value;
  final bool alwaysActive;
  final Function(CompanyFilterNotifier data) onChange;

  @override
  Widget build(BuildContext context, ref) {
    final isSelected =
        alwaysActive || ref.watch(companyFilterProvider)[value.key] == value.value;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: ActionChip(
        onPressed: () {
          onChange.call(ref.read(companyFilterProvider.notifier))(value);
        },
        label: Text(
          value.title.tr,
          style: AppFont.labelTextField.copyWith(
              color: !isSelected ? AppColor.black : AppColor.grey1,
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