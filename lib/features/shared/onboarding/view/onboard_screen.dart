import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:taiseer/config/app_color.dart';
import 'package:taiseer/core/service/local_data_manager.dart';
import 'package:taiseer/features/shared/onboarding/controller/onboarding_controller.dart';
import 'package:taiseer/features/shared/onboarding/view/get_started_screen.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:taiseer/ui/shared_widgets/custom_filled_button.dart';
import 'package:taiseer/ui/shared_widgets/custom_outlined_button.dart';
import 'package:taiseer/ui/shared_widgets/fade_in_animation.dart';
import 'package:taiseer/ui/shared_widgets/image_or_svg.dart';

import '../../auth/presentation/view/login_page.dart';

class OnboardScreen extends ConsumerStatefulWidget {
  const OnboardScreen({super.key});

  @override
  ConsumerState<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends ConsumerState<OnboardScreen>
    with TickerProviderStateMixin {
  final PageController controller = PageController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    responsiveInit(context);
    final provider = ref.watch(onboardListProvider);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Positioned(
                top: -195.h,
                left: -120.w,
                right: -120.w,
                child: CircleAvatar(
                  radius: 290.r,
                  backgroundColor: AppColor.grey1.withOpacity(.6),
                )),
            PageView(
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              controller: controller,
              children: [
                ...provider.mapWithIndex((e, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ImageOrSvg(
                            e.image ?? "",
                            isLocal: true,
                            height: 80.h,
                          )),
                      Gap(10.h),
                      DotsIndicator(
                        dotsCount: provider.length,
                        position: index,
                        decorator: DotsDecorator(
                          size: const Size.square(9.0),
                          activeSize: const Size(18.0, 9.0),
                          activeShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 20),
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Text(e.title!,
                      //           textAlign: TextAlign.start,
                      //           style: const TextStyle(
                      //               fontWeight: FontWeight.w500, fontSize: 30)),
                      //       Text(e.subTitle!,
                      //           style: const TextStyle(
                      //               fontWeight: FontWeight.w500, fontSize: 14)),
                      //     ],
                      //   ),
                      // ),
                    ],
                  );
                })
              ],
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: currentIndex == 2
                    ? Column(
                        children: [
                          FadeInAnimation(
                            delay: 1.5,
                            direction: FadeInDirection.topToBottom,
                            fadeOffset: 40,
                            child: CustomFilledButton(
                              text: "let's get start".tr,
                              onPressed: () {
                                dataManager.setSecondTime();
                                Get.offAll(() => const LoginPage());
                              },
                            ),
                          ),
                          Gap(10.h),
                          FadeInAnimation(
                            delay: 1.5,
                            direction: FadeInDirection.bottomToTop,
                            fadeOffset: 40,
                            child: CustomOutlinedButton(
                              text: "Continue as guest".tr,
                              onPressed: () {
                                // Get.to(const GetStartedScreen());
                              },
                            ),
                          ),
                        ],
                      )
                    : FadeInAnimation(
                        delay: 1.5,
                        direction: FadeInDirection.bottomToTop,
                        fadeOffset: 40,
                        child: Row(
                          children: [
                            Expanded(
                                flex: 3,
                                child: CustomFilledButton(
                                  text: "next".tr,
                                  color: AppColor.primary,
                                  onPressed: () {
                                    controller.jumpToPage(
                                        controller.page!.toInt() + 1);
                                    setState(() {});
                                  },
                                )),
                            Gap(10.w),
                            Expanded(
                              flex: 1,
                              child: CustomOutlinedButton(
                                text: "Skip".tr,
                                onPressed: () {
                                  controller.jumpToPage(2);
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        ),
                      ))
          ],
        ),
      ),
    );
    // return OnBoardingSlider(
    //   indicatorAbove: true,
    //   headerBackgroundColor: Colors.transparent,
    //   finishButtonText: 'التالى',
    //   finishButtonStyle: const FinishButtonStyle(
    //     backgroundColor: Colors.indigo,
    //   ),
    //   skipTextButton: const Text("تخطى"),
    //   background: [
    //     ...provider.map((e) {
    //       return SizedBox(
    //           width: MediaQuery.of(context).size.width,
    //           child: Image.asset(e.image ?? ""));
    //     })
    //   ],
    //   onFinish: () {
    //     dataManager.setSecondTime();
    //     Get.off(const GetStartedScreen());
    //   },
    //   totalPage: provider.length,
    //   speed: 1.8,
    //   pageBodies: [
    //     ...provider.map((e) {
    //       return Stack(children: [
    //         Positioned(
    //             top: -80,
    //             left: 0,
    //             right: 0,
    //             child: CircleAvatar(
    //               radius: 120,
    //               backgroundColor: AppColor.grey1.withOpacity(.3),
    //             )),
    //         Padding(
    //           padding: const EdgeInsets.symmetric(horizontal: 20),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               const SizedBox(
    //                 height: 400,
    //               ),
    //               Text(e.title!,
    //                   textAlign: TextAlign.start,
    //                   style: const TextStyle(
    //                       fontWeight: FontWeight.w500, fontSize: 30)),
    //               Text(e.subTitle!,
    //                   style: const TextStyle(
    //                       fontWeight: FontWeight.w500, fontSize: 14)),
    //             ],
    //           ),
    //         ),
    //       ]);
    //     })
    //   ],
    // );
  }
}
