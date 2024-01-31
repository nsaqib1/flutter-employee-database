import 'package:flutter/material.dart';

abstract class DefaultTheme {
  static final data = ThemeData.light().copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: Colors.blue,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          shadowColor: Colors.blue,
          surfaceTintColor: Colors.blue,
          foregroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          elevation: 1,
        ),
      ));
}
