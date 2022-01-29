

import 'package:flutter/material.dart';
import 'package:todowithgetx/Shared/Colors%20and%20Icons/colors_icons.dart';

ThemeData darkTheme = ThemeData(
  backgroundColor: Colors.black,
  primaryColor: Colors.redAccent,
  appBarTheme: AppBarTheme(
      backgroundColor: ColorApp.blackColor,
    titleTextStyle: TextStyle(
      color: ColorApp.whiteColor,
      fontSize: 20
    )
  ),
  brightness: Brightness.dark,

);

ThemeData lightTheme = ThemeData(
    backgroundColor: Colors.black,
    primaryColor: Colors.orangeAccent,
    appBarTheme: AppBarTheme(
      backgroundColor: ColorApp.blackColor.withOpacity(0.8),
    ),
    brightness: Brightness.light,
);

