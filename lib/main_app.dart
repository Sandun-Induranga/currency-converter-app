import 'package:currency_converter_app/features/home/bloc/home_provider.dart';
import 'package:currency_converter_app/features/home/presentation/screens/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'config/theme/app_theme.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );

    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            HomeProvider(),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: child!,
            theme: AppThemeData.lightThemeData(),
            darkTheme: AppThemeData.darkThemeData(),
          ),
        );
      },
      child: HomeView(),
    );
  }
}
