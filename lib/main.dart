import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samsar/controllers/auth/auth_controller.dart';
import 'package:samsar/controllers/features/theme_controller.dart';
import 'package:samsar/views/spalsh_screen/splash_screen_view.dart';


void main() {

  Get.put(AuthController(), permanent: true);

  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ThemeController _themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: _themeController.theme,
          home: SplashScreenView()
        );
      }
    );
  }
}