import 'package:flutter/material.dart';

import '../../config/app_color.dart';
import '../../features/shared/offline/widgets/reload_button.dart';

class CustomErrorWidget extends StatelessWidget {
  final Object? object;
  final StackTrace? stackTrace;
  final String? message;
  final Future Function()? onRetry;

  const CustomErrorWidget({
    super.key,
    this.object,
    this.stackTrace,
    this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    responsiveInit(context);
    final msg = message ?? object.toString();
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            msg,
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          if (onRetry != null) SizedBox(height: 8.h),
          if (onRetry != null)
            ReloadButton(
              onTap: onRetry,
              size: 25,
              color: AppColor.primary,
            ),
        ],
      ),
    );
  }
}
