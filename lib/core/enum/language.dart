import 'dart:ui';

enum Language {
  arabic(Locale('ar', 'US')),
  english(Locale('en', 'US'));

  final Locale locale;

  const Language(this.locale);
}
