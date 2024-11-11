import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:learning/features/shared/notifications/presentation/managers/fetch_notificatons_provider.dart';
import 'package:learning/ui/shared_widgets/image_or_svg.dart';
import '../../../../../../config/app_font.dart';
import '../../../../../../core/service/loading_provider.dart';
import '../../../../../../main.dart';
import '../../../../../../ui/ui.dart';
import '../../../domain/entities/notification_entity.dart';
import '../../../domain/use_case/fetch_seen_use_case.dart';

class NotificationContainer extends ConsumerWidget {
  final NotificationEntity notificationEntity;

  const NotificationContainer({super.key, required this.notificationEntity});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: notificationEntity.seen == 0
          ? () async {
              try {
                ref
                    .read(isLoadingProvider("Seen${notificationEntity.id}")
                        .notifier)
                    .state = true;

                final history = await getIt<SeenNotificationUseCase>()
                    .call(notificationEntity.id);

                return history.fold((l) {
                  ref
                      .read(isLoadingProvider("Seen${notificationEntity.id}")
                          .notifier)
                      .state = false;
                  UIHelper.showAlert(l.message, type: DialogType.error);
                }, (r) {
                  ref.invalidate(fetchNotificationsProvider);
                });
              } finally {
                ref
                    .read(isLoadingProvider("Seen${notificationEntity.id}")
                        .notifier)
                    .state = false;
              }
            }
          : null,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(35),
            border: Border.all(color: AppColor.grey1)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Badge(
            isLabelVisible: notificationEntity.seen == 0,
            smallSize: 15,
            largeSize: 15,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: AppColor.primary.withOpacity(.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: ImageOrSvg(notificationEntity.logo),
                      ),
                    ),
                    const Gap(10),
                    Flexible(
                      child: Text(
                        notificationEntity.title,
                        style: AppFont.font15W500Black,
                      ),
                    ),
                  ],
                ),
                const Gap(15),
                Text(
                  notificationEntity.description,
                  style: AppFont.font12w400Black,
                ),
                const Gap(10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
