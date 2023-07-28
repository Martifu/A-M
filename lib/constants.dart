//themedata for the app
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle customTextStyle = const TextStyle(
  fontFamily: 'visby',
  fontSize: 16,
  fontWeight: FontWeight.normal,
  // Otros atributos de estilo que desees configurar
);

const Color primaryColor = Color(0xff12043E);
const Color secondaryColor = Color.fromARGB(147, 66, 14, 211);
const Color pinkColor = Color(0xffD24F6B);
Color? backgroundColor = Colors.grey[50];

ThemeData appTheme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.grey[50],

    primaryColor: const Color(0xff12043E),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.manjari(
        fontSize: 36.0,
        fontWeight: FontWeight.bold,
        color: const Color(0xff12043E),
      ),
      titleLarge: GoogleFonts.manjari(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        color: const Color(0xff12043E),
      ),
      bodyMedium: GoogleFonts.manjari(
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
        color: const Color(0xff12043E),
      ),
    ),
    //scaffold background color

    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: Colors.blueAccent,
      background: const Color(0xffF2EDE6),
    ),
  );
}

List meses = [
  'Enero',
  'Febrero',
  'Marzo',
  'Abril',
  'Mayo',
  'Junio',
  'Julio',
  'Agosto',
  'Septiembre',
  'Octubre',
  'Noviembre',
  'Diciembre'
];
