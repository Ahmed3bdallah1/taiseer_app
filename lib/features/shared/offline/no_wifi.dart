import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:taiseer/config/app_font.dart';
import 'package:taiseer/features/shared/offline/widgets/reload_button.dart';
import 'package:lottie/lottie.dart';

import '../splash/controllers/splash_controller.dart';

class NoWifi extends ConsumerWidget {
  const NoWifi({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    responsiveInit(context);
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                "assets/base/no_wifi.json",
                height: 0.5.sh,
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "no internet".tr,
                style: AppFont.font20W600Black,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10.h,
              ),
              ReloadButton(
                size: 30,
                onTap: () {
                  if (ref.read(hasInternetProvider).hasValue &&
                      ref.read(hasInternetProvider).value == false) {
                    ref.invalidate(hasInternetProvider);
                  }
                  ref.invalidate(hasInternetProvider2);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
