import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_ui_api_task/utils/design_colors.dart';

var darkTheme = ThemeData();
var theme = ThemeData(
  fontFamily: GoogleFonts.montserrat().fontFamily,
  brightness: Brightness.light,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.black),
    elevation: 0,
  ),
  scaffoldBackgroundColor: DesignColor.backgroundColor,
);
