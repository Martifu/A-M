//themedata for the app
import 'package:flutter/material.dart';

TextStyle customTextStyle = const TextStyle(
  fontFamily: 'visby',
  fontSize: 16,
  fontWeight: FontWeight.normal,
  // Otros atributos de estilo que desees configurar
);

const Color primaryColor = Color(0xff12043E);
const Color secondaryColor = Color(0xff410ED3);
const Color pinkColor = Color(0xffD24F6B);
const Color backgroundColor = Color(0xffF2EDE6);

ThemeData appTheme() {
  return ThemeData(
    scaffoldBackgroundColor: const Color(0xffF2EDE6),

    primaryColor: const Color(0xff12043E),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 72.0,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: TextStyle(
        fontSize: 36.0,
        fontStyle: FontStyle.italic,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.0,
        fontFamily: 'visby',
        color: Color(0xff12043E),
      ),
    ),
    //scaffold background color

    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: Colors.blueAccent,
      background: const Color(0xffF2EDE6),
    ),
  );
}
