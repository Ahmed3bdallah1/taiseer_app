import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:learning/config/app_color.dart';
import 'package:learning/config/app_font.dart';

import '../../features/shared/offline/widgets/reload_button.dart';

class NotFoundWidget extends StatelessWidget {
  const NotFoundWidget({
    required this.title,
    this.message,
    this.onTryAgain,
    this.noIcon = false,
    this.center = true,
    super.key,
    this.icon,
  });

  final String title;
  final bool noIcon;
  final String? message;
  final bool center;
  final VoidCallback? onTryAgain;
  final String? icon;

  @override
  Widget build(BuildContext context) {
    responsiveInit(context);
    final message = this.message;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 32,
          horizontal: 16,
        ),
        child: Column(
          mainAxisAlignment:
              center ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            if (!noIcon) ...[
              Center(
                  child: SvgPicture.asset(
                      icon ?? "assets/shipments/no_items.svg")),
              Gap(4.h),
            ],
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            if (message != null)
              const SizedBox(
                height: 16,
              ),
            if (message != null)
              Text(
                message,
                textAlign: TextAlign.center,
              ),
            if (onTryAgain != null)
              SizedBox(
                height: 8.h,
              ),
            if (onTryAgain != null)
              ReloadButton(
                onTap: onTryAgain,
                size: 25,
                color: AppColor.primary,
              ),
          ],
        ),
      ),
    );
  }
}
