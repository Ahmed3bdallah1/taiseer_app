import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:taiseer/core/service/auth_service.dart';
import 'package:taiseer/features/shared/auth/presentation/manager/auth_provuder.dart';
import 'package:taiseer/features/user_features/home/presentation/view/home_screen.dart';
import 'package:taiseer/features/user_features/shipments/presentation/view/order_history_view.dart';
import 'package:taiseer/features/user_features/profile/presentation/view/edit_profile.dart';
import 'package:taiseer/features/user_features/support/presentation/view/support_screen.dart';
import '../../../../config/app_font.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../packages/flutter_close_app.dart';
import '../controller/root_controller.dart';

final hideNavBarProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});

class RootView extends ConsumerStatefulWidget {
  const RootView({super.key});

  @override
  ConsumerState<RootView> createState() => _RootViewState();
}

class _RootViewState extends ConsumerState<RootView> {
  @override
  Widget build(BuildContext context) {
    responsiveInit(context);
    final selectedIndex = ref.watch(rootIndex);
    final controller = ref.read(rootIndex.notifier);
    final haveNoCountries = ref.watch(fetchCountryProvider).value == null;
    return FlutterCloseAppPage(
      condition: selectedIndex == 0,
      onCloseFailed: () {
        if (selectedIndex != 0) {
          final controller = ref.read(rootIndex.notifier);

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
          return Scaffold(
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
                              Assets.navigationBar.box,
                              color: controller.isSelectedIndex(1)
                                  ? AppColor.primary
                                  : AppColor.black,
                              height: 21.h,
                            ),
                          ),
                          label: 'Orders'.tr,
                        ),
                        BottomNavigationBarItem(
                          icon: Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            child: SvgPicture.asset(
                              Assets.navigationBar.messageQuestion,
                              color: controller.isSelectedIndex(2)
                                  ? AppColor.primary
                                  : AppColor.black,
                              height: 21.h,
                            ),
                          ),
                          label: "Support".tr,
                        ),
                        BottomNavigationBarItem(
                          icon: Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            child: SvgPicture.asset(
                              Assets.navigationBar.profileCircle,
                              color: controller.isSelectedIndex(3)
                                  ? AppColor.primary
                                  : AppColor.black,
                              height: 21.h,
                            ),
                          ),
                          label: "Profile".tr,
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
                  final selectedIndex = ref.watch(rootIndex);
                  final args = ref.read(rootIndex.notifier).args;
                  if (haveNoCountries) {
                    ref.watch(fetchCountryProvider);
                  }
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
      0 => HomeScreen(profileNotCompleted),
      1 => const OrderHistoryView(),
      2 => const SupportScreen(),
      _ => const EditProfileScreen(),
    };
  }
}
