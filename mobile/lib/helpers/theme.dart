import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants.dart';

ThemeData getTheme() {
  return ThemeData(
    primaryColor: darkBrown,
    textTheme: TextTheme(
      headline1: TextStyle(
        color: darkBrown,
        fontFamily: GoogleFonts.lacquer().fontFamily,
      ),
      headline2: TextStyle(
        color: darkBrown,
        fontFamily: GoogleFonts.lacquer().fontFamily,
      ),
      headline3: TextStyle(color: Colors.white),
      headline4: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      headline5: TextStyle(
        color: darkBrown,
        fontFamily: GoogleFonts.lacquer().fontFamily,
      ),
      headline6: TextStyle(color: Colors.white),
    ),
    scaffoldBackgroundColor: Color(0xFF2D2F41),
    fontFamily: GoogleFonts.lato().fontFamily,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        // backgroundColor: MaterialStateProperty.all(darkBrown),
        backgroundColor:
            MaterialStateProperty.all(Color.fromRGBO(255, 165, 0, 1)),
        padding: MaterialStateProperty.all<EdgeInsets>(
          const EdgeInsets.fromLTRB(55, 15, 55, 15),
        ),
        shape: MaterialStateProperty.all(
          StadiumBorder(),
        ),
        textStyle: MaterialStateProperty.all(
          TextStyle(letterSpacing: 2),
        ),
      ),
    ),
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: Colors.white),
      color: Colors.transparent,
      elevation: 0.0,
      centerTitle: true,
      textTheme: TextTheme(
        headline6: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    ),
  );
}
