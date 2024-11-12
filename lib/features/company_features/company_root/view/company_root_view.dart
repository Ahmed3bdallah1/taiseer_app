import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:taiseer/features/company_features/calender/presentation/pages/calender_screen.dart';
import 'package:taiseer/features/company_features/company_root/controller/company_root_controller.dart';
import 'package:taiseer/features/company_features/search/presentation/view/search_screen.dart';
import 'package:taiseer/features/company_features/track_orders/presentation/view/track_order_screen.dart';
import 'package:taiseer/features/shared/notifications/presentation/view/notifications_screen.dart';
import 'package:taiseer/features/user_features/user_company/presentation/mangers/fetch_company_provider.dart';
import 'package:taiseer/ui/shared_widgets/container_button.dart';

import '../../../../config/app_color.dart';
import '../../../../config/app_font.dart';
import '../../../../core/service/auth_service.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../helper/responsive.dart';
import '../../../../packages/flutter_close_app.dart';
import '../../../../ui/shared_widgets/custom_logo_app_bar.dart';
import '../../../../ui/shared_widgets/image_or_svg.dart';

final hideNavBarProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});

class CompanyRootView extends ConsumerStatefulWidget {
  const CompanyRootView({super.key});

  @override
  ConsumerState<CompanyRootView> createState() => _CompanyRootViewState();
}

class _CompanyRootViewState extends ConsumerState<CompanyRootView> {
  @override
  Widget build(BuildContext context) {
    responsiveInit(context);
    final selectedIndex = ref.watch(companyRootIndex);
    final controller = ref.read(companyRootIndex.notifier);
    return FlutterCloseAppPage(
      condition: selectedIndex == 0,
      onCloseFailed: () {
        if (selectedIndex != 0) {
          final controller = ref.read(companyRootIndex.notifier);

          controller.reset();
        } else {
          Fluttertoast.showToast(
            msg: 'Press again to exit'.tr,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
          );
        }
      },
      child: Consumer(
        builder: (context, ref, child) {
          final provider = ref.watch(fetchUserCompaniesViewProvider);
          return Scaffold(
              appBar: selectedIndex == 1
                  ? null
                  : CustomLogoAppbar(
                      customTitleWidget: provider.customWhen(
                          ref: ref,
                          refreshable: fetchUserCompaniesViewProvider.future,
                          data: (data) {
                            return Row(
                              children: [
                                ImageOrSvg(
                                  data[0].image ?? "",
                                  isLocal: true,
                                ),
                                Gap(10.w),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(data[0].title ?? '',
                                        style: AppFont.font14W700Black),
                                    Gap(4.h),
                                    Text('Admin',
                                        style: AppFont.font10w400Primary),
                                  ],
                                )
                              ],
                            );
                          }),
                      isCenterTitle: false,
                      hideBackButton: true,
                      buttonWidget: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: ContainerButton(
                          onTap: () {},
                          iconColor: AppColor.primary,
                          color: Colors.transparent,
                          icon: Icons.menu,
                        ),
                      ),
                    ),
              bottomNavigationBar: ref.watch(hideNavBarProvider)
                  ? null
                  : BottomNavigationBar(
                      landscapeLayout:
                          BottomNavigationBarLandscapeLayout.linear,
                      type: BottomNavigationBarType.fixed,
                      currentIndex: selectedIndex,
                      enableFeedback: false,
                      unselectedLabelStyle: AppFont.font13W600Grey1,
                      selectedLabelStyle: AppFont.font13W600Grey1,
                      backgroundColor: AppColor.nearlyWhite,
                      showUnselectedLabels: false,
                      items: [
                        BottomNavigationBarItem(
                          icon: Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            child: SvgPicture.asset(
                              Assets.navigationBar.home2,
                              color: controller.isSelectedIndex(0)
                                  ? AppColor.primary
                                  : AppColor.black,
                              height: 21.h,
                            ),
                          ),
                          label: "Home".tr,
                        ),
                        BottomNavigationBarItem(
                          icon: Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            child: SvgPicture.asset(
                              Assets.base.calender,
                              color: controller.isSelectedIndex(1)
                                  ? AppColor.primary
                                  : AppColor.black,
                              height: 21.h,
                            ),
                          ),
                          label: 'Dates'.tr,
                        ),
                        BottomNavigationBarItem(
                          icon: Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            child: Icon(
                              Icons.notifications_active_rounded,
                              color: controller.isSelectedIndex(2)
                                  ? AppColor.primary
                                  : AppColor.black,
                              size: 22.h,
                            ),
                          ),
                          label: "Notifications".tr,
                        ),
                        BottomNavigationBarItem(
                          icon: Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            child: SvgPicture.asset(
                              Assets.base.search,
                              color: controller.isSelectedIndex(3)
                                  ? AppColor.primary
                                  : AppColor.black,
                              height: 21.h,
                            ),
                          ),
                          label: "Search".tr,
                        ),
                        BottomNavigationBarItem(
                          icon: Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            child: SvgPicture.asset(
                              Assets.navigationBar.box,
                              color: controller.isSelectedIndex(4)
                                  ? AppColor.primary
                                  : AppColor.black,
                              height: 21.h,
                            ),
                          ),
                          label: "Follow orders".tr,
                        ),
                      ],
                      onTap: (index) {
                        controller.setSelectedIndex(
                          index,
                        );
                      },
                    ),
              body: Consumer(
                builder: (context, ref, child) {
                  final selectedIndex = ref.watch(companyRootIndex);
                  final args = ref.read(companyRootIndex.notifier).args;
                  return getView(selectedIndex, args: args, ref);
                },
              ));
        },
      ),
    );
  }

  Widget getView(int index, WidgetRef ref, {Map<String, dynamic>? args}) {
    final profileNotCompleted = ref.watch(isNeedToCompleteProfile);
    return switch (index) {
      1 => const CalenderScreen(),
      2 => const NotificationsScreen(),
      3 => const SearchScreen(),
      4 => const TrackOrderScreen(),
      _ => const SizedBox()
      // 0 => HomeScreen(profileNotCompleted),
      // 1 => const OrderHistoryView(),
      // 2 => const SupportScreen(),
      // _ => const EditProfileScreen(),
    };
  }
}
