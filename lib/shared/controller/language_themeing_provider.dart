import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppProvider extends ChangeNotifier {
  String languageCode = 'en';
  ThemeMode appTheme = ThemeMode.light;
  SharedPreferences? prefs;

  void changeLanguage(String language) {
    languageCode = language;
    saveLanguage(language);
    notifyListeners();
  }

  void changeTheme(ThemeMode newTheme) {
    appTheme = newTheme;
    savingTheme(newTheme);
    notifyListeners();
  }

  void savingTheme(ThemeMode themeMode) async {
    String theme = themeMode == ThemeMode.dark ? 'dark' : 'light';
    await prefs!.setString('theme', theme);
  }

  String? getTheme() {
    return prefs!.getString('theme');
  }

  Future<void> cashTheme() async {
    prefs = await SharedPreferences.getInstance();
    String? oldTheme = getTheme();
    if (oldTheme != null) {
      appTheme = oldTheme == 'dark' ? ThemeMode.dark : ThemeMode.light;
    }
  }

  Future<void> saveLanguage(String lang) async {
    String language = lang == 'en' ? 'en' : 'ar';
    await prefs!.setString('language', language);
  }

  Future<void> cashLanguage() async {
    prefs = await SharedPreferences.getInstance();
    String? oldLanguage = getLanguage();
    if (oldLanguage != null) {
      languageCode = oldLanguage == 'en' ? 'en' : 'ar';
    }
  }

  String? getLanguage() {
    return prefs!.getString('language');
  }
}
