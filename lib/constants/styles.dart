import 'package:flutter/material.dart';

class Styles {
//Theme
  static ThemeData themeData = ThemeData(
    fontFamily: 'Montserrat',
    brightness: Brightness.light,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    iconTheme: const IconThemeData(
      color: Color.fromARGB(255, 124, 25, 163),
    ),
    appBarTheme:
        const AppBarTheme(iconTheme: IconThemeData(color: Colors.deepPurple)),
    colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: Color.fromARGB(255, 124, 25, 163),
        onPrimary: Colors.black,
        secondary: Color.fromARGB(255, 124, 25, 163),
        onSecondary: Colors.black,
        error: Colors.red,
        onError: Colors.black,
        background: Colors.white,
        onBackground: Colors.black,
        surface: Colors.white,
        onSurface: Colors.black87),
  );

//TextStyles

  static TextStyle heading1 = const TextStyle(
    fontSize: 50,
    fontWeight: FontWeight.w900,
    fontFamily: 'Montserrat',
    color: Colors.black,
  );
  static TextStyle heading2 = const TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.w800,
    fontFamily: 'Montserrat',
    color: Colors.black,
  );
  static TextStyle heading3 = const TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w700,
    fontFamily: 'Montserrat',
    color: Colors.black,
  );
  static TextStyle heading4 = const TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.w600,
    fontFamily: 'Montserrat',
    color: Colors.black,
  );
  static TextStyle heading5 = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    fontFamily: 'Montserrat',
    color: Colors.black,
  );
  static TextStyle heading6 = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    fontFamily: 'Montserrat',
    color: Colors.black,
  );
  static TextStyle body1 = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w300,
    fontFamily: 'Montserrat',
    color: Colors.black,
  );
  static TextStyle body2 = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w300,
    fontFamily: 'Montserrat',
    color: Colors.black,
  );
}
