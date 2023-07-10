import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blukers_client_app/localization/language/arabic.dart';
import 'package:blukers_client_app/localization/language/english.dart';
import 'package:blukers_client_app/localization/language/hindi.dart';
import 'package:blukers_client_app/localization/language/spanish.dart';

class LocalizationService extends Translations {
  // static const locale = Locale('en', 'US');
  static const locale = Locale('es', 'ES');

  static const fallbackLocale = Locale('tr', 'TR');

  static final language = ["English", "Spanish", "hindi", "arabic"];

  static final locales = [
    const Locale('en', 'US'),
    const Locale('es', "ES"),
    const Locale('hi', "HI"),
    const Locale('ar', 'AE')
  ];

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': english,
        'es_ES': spanish,
        'hi_HI': hindi,
        'ar_AE': arabic,
      };

  void changeLocale(String lang) {
    final locale = _getLocaleFromLanguage(lang);
    Get.updateLocale(locale!);
  }

  Locale? _getLocaleFromLanguage(String lang) {
    for (int i = 0; i < language.length; i++) {
      debugPrint("You selected : ${language[i]}");
      if (lang == language[i]) return locales[i];
    }
    return Get.locale;
  }
}
