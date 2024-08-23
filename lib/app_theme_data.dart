import 'package:flutter/material.dart';
import 'package:todo2_app/app_colors.dart';

class AppThemeData {
  static ThemeData lightTheme = ThemeData(
    fontFamily: 'Poppins',
    scaffoldBackgroundColor: AppColors.secondryColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primaryColor,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.w700,
        fontFamily: 'Poppins',
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      elevation: 0,
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: AppColors.grey,
      showUnselectedLabels: false,
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      color: Colors.white,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: const BorderSide(
          color: Colors.white,
          width: 3,
        ),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    fontFamily: 'Poppins',
    scaffoldBackgroundColor: AppColors.secondaryDarkColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primaryColor,
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
      titleTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 22,
        fontWeight: FontWeight.w700,
        fontFamily: 'Poppins',
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      elevation: 0,
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: AppColors.grey,
      showUnselectedLabels: false,
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      color: AppColors.primaryDarkColor,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: BorderSide(
          color: AppColors.primaryDarkColor,
          width: 3,
        ),
      ),
    ),
  );
}
