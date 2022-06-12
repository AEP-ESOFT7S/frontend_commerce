import 'package:flutter/material.dart';
import 'package:verydeli_commerce/app/core/theme/colors.dart';

class Themes {
  Themes._();

  static final light = ThemeData(
    backgroundColor: VeridelyColors.background,
    appBarTheme: const AppBarTheme(elevation: 0, centerTitle: true),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent, width: 0),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.transparent, width: 0),
      ),
      fillColor: const Color(0xFFFFFFFF),
    ),
    primaryColor: const Color(0xFFFFFFFF),
  );

  static final dark = ThemeData(appBarTheme: const AppBarTheme(elevation: 0, centerTitle: true));
}
