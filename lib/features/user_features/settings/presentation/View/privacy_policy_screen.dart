import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:taiseer/ui/shared_widgets/custom_logo_app_bar.dart';
import '../../../../../config/app_color.dart';
import '../../../../../ui/shared_widgets/custom_filled_button.dart';
import '../manager/fetch_policy_provider.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: CustomLogoAppbar(
        customTitleWidget: Text('Privacy Policy'.tr),
        hideActions: true,
      ),
      body: Consumer(
        builder: (context, ref, _) {
          final terms = ref.watch(fetchPolicyProvider);
          return terms.customWhen(
            refreshable: fetchPolicyProvider.future,
            ref: ref,
            data: (termsData) {
              return SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: HtmlWidget(
                    termsData.termsAr ?? "",
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomSheet: Container(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomFilledButton(
            text: "Ok".tr,
            fontColor: Colors.white,
            color: AppColor.primary,
            onPressed: () => Get.back(),
          ),
        ),
      ),
    );
  }
}

class WhoAreWeScreen extends StatelessWidget {
  const WhoAreWeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: CustomLogoAppbar(
        customTitleWidget: Text('Who Are We'.tr),
        hideActions: true,
      ),
      body: Consumer(
        builder: (context, ref, _) {
          final terms = ref.watch(fetchWhoAreWeProvider);
          return terms.customWhen(
            refreshable: fetchWhoAreWeProvider.future,
            ref: ref,
            data: (termsData) {
              return SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: HtmlWidget(
                    termsData.termsAr ?? "",
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomSheet: Container(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomFilledButton(
            text: "Ok".tr,
            fontColor: Colors.white,
            color: AppColor.primary,
            onPressed: () => Get.back(),
          ),
        ),
      ),
    );
  }
}
