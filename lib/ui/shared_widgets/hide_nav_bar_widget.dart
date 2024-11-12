import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taiseer/config/app_color.dart';

import '../../features/user_features/root/view/root_view.dart';

class HideNavBarWidget extends ConsumerWidget {
  const HideNavBarWidget({
    super.key,
    required this.child,
    this.customProvider,
    this.enabled = true,
  });

  final Widget child;
  final bool enabled;
  final AutoDisposeStateProvider<bool>? customProvider;

  @override
  Widget build(BuildContext context, ref) {
    responsiveInit(context);
    if (!enabled) return child;
    return NotificationListener<UserScrollNotification>(
      onNotification: (notification) {
        switch (notification.direction) {
          case ScrollDirection.forward:
            ref
                .read(customProvider?.notifier ?? hideNavBarProvider.notifier)
                .state = false;
            break;
          case ScrollDirection.reverse:
            ref
                .read(customProvider?.notifier ?? hideNavBarProvider.notifier)
                .state = true;
            break;
          case ScrollDirection.idle:
            break;
        }
        return true;
      },
      child: child,
    );
  }
}
