import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';

final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  return LocaleNotifier();
});

class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier() : super(const Locale('es')) {
    _loadSavedLocale();
  }

  static const String _localeKey = 'locale';

  Future<void> _loadSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final String? languageCode = prefs.getString(_localeKey);
    if (languageCode != null) {
      state = Locale(languageCode);
    }
  }

  Future<void> setLocale(String languageCode, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_localeKey, languageCode);

    final newLocale = Locale(languageCode);
    state = newLocale;

    // Cambiar el idioma en easy_localization
    if (context.mounted) {
      await context.setLocale(newLocale);
    }
  }

  // Método para obtener el código de idioma actual
  String get currentLanguageCode => state.languageCode;

  // Método para obtener el nombre del idioma actual
  String get currentLanguageName {
    switch (state.languageCode) {
      case 'es':
        return 'Español';
      case 'en':
        return 'English';
      case 'fr':
        return 'Français';
      default:
        return 'Español';
    }
  }
}
