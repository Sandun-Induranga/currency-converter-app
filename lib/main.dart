import 'package:currency_converter_app/main_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  Future.wait([
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]),
  ]).then((value) async {
    await Future.delayed(const Duration(seconds: 2));
    runApp(
      const MainApp(),
    );
  });
}
