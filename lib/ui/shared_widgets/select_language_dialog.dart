import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:learning/config/app_font.dart';
import 'package:learning/core/enum/language.dart';
import 'package:learning/core/service/localization_service/localization_service.dart';

final selectLanguageProvider = StateProvider.autoDispose<Language>((ref) {
  return localeService.getLocale();
});

class SelectLanguageDialog extends ConsumerWidget {
  const SelectLanguageDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final currentLang = ref.read(selectLanguageProvider);
    responsiveInit(context);
    return Container(
      height: 200.0.h,
      decoration: BoxDecoration(
        color: AppColor.nearlyWhite,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: CupertinoPicker(
          scrollController: FixedExtentScrollController(
            initialItem: currentLang.index,
          ),
          itemExtent: 60,
          onSelectedItemChanged: (value) {
            localeService.changeLocale(Language.values
                .firstWhere((element) => element.index == value));
          },
          children: Language.values
              .map((e) => Container(
                    alignment: Alignment.center,
                    height: 50,
                    child: Text(
                      e.name.tr,
                      style: AppFont.font15W700Black,
                    ),
                  ))
              .toList()),
    );
  }
}
