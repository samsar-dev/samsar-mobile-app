import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samsar/controllers/auth/auth_controller.dart';
import 'package:samsar/controllers/features/theme_controller.dart';
import 'package:samsar/controllers/features/language_controller.dart';
import 'package:samsar/translations/app_translations.dart';
import 'package:samsar/views/spalsh_screen/splash_screen_view.dart';


void main() {
  print('🚀 main() function started');
  
  // Initialize controllers with permanent flag to prevent reset
  print('🔧 Initializing AuthController...');
  Get.put(AuthController(), permanent: true);
  
  print('🌍 Initializing LanguageController...');
  final languageController = Get.put(LanguageController(), permanent: true);
  print('✅ LanguageController initialized: ${languageController.runtimeType}');

  print('🏃 Starting MyApp...');
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ThemeController _themeController = Get.put(ThemeController());
  final LanguageController _languageController = Get.find<LanguageController>();

  @override
  Widget build(BuildContext context) {
    print('🎨 MyApp.build() called');
    return Obx(
      () {
        print('🔄 Obx rebuilding MyApp...');
        print('🌍 Current locale: ${_languageController.currentLocale}');
        print('📱 Current language: ${_languageController.currentLanguage}');
        print('➡️ Is RTL: ${_languageController.isRTL}');
        
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: _themeController.theme,
          // Language and localization support
          translations: AppTranslations(),
          locale: _languageController.currentLocale,
          fallbackLocale: const Locale('en', 'US'),
          // RTL support
          builder: (context, child) {
            print('🏠 App builder called with locale: ${_languageController.currentLocale}');
            return Directionality(
              textDirection: _languageController.isRTL 
                  ? TextDirection.rtl 
                  : TextDirection.ltr,
              child: child!,
            );
          },
          home: SplashScreenView()
        );
      }
    );
  }
}