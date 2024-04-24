import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  colorScheme: const ColorScheme.dark(
    background: Color.fromRGBO(15, 15, 15, 1),
    primary: Color.fromRGBO(27, 27, 27, 1),
    inversePrimary: Color.fromRGBO(255, 255, 255, 1),
    secondary: Color.fromRGBO(245, 92, 61, 1),
  ),
);

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.dark(
    background: Colors.grey.shade800,
    primary: Color.fromRGBO(27, 27, 27, 1),
    inversePrimary: Color.fromRGBO(255, 255, 255, 1),
    secondary: Color.fromRGBO(245, 92, 61, 1),
  ),
);
