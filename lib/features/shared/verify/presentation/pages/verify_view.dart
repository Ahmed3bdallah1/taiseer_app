import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:taiseer/config/app_font.dart';
import 'package:taiseer/ui/shared_widgets/custom_otp.dart';
import 'package:taiseer/ui/shared_widgets/custom_outlined_button.dart';
import 'package:taiseer/ui/shared_widgets/loading_widget.dart';
import 'package:taiseer/ui/ui.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../main.dart';
import '../../../../../ui/shared_widgets/container_button.dart';
import '../../../../../ui/shared_widgets/custom_app_bar.dart';
import '../../../../../ui/shared_widgets/custom_filled_button.dart';
import '../../../../../ui/shared_widgets/custom_logo_app_bar.dart';
import '../../../../../ui/shared_widgets/image_or_svg.dart';
import '../../../../../ui/shared_widgets/select_language_tile.dart';
import '../../../forget_password/domain/repositories/forget_password_repo.dart';
import '../../../forget_password/presentation/pages/reset_password_view.dart';
import '../../domain/repositories/verification_repo.dart';
import '../manager/verify_provider.dart';

final numberProvider = StateProvider.autoDispose<String?>((ref) {
  return null;
});

class VerifyView extends ConsumerWidget {
  const VerifyView({
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
      } else if (next is NewPasswordState) {
        Get.off(() => ResetPasswordView(
            getIt<ForgetPasswordRepo>(param1: next.code, param2: next.sendTo)));
      }
    });
    return Scaffold(
        appBar: CustomLogoAppbar(
          customTitleWidget: ImageOrSvg(
            Assets.base.tayseerLogo.path,
            isLocal: true,
            height: 65.h,
          ),
          isCenterTitle: false,
          hideBackButton: true,
          buttonWidget: const Padding(
            padding: EdgeInsets.only(bottom: 18, top: 2),
            child: SelectLanguageTile(),
          ),
        ),
        body: stateProvider is LoadingState && stateProvider.key == "all" ||
                stateProvider is CloseState
            ? const LoadingWidget()
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Gap(28.h),
                    Row(
                      children: [
                        ContainerButton(
                          size: 40,
                          onTap: () => Get.back(),
                          icon: Icons.arrow_back,
                          color: Colors.transparent,
                        ),
                        Gap(8.w),
                        Text(
                          "Check phone number".tr,
                          style: AppFont.font20W700Black,
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 20.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Verification code".tr,style: AppFont.font13W400Black,),
                          Gap(6.h),
                          CustomOTP(
                              controller: notifier.textController,
                              onChanged: (val) {
                                ref.read(numberProvider.notifier).state = val;
                              }),
                        ],
                      ),
                    ),
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
                    Gap(24.h),
                    Consumer(
                      builder: (context, ref, child) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 26.w),
                          child: CustomFilledButton(
                            text: "Verify".tr,
                            isLoading: stateProvider is LoadingState &&
                                stateProvider.key == "verify",
                            ignorePressOnNotValid: true,
                            onPressed: () {
                              notifier.verify(ref.read(numberProvider)!);
                            },
                            isValid: ref.watch(numberProvider)?.length == 4,
                          ),
                        );
                      },
                    ),
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
                  ],
                ),
              ));
  }
}
