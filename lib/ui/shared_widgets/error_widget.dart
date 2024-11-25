import 'package:flutter/material.dart';
import 'package:get/get.dart';

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


class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key, this.onRetry, this.msg = 'No data found'});

  final String msg;
  final void Function()? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(msg.tr, style: TextStyle(fontSize: 20.sp, color: Colors.black)),
          if (onRetry != null)
            TextButton(
                onPressed: onRetry!,
                child: const Icon(
                  Icons.refresh,
                  color: Colors.black,
                ))
        ],
      ),
    );
  }
}