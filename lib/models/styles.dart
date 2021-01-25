import 'dart:ui';

import 'package:flutter/material.dart';

///[Styles] is a class that is used to manage app themeData based on either app's on
///Light Theme or Dark Theme
class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      primarySwatch: Colors.orange,
      primaryColor: isDarkTheme ? Colors.black : Colors.orange,
      accentColor: isDarkTheme ? Colors.black : Colors.orange,
      splashColor: Colors.grey.withOpacity(0.1),
      canvasColor: isDarkTheme ? Colors.grey[900] : Colors.orange[50],
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      fontFamily: 'Play',
      accentColorBrightness: isDarkTheme ? Brightness.light : Brightness.dark,
      buttonTheme: isDarkTheme
          ? ButtonTheme.of(context).copyWith(
              buttonColor: Colors.black,
              textTheme: ButtonTextTheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            )
          : ButtonTheme.of(context).copyWith(
              buttonColor: Colors.orange,
              textTheme: ButtonTextTheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
      textTheme: isDarkTheme
          ? ThemeData.dark().textTheme.copyWith(
                bodyText2: TextStyle(
                  color: Colors.white,
                ),
                bodyText1: TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                ),
                headline1: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Play',
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
                headline6: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontFamily: 'Play',
                  fontWeight: FontWeight.bold,
                ),
                headline5: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Play',
                  fontWeight: FontWeight.w600,
                ),
              )
          : ThemeData.light().textTheme.copyWith(
                bodyText2: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Play',
                ),
                bodyText1: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Play',
                ),
                headline1: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Play',
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
                headline6: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Play',
                  fontWeight: FontWeight.bold,
                ),
                headline5: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Play',
                  fontWeight: FontWeight.w600,
                ),
              ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}
