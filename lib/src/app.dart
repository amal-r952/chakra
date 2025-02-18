import 'package:chakra/src/screens/splash_page.dart';
import 'package:chakra/src/theme/app_theme/app_theme_data.dart';
import 'package:chakra/src/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: AppColors.bottomNavigationBg,
      ),
    );
    return MaterialApp(
      title: 'Chakra App',
      darkTheme: AppThemeData.darkTheme,
      debugShowCheckedModeBanner: false,
      theme: AppThemeData.lightTheme,
      themeMode: ThemeMode.light,
      home: SplashPage(),
    );
  }
}
