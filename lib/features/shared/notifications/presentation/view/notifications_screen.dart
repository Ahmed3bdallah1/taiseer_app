import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:learning/config/app_color.dart';
import 'package:learning/config/app_font.dart';
import 'package:learning/features/shared/notifications/presentation/managers/fetch_notificatons_provider.dart';
import 'package:learning/features/shared/notifications/presentation/view/widgets/notifications_container.dart';
import 'package:learning/ui/shared_widgets/custom_app_bar.dart';
import 'package:learning/ui/shared_widgets/hide_nav_bar_widget.dart';
import 'package:learning/ui/shared_widgets/not_found_widget.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../user_features/order/presentation/view/widgets/custom_action_chip.dart';
import '../managers/notifications_filter.dart';

class NotificationsScreen extends ConsumerStatefulWidget {
  const NotificationsScreen({super.key});

  @override
  ConsumerState<NotificationsScreen> createState() =>
      _NotificationsScreenState();
}

class _NotificationsScreenState extends ConsumerState<NotificationsScreen> {
  late final AutoDisposeStateProvider<bool> hideNavBarProvider2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hideNavBarProvider2 = StateProvider.autoDispose<bool>((ref) {
      return false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedSizeAndFade.showHide(
              show: !ref.watch(hideNavBarProvider2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppBar2(title: "Notifications".tr),
                  Consumer(builder: (context, ref, child) {
                    const data = NotificationFilterType.values;
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                            children: data
                                .map(
                                  (e) =>
                                      NotificationsCustomActionChip(value: e),
                                )
                                .toList()),
                      ),
                    );
                  }),
                ],
              )),
          Expanded(
            child: HideNavBarWidget(
              customProvider: hideNavBarProvider2,
              child: Consumer(builder: (context, ref, _) {
                final notificationsList = ref.watch(fetchNotificationsProvider);
                return notificationsList.customWhen(
                    ref: ref,
                    refreshable: fetchNotificationsProvider.future,
                    data: (notifications) {
                      if (notifications.isEmpty) {
                        return NotFoundWidget(
                            title: "No Notifications right now.!".tr);
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              return NotificationContainer(
                                  notificationEntity: notifications[index]);
                            },
                            separatorBuilder: (context, index) {
                              return const Gap(10);
                            },
                            itemCount: notifications.length),
                      );
                    },
                    loading: () {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey[900]!,
                              highlightColor: Colors.green[100]!,
                              child: Container(
                                height: 180,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(.15),
                                  borderRadius: BorderRadius.circular(35),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    });
              }),
            ),
          )
        ],
      ),
    );
  }
}
