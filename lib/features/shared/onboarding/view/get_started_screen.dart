import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:taiseer/features/shared/auth/presentation/view/login_page.dart';
import 'package:taiseer/features/shared/auth/presentation/view/register_page.dart';
import 'package:taiseer/features/shared/onboarding/view/onboard_screen.dart';
import 'package:taiseer/ui/shared_widgets/custom_filled_button.dart';
import 'package:taiseer/ui/shared_widgets/custom_outlined_button.dart';
import 'package:taiseer/ui/shared_widgets/image_or_svg.dart';

import '../../../../core/enum/language.dart';
import '../../../../core/service/localization_service/localization_service.dart';
import '../../../../gen/assets.gen.dart';

final changeLanguageProvider =
    StateProvider.family.autoDispose<bool, int>((ref, _) => false);

class GetStartedScreen extends ConsumerWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        child: Center(
          child: ImageOrSvg(
            Assets.base.tayseerLogo.path,
            isLocal: true,
            height: 100.h,
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: CustomOutlinedButton(
                text: "العربية",
                isLoading: ref.watch(changeLanguageProvider(0)),
                onPressed: () async {
                  ref.read(changeLanguageProvider(0).notifier).state = true;

                  await localeService.changeLocale(
                    Language.values.firstWhere(
                        (element) => element.locale.languageCode == 'ar'),
                  );

                  ref.read(changeLanguageProvider(0).notifier).state = false;

                  if (!ref.watch(changeLanguageProvider(0))) {
                    Get.offAll(() => const OnboardScreen());
                  }
                },
              ),
            ),
            Gap(10.w),
            Expanded(
              child: CustomFilledButton(
                text: "English",
                isLoading: ref.watch(changeLanguageProvider(1)),
                onPressed: () async {
                  ref.read(changeLanguageProvider(1).notifier).state = true;

                  await localeService.changeLocale(
                    Language.values.firstWhere(
                        (element) => element.locale.languageCode == 'en'),
                  );

                  ref.read(changeLanguageProvider(1).notifier).state = false;

                  if (!ref.watch(changeLanguageProvider(1))) {
                    Get.offAll(() => const OnboardScreen());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
