import 'package:flutter/material.dart';
import 'package:taiseer/core/service/localization_service/localization_service.dart';
import '../../config/app_font.dart';
import '../../features/user_features/profile/presentation/view/widgets/select_language_dialog.dart';

class SelectLanguageTile extends StatelessWidget {
  const SelectLanguageTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            builder: (context) {
              return const SelectLanguageDialog();
            });
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: AppColor.primary,
            ),
            borderRadius: BorderRadius.circular(6.r)),
        padding: const EdgeInsets.all(8),
        child: Text(
          localeService.isArabic ? "العربية" : "English",
          style: AppFont.font14W600Primary,
        ),
      ),
    );
  }
}
