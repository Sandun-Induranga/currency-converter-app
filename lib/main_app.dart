import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'config/theme/app_theme.dart';
import 'features/convertor/bloc/convertor_provider.dart';
import 'features/convertor/presentation/screens/convertor_view.dart';

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
            ConvertorProvider(),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: child!,
            theme: AppThemeData.lightThemeData(),
            darkTheme: AppThemeData.darkThemeData(),
          ),
        );
      },
      child: const ConvertorView(),
    );
  }
}
