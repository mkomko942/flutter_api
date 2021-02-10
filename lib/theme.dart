import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final appThemeData = ThemeData(
    primaryColor: Colors.deepPurple[400],
    accentColor: Colors.blueAccent,
    appBarTheme: AppBarTheme(
        textTheme: GoogleFonts.montserratTextTheme(TextTheme(
            headline6: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16)))),
    brightness: Brightness.dark,
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: Colors.deepPurple[400]),
    scaffoldBackgroundColor: const Color(0xFF222222),
    inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0x337E57C2),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(const Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.white, width: 2)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(const Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.deepPurple[400], width: 2)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(const Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.red, width: 2)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(const Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.red, width: 2)),
        hintStyle: TextStyle(color: Colors.white60),
        counterStyle: TextStyle(color: Colors.white)),
    textTheme: GoogleFonts.montserratTextTheme(TextTheme(
        headline4: TextStyle(
            color: Colors.white, fontWeight: FontWeight.w900, height: 2),
        bodyText2: TextStyle(
            color: Colors.white70, fontWeight: FontWeight.normal, fontSize: 16),
        subtitle1: TextStyle(color: Colors.black87))),
    buttonTheme: ButtonThemeData(
      height: 50,
      padding: EdgeInsets.all(10.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.all(Radius.circular(10.0))),
      textTheme: ButtonTextTheme.normal,
    ));

// final appThemeDataDark = ThemeData(
//   primaryColor: Colors.deepPurple[800],
//   textTheme: TextTheme(bodyText1: TextStyle(color: Colors.white)),
// );
