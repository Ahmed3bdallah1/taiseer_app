import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taiseer/features/shared/splash/views/splash_view.dart';
import 'package:taiseer/setup_services.dart';
import 'package:taiseer/ui/ui.dart';
import 'package:logger/logger.dart';
import 'config/app_color.dart';
import 'config/app_font.dart';
import 'config/app_string.dart';
import 'config/app_translation.dart';
import 'config/constants.dart';
import 'core/enum/language.dart';
import 'core/service/localization_service/localization_service.dart';
import 'core/service/theme_mode_service.dart';
import 'features/shared/offline/no_wifi.dart';
import 'features/shared/splash/controllers/splash_controller.dart';

final GetIt getIt = GetIt.instance;
bool isCompany= false;

final ProviderContainer providerContainer = ProviderContainer(
  observers: [
    if (kDebugMode && Constants.loggerRiverPod) _Logger(),
  ],
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  // await setupNotification();

  runApp(UncontrolledProviderScope(
    container: providerContainer,
    child: const MyApp(),
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    responsiveInit(context);
    return ScreenUtilInit(
      fontSizeResolver: FontSizeResolvers.height,
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: const Size(375, 812),
      builder: (context, child) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: GetMaterialApp(
            supportedLocales: Language.values.map((e) => e.locale).toList(),
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            translations: Translation(),
            debugShowCheckedModeBanner: false,
            builder: (context, widget) => MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: TextScaler.noScaling),
              child: Consumer(
                  child: widget,
                  builder: (context, ref, child) {
                    final hasConnection = ref.watch(fuckInternetOk);
                    return AnnotatedRegion<SystemUiOverlayStyle>(
                      value: UIHelper.getSystemOverlayStyle(
                          ref.watch(isDarkModeProvider)),
                      child: IndexedStack(
                        index: kDebugMode
                            ? 0
                            : hasConnection
                                ? 0
                                : 1,
                        children: [
                          child!,
                          const NoWifi(),
                        ],
                      ),
                    );
                  }),
            ),
            theme: FlexThemeData.light(
              scaffoldBackground: Colors.white,
              appBarStyle: FlexAppBarStyle.background,
              colors: const FlexSchemeColor(
                primary: AppColor.primary,
                secondary: Colors.white,
              ),
              primaryTextTheme: GoogleFonts.readexProTextTheme(),
              scheme: FlexScheme.greenM3,
              textTheme: GoogleFonts.readexProTextTheme(),
              fontFamily: GoogleFonts.readexPro().fontFamily,
              primary: AppColor.primary,
            ),
            // darkTheme: FlexThemeData.light(
            //   scaffoldBackground: Colors.white,
            //   colors: const FlexSchemeColor(
            //       primary: AppColor.primary, secondary: Color(0xff232323)),
            //   primary: AppColor.primary,
            //   scheme: FlexScheme.greenM3,
            //   appBarStyle: FlexAppBarStyle.scaffoldBackground,
            //   fontFamily: GoogleFonts.readexPro().fontFamily,
            // ),
            title: AppString.appName,
            locale: localeService.handleLocaleInMain,
            themeMode: ThemeMode.light,
            home: const SplashView(),
          ),
        );
      },
    );
  }
}

class _Logger extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    Logger().e(
      '''
{
  "provider": "${provider.name ?? provider.runtimeType}",
  "previousValue": "$previousValue",
  "newValue": "$newValue"
}''',
    );
  }
}
