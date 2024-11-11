import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:learning/features/shared/auth/presentation/view/register_page.dart';
import 'package:learning/features/shared/verify/data/repositories/forget_verify_repo_impl.dart';

import '../../../../../config/app_font.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../ui/shared_widgets/custom_app_bar.dart';
import '../../../../../ui/shared_widgets/custom_filled_button.dart';
import '../../../../../ui/shared_widgets/custom_otp.dart';
import '../../../../../ui/shared_widgets/custom_outlined_button.dart';
import '../../../../../ui/shared_widgets/loading_widget.dart';
import '../../../../../ui/ui.dart';
import '../../../verify/domain/repositories/verification_repo.dart';
import '../../../verify/presentation/manager/verify_provider.dart';
import '../../../verify/presentation/pages/verify_view.dart';
import '../manager/auth_provuder.dart';

class OtpScreen extends ConsumerWidget {
  const OtpScreen({
    required this.repo,
    super.key,
  });

  final VerificationRepo repo;

  @override
  Widget build(BuildContext context, ref) {
    responsiveInit(context);
    final stateProvider = ref.watch(verifyProvider(repo));
    final notifier = ref.watch(verifyProvider(repo).notifier);
    ref.listen(verifyProvider(repo), (previous, next) {
      if (next is ErrorState) {
        UIHelper.showSnackBar(next.message, context);
      } else if (next is CloseState) {
        Future showAlertThenBack() async {
          if (next.message != null) {
            await UIHelper.showAlert(
              next.message!,
              context: context,
              type: next.isSuccess! ? DialogType.success : DialogType.error,
            );
          }
          Get.back();
        }

        showAlertThenBack();
      }
    });
    return Scaffold(
      appBar: CustomAppBar(
        title: "",
        customTitleWidget: SvgPicture.asset(
          Assets.base.logo.path,
          width: 250.h,
        ),
      ),
      body: stateProvider is LoadingState && stateProvider.key == "all" ||
              stateProvider is CloseState
          ? const LoadingWidget()
          : SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 68),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(48.h),
                    Row(
                      children: [
                        Text(
                          "Check phone number".tr,
                          style: AppFont.font20W700Black,
                        ),
                      ],
                    ),
                    Gap(16.h),
                    Row(
                      children: [
                        Flexible(
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: "we will send you otp message".tr,
                                style: AppFont.font13W400Black),
                            TextSpan(
                                text: "(+965 ${repo.sendTo})",
                                style: AppFont.font13W600Primary),
                          ])),
                        ),
                      ],
                    ),
                    Gap(48.h),
                    CustomOTP(
                        controller: notifier.textController,
                        onChanged: (val) {
                          ref.read(numberProvider.notifier).state = val;
                        }),
                    Gap(48.h),
                    Consumer(
                      builder: (context, ref, child) {
                        final isLoading = ref.watch(authNotifierProvider);
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 26.w),
                          child: CustomFilledButton(
                            text: "Verify".tr,
                            isLoading: isLoading ||
                                (stateProvider is LoadingState &&
                                    stateProvider.key == "verify"),
                            ignorePressOnNotValid: true,
                            onPressed: () async {
                              if (await notifier
                                      .verify(ref.read(numberProvider)!)
                                  is RegisterComplete) {
                                try {
                                  await ref
                                      .read(authNotifierProvider.notifier)
                                      .register((repo as CheckPhoneRepo).data);
                                } catch (e) {
                                  UIHelper.showAlert(e.toString(),
                                      type: DialogType.error);
                                }
                              }
                            },
                            isValid: ref.watch(numberProvider)?.length == 4,
                          ),
                        );
                      },
                    ),
                    Gap(32.h),
                    if (stateProvider is! LoadingState) ...[
                      Gap(16.h),
                      StreamBuilder(
                        stream: notifier.stopWatch.rawTime,
                        builder: (context, snapshot) {
                          final isLoading = notifier.stopWatch.isRunning;

                          return Consumer(
                            builder: (context, ref, child) {
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 26.w),
                                child: CustomOutlinedButton(
                                  text: isLoading
                                      ? "${notifier.stopWatch.secondTime.value}"
                                      : "Resend".tr,
                                  isLoading: stateProvider is LoadingState &&
                                      stateProvider.key == "verify",
                                  ignorePressOnNotValid: true,
                                  onPressed: () {
                                    notifier.resend();
                                  },
                                  isValid: !isLoading,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                    Gap(143.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account? ".tr,
                            style: AppFont.font10w400Black),
                        InkWell(
                          onTap: () => Get.to(const RegisterPage()),
                          child: Text("Create account".tr,
                              style: AppFont.font10w400Primary),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
