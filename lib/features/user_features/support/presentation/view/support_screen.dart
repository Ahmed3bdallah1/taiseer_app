import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:learning/config/app_font.dart';
import 'package:learning/features/user_features/support/presentation/managers/fetch_support_provider.dart';
import 'package:learning/features/user_features/support/presentation/view/widgets/circle_avatar_button.dart';
import 'package:learning/ui/shared_widgets/url_launcher.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../ui/shared_widgets/custom_app_bar.dart';

class SupportScreen extends ConsumerWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(fetchSupportProvider);
    return Scaffold(
      appBar: CustomAppBar(
        title: "Support".tr,
        isCenterTitle: false,
        hideBackButton: true,
      ),
      body: provider.customWhen(
        ref: ref,
        refreshable: fetchSupportProvider.future,
        data: (support) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Gap(24.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "what's app number for calling support".tr,
                      style: AppFont.font18W700Black,
                    ),
                  ],
                ),
                Gap(16.h),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 56,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(52),
                          border: Border.all(),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Center(
                            child: Text(
                              support.phoneNumber,
                              textDirection: TextDirection.ltr,
                              style: AppFont.font16W500Black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Gap(10.w),
                    CircleAvatarButton(
                      radius: 30,
                      icon: Icons.save,
                      backgroundColor: AppColor.primary3,
                      iconColor: AppColor.white,
                      iconSize: 25,
                    ),
                    Gap(10.w),
                    CircleAvatarButton(
                      radius: 30,
                      isImage: true,
                      imagePath: Assets.base.whatsapp,
                      icon: Icons.watch,
                      backgroundColor: AppColor.green1,
                      iconColor: AppColor.white,
                      iconSize: 30,
                      // onTap: ()=>launchInWhats(support.phoneNumber),
                    ),
                  ],
                ),
                Gap(16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Support email'.tr,
                      style: AppFont.font18W700Black,
                    ),
                  ],
                ),
                Gap(16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        height: 56,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Center(
                            child: Text(
                              support.email,
                              style: AppFont.font16W500Black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Gap(10.w),
                    CircleAvatarButton(
                      radius: 30,
                      icon: Icons.email_outlined,
                      backgroundColor: AppColor.primary3,
                      iconColor: AppColor.white,
                      iconSize: 25,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
