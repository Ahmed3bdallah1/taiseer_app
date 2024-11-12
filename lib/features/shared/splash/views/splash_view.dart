import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:taiseer/config/app_font.dart';
import 'package:taiseer/features/shared/auth/presentation/view/login_page.dart';
import 'package:taiseer/features/shared/onboarding/view/onboard_screen.dart';
import 'package:taiseer/ui/shared_widgets/error_widget.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../ui/shared_widgets/logo_widget.dart';
import '../../onboarding/view/get_started_screen.dart';
import '../../../user_features/root/view/root_view.dart';

import '../controllers/splash_controller.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    responsiveInit(context);
    final provider = ref.watch(splashProvider);
    ref.listen(splashProvider, (previous, next) {
      if (previous?.hasValue == false && next.hasValue) {
        switch (next.value!) {
          case SplashNavigate.home:
            Get.offAll(() => const RootView());
            break;
          case SplashNavigate.getStarted:
            Get.offAll(() => const GetStartedScreen());
            break;
          case SplashNavigate.boarding:
            Get.offAll(() => const OnboardScreen());
            break;
          case SplashNavigate.login:
            Get.offAll(() => const LoginPage());
            break;
        }
      }
    });
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // backgroundColor: Colors.blue,
      floatingActionButton: Consumer(
        builder: (context, ref, child) {
          final isUpdateAvailable = ref.watch(isUpdateAvailableProvider);
          if (isUpdateAvailable) {
            return Text(
              "${"Loading some updates".tr} ...",
              style: AppFont.font16W600Gray2,
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
      body: provider.customWhen(
          refreshable: splashProvider.future,
          ref: ref,
          data: (data) {
            return Center(
              child: ScaleTransition(
                scale: _animation,
                child: const LogoWidget(),
              ),
            );
          },
          error: (o, b) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const LogoWidget(),
                CustomErrorWidget(
                  object: o,
                  stackTrace: b,
                  onRetry: () {
                    return ref.refresh(splashProvider.future);
                  },
                ),
              ],
            );
          },
          loading: () => Center(
                child: ScaleTransition(
                  scale: _animation,
                  child: const LogoWidget(),
                ),
              )),
    );
  }
}
