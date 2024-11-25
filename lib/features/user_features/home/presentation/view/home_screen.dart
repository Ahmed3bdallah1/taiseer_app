import 'package:carousel_slider/carousel_slider.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:taiseer/config/app_font.dart';
import 'package:taiseer/core/service/auth_service.dart';
import 'package:taiseer/features/user_features/home/presentation/managers/fetch_ads_provider.dart';
import 'package:taiseer/features/user_features/home/presentation/view/widgets/company_home_view.dart';
import 'package:taiseer/features/user_features/home/presentation/view/widgets/silder_item_widget.dart';
import 'package:taiseer/features/user_features/profile/presentation/view/update_profile_view.dart';
import 'package:taiseer/features/user_features/root/controller/root_controller.dart';
import 'package:taiseer/features/user_features/shipments/presentation/managers/fetch_shipment_providers.dart';
import 'package:taiseer/features/user_features/shipments/presentation/view/widgets/last_shipment_container.dart';
import 'package:taiseer/ui/shared_widgets/fade_in_animation.dart';
import 'package:shimmer/shimmer.dart';
import 'package:taiseer/ui/ui.dart';
import '../../../../../config/api_path.dart';
import '../../../../../ui/shared_widgets/container_button.dart';
import '../../../../../ui/shared_widgets/custom_slider.dart';
import '../../../../shared/notifications/presentation/managers/fetch_notificatons_provider.dart';
import '../../../../shared/notifications/presentation/view/notifications_screen.dart';
import '../../../user_company/presentation/mangers/fetch_company_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen(this.profileNotCompleted, {super.key});

  final bool profileNotCompleted;

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      backgroundColor: AppColor.primaryWhite,
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(fetchNotificationsProvider);
          ref.invalidate(fetchUserCompaniesViewProvider);
          ref.invalidate(fetchAdsProvider);
          ref.invalidate(fetchLastShipmentProvider);
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              final controller = ref.read(rootIndex.notifier);
                              controller.setSelectedIndex(3);
                            },
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage: ref
                                          .watch(userProvider)
                                          ?.profilePhotoUrl ==
                                      null
                                  ? const ExtendedAssetImageProvider(
                                      "assets/base/personal.png")
                                  : ExtendedNetworkImageProvider(
                                          cache: true,
                                          "${ApiPath.uploadPath}${ref.watch(userProvider)?.profilePhotoUrl}")
                                      as ImageProvider<Object>,
                            ),
                          ),
                          const Gap(10),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text("Welcome, ".tr),
                                    Text("${ref.read(userProvider)?.name}"),
                                  ],
                                ),
                                Text("we wish you a happy day 👋".tr)
                              ])
                        ],
                      ),
                      SizedBox(
                        height: 56,
                        width: 56,
                        child: Consumer(builder: (context, ref, _) {
                          final notificationsList =
                              ref.watch(fetchNotificationsProvider);
                          return notificationsList.customWhen(
                            ref: ref,
                            refreshable: fetchNotificationsProvider.future,
                            data: (notes) {
                              final hasUnSeen =
                                  notes.firstWhereOrNull((e) => e.seen == 0);
                              if (hasUnSeen == null) {
                                return Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: ContainerButton(
                                    color: Colors.transparent,
                                    iconColor: AppColor.primary,
                                    icon: Icons.notifications_active,
                                    onTap: () => Get.to(
                                        () => const NotificationsScreen()),
                                  ),
                                );
                              } else {
                                return Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: ContainerButton(
                                        color: Colors.transparent,
                                        iconColor: AppColor.primary,
                                        icon: Icons.notifications_active,
                                        onTap: () => Get.to(
                                            () => const NotificationsScreen()),
                                      ),
                                    ),
                                    const Positioned(
                                        top: 2,
                                        right: 2,
                                        child: CircleAvatar(
                                            backgroundColor: Colors.red,
                                            radius: 7))
                                  ],
                                );
                              }
                            },
                            loading: () {
                              return Padding(
                                padding: const EdgeInsets.all(5),
                                child: ContainerButton(
                                  color: Colors.transparent,
                                  iconColor: AppColor.primary,
                                  icon: Icons.notifications_active,
                                  onTap: () =>
                                      Get.to(() => const NotificationsScreen()),
                                ),
                              );
                            },
                            error: (e, ei) {
                              return Padding(
                                padding: const EdgeInsets.all(5),
                                child: ContainerButton(
                                  color: Colors.transparent,
                                  iconColor: AppColor.primary,
                                  icon: Icons.notifications_active,
                                  onTap: () {
                                    UIHelper.showGlobalSnackBar(
                                        text: "coming soon");
                                  },
                                ),
                              );
                            },
                          );
                        }),
                      )
                    ],
                  ),
                  Gap(20.h),
                  if (profileNotCompleted)
                    Column(
                      children: [
                        InkWell(
                          onTap: () => Get.to(() => const UpdateProfileView()),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Text("Please Complete Your Profile".tr),
                                const Spacer(),
                                const ContainerButton(
                                  icon: Icons.verified_user_outlined,
                                )
                              ],
                            ),
                          ),
                        ),
                        Gap(10.h)
                      ],
                    ),
                  Consumer(builder: (context, ref, _) {
                    final lastOrder = ref.watch(fetchLastShipmentProvider);
                    return lastOrder.customWhen(
                        ref: ref,
                        refreshable: fetchLastShipmentProvider.future,
                        data: (shipment) {
                          return FadeInAnimation(
                              delay: 1.3,
                              direction: FadeInDirection.topToBottom,
                              fadeOffset: 40,
                              child: LastShipmentContainer(shipment: shipment));
                        },
                        error: (d, ds) => Text(d.toString()),
                        loading: () {
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
                        });
                  }),
                  Gap(20.h),
                  Consumer(
                    builder: (context, ref, _) {
                      final provider = ref.watch(fetchAdsProvider);
                      return provider.customWhen(
                          ref: ref,
                          refreshable: fetchAdsProvider.future,
                          data: (ads) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Companies Sponsors".tr,
                                  style: AppFont.font18W700Black,
                                ),
                                Gap(8.h),
                                CustomSlider(
                                  ads.map((e) => SliderItem(e)).toList(),
                                  height: 170.h,
                                  autoPlay: true,
                                  onPageChanged: (index, _) {
                                    ref
                                        .read(sliderIndexProvider.notifier)
                                        .state = index;
                                  },
                                )
                              ],
                            );
                          },
                          loading: () {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Shimmer.fromColors(
                                  baseColor: Colors.grey[900]!,
                                  highlightColor: Colors.green[100]!,
                                  child: Container(
                                    height: 40.h,
                                    width:
                                        MediaQuery.of(context).size.width * .4,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(.15),
                                      borderRadius: BorderRadius.circular(35),
                                    ),
                                  ),
                                ),
                                Gap(10.h),
                                CarouselSlider(
                                  options: CarouselOptions(
                                    autoPlay: true,
                                    enlargeCenterPage: true,
                                    height: 200,
                                    viewportFraction: 1,
                                    initialPage: 0,
                                    enableInfiniteScroll: false,
                                  ),
                                  items: const [
                                    SliderShimmerItem(),
                                    SliderShimmerItem(),
                                    SliderShimmerItem(),
                                  ],
                                ),
                              ],
                            );
                          });
                    },
                  ),
                  Gap(20.h),
                  const UserHomeCompanyView()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
