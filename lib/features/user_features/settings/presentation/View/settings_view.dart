import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:taiseer/config/app_font.dart';
import 'package:taiseer/features/user_features/chat/presentation/chats_screen.dart';
import 'package:taiseer/features/user_features/profile/presentation/view/update_profile_view.dart';
import 'package:taiseer/features/user_features/settings/presentation/View/privacy_policy_screen.dart';
import 'package:taiseer/features/user_features/settings/presentation/View/widgets/setting_item_widget.dart';
import 'package:taiseer/features/user_features/support/presentation/view/support_screen.dart';
import '../../../../../core/service/localization_service/localization_service.dart';
import '../../../../../ui/shared_widgets/custom_app_bar.dart';
import '../../../../../ui/shared_widgets/select_language_dialog.dart';
import '../../../../shared/auth/presentation/view/login_page.dart';

class SettingsView extends ConsumerWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Settings".tr,
        isCenterTitle: false,
        hideBackButton: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 15.0.w, right: 15.w, bottom: 10.h),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SettingsItem(
                    onTap: () => Get.to(() => const UpdateProfileView()),
                    icon: CupertinoIcons.profile_circled,
                    title: "Profile".tr),
                Gap(12.h),
                SettingsItem(
                    onTap: () async => Get.to(() => const ChatsScreen()),
                    icon: Icons.message,
                    title: 'Chats'.tr),
                Gap(12.h),
                SettingsItem(
                    onTap: () async => showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (context) {
                          return const SelectLanguageDialog();
                        }),
                    icon: Icons.language,
                    title: 'Language'.tr),
                Gap(12.h),
                SettingsItem(
                    onTap: () => Get.to(() => const SupportScreen()),
                    icon: Icons.support_agent,
                    isSupport: true,
                    title: 'Support'.tr),
                Gap(12.h),
                SettingsItem(
                    onTap: () => Get.to(() => const PrivacyPolicyScreen()),
                    icon: Icons.privacy_tip,
                    title: 'Privacy Policy'.tr),
                Gap(12.h),
                SettingsItem(
                    onTap: () => Get.to(() => const WhoAreWeScreen()),
                    icon: Icons.info_outline,
                    title: 'Who Are We'.tr),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () async {
                localeService.dataManager.removeLoggedUser();
                Get.offAll(() => const LoginPage());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.logout,color: AppColor.danger,),
                  const Gap(10),
                  Text('Logout'.tr,style: AppFont.font14W700Danger,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
