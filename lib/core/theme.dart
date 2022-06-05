import 'package:flutter/material.dart';

class AppColors {
  static const grey = Color.fromARGB(255, 228, 228, 228);
}

final myTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black),
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  scaffoldBackgroundColor: AppColors.grey,
  colorScheme: const ColorScheme.light(
    primary: AppColors.grey,
  ),
);
