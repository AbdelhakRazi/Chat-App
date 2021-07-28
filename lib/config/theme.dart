import 'package:chat_app/config/colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData defaultTheme = ThemeData(
      appBarTheme: AppBarTheme(color: Colors.transparent, elevation: 0),
      scaffoldBackgroundColor: AppColors.backgrd,
      fontFamily: "Raleway",
      textTheme: TextTheme(
          headline1: TextStyle(fontSize: 40, color: AppColors.white),
          bodyText1: TextStyle(fontSize: 14, color: AppColors.grey),
          bodyText2: TextStyle(fontSize: 16, color: AppColors.white),
          headline2: TextStyle(fontSize: 20, color: AppColors.backgrd)),
      buttonTheme: ButtonThemeData(
        minWidth: double.infinity,
        buttonColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(38),
        ),
      ),
      iconTheme: IconThemeData(color: Colors.grey, size: 30),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(fontSize: 14, color: AppColors.grey),
        filled: true,
        fillColor: AppColors.field,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(38),
            borderSide: BorderSide(
              color: AppColors.white,
            )),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(38),
            borderSide: BorderSide(
              color: AppColors.red,
            )),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(38),
            borderSide: BorderSide(
              color: AppColors.red,
            )),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(38),
          borderSide: BorderSide(color: AppColors.white, width: 2),
        ),
      ));
}
