import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'LSColors.dart';

class AppThemeData {
  //
  AppThemeData._();

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: LSColorPrimary,
    primaryColorDark: LSColorPrimary,
    errorColor: Colors.red,
    hoverColor: Colors.white54,
    dividerColor: Colors.grey[200],
    fontFamily: GoogleFonts.openSans().fontFamily,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: Colors.white,
      iconTheme: IconThemeData(color: Colors.blue),
      systemOverlayStyle: SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
    ),
    textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.black),
    colorScheme: ColorScheme.light(primary: LSColorPrimary, primaryVariant: LSColorPrimary),
    cardTheme: CardTheme(color: Colors.white),
    cardColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.blue),
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.white),
    textTheme: TextTheme(
      button: TextStyle(color: LSColorPrimary),
      headline6: TextStyle(color: Colors.blue[50]),
      subtitle2: TextStyle(color: Colors.blue),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  ).copyWith(
    pageTransitionsTheme: PageTransitionsTheme(builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.linux: OpenUpwardsPageTransitionsBuilder(),
      TargetPlatform.macOS: OpenUpwardsPageTransitionsBuilder(),
    }),
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: appBackgroundColorDark,
    highlightColor: appBackgroundColorDark,
    errorColor: Color(0xFFCF6676),
    appBarTheme: AppBarTheme(
      color: appBackgroundColorDark,
      iconTheme: IconThemeData(color: Colors.black),
      systemOverlayStyle: SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
    ),
    primaryColor: color_primary_black,
    dividerColor: Color(0xFFDADADA).withOpacity(0.3),
    primaryColorDark: color_primary_black,
    textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.white),
    hoverColor: Colors.black12,
    fontFamily: GoogleFonts.openSans().fontFamily,
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: appBackgroundColorDark),
    //primaryTextTheme: TextTheme(headline6: text(color: Colors.white), overline: primaryTextStyle(color: Colors.white)),
    cardTheme: CardTheme(color: cardBackgroundBlackDark),
    cardColor: appSecondaryBackgroundColor,
    iconTheme: IconThemeData(color: Colors.white),
    textTheme: TextTheme(
      button: TextStyle(color: color_primary_black),
      headline6: TextStyle(color: Colors.white),
      subtitle2: TextStyle(color: Colors.white54),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    colorScheme: ColorScheme.dark(primary: appBackgroundColorDark, onPrimary: cardBackgroundBlackDark, primaryVariant: color_primary_black).copyWith(secondary: Colors.white),
  ).copyWith(
    pageTransitionsTheme: PageTransitionsTheme(builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.linux: OpenUpwardsPageTransitionsBuilder(),
      TargetPlatform.macOS: OpenUpwardsPageTransitionsBuilder(),
    }),
  );
}
