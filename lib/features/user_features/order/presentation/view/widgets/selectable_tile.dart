import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../config/app_font.dart';

class SelectableTile extends StatelessWidget {
  final void Function()? onTap;
  final bool isSelected;
  final String name;

  const SelectableTile({
    super.key,
    this.onTap,
    required this.isSelected,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColor.grey1)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: AppFont.font12w400Black,
              ),
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColor.grey1, width: 1.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.circle,
                    size: 14,
                    color: isSelected ? AppColor.primary : Colors.transparent),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Map<String, dynamic> _handle(Map<String, dynamic> data) {
  final map = {
    ...data,
    'contracts': jsonEncode([
      for (final item in data.entries.where((e) => e.key.contains("contract")))
        {
          'id': item.key.numericOnly(),
          'signature': item.value,
        }
    ])
  };
  map.removeWhere(
          (key, value) => key.contains("contract[") || key.contains('index'));
  return map;
}

Map<String, dynamic> flattenMap<T>(Map list) {
  Map<String, dynamic> result = {};

  void flatten(key, value) {
    if (value is Map) {
      value.forEach(flatten);
    } else {
      result.putIfAbsent(key, () => value);
    }
  }

  list.forEach(flatten);
  return result;
}