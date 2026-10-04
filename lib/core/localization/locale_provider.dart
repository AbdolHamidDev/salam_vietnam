import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// StateNotifier for switching app locale dynamically.
class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier() : super(const Locale('vi'));

  void setLocale(Locale locale) {
    if (['vi', 'en', 'ms'].contains(locale.languageCode)) {
      state = locale;
    }
  }

  void setLanguageCode(String code) {
    setLocale(Locale(code));
  }
}

final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  return LocaleNotifier();
});
