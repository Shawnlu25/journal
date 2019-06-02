import 'package:flutter/material.dart';

const Color darkRuby = const Color(0xFF9A2617);
const Color lily = Colors.white;//const Color(0xFFF5F6F7);
const Color raven = const Color(0xFF373D3F);
const Color asher = const Color(0xFF555F61);

const ColorScheme journalLightColorScheme = ColorScheme(
  primary: lily,
  primaryVariant: raven,
  secondary: raven,
  secondaryVariant: lily,
  surface: lily,
  background: lily,
  error: darkRuby,
  onPrimary: raven,
  onSecondary: lily,
  onSurface: raven,
  onBackground: raven,
  onError: lily,
  brightness: Brightness.light,
);

const IconThemeData journalLightPrimaryIconThemeData = IconThemeData(
  color: asher,
);

const IconThemeData journalLightSecondaryIconThemeData = IconThemeData(
  color: lily,
);

TextTheme _buildJournalTextTheme(TextTheme base) {
  return base
      .copyWith(
    headline: base.headline.copyWith(
      fontWeight: FontWeight.w500,
    ),
    title: base.title.copyWith(fontSize: 18.0),
    caption: base.caption.copyWith(
      fontWeight: FontWeight.w400,
      fontSize: 14.0,
    ),
  )
      .apply(
    fontFamily: 'NotoSansSC',
    displayColor: raven,
    bodyColor: asher,
  );
}

ThemeData journalLightThemeData = ThemeData.light().copyWith(
  brightness: Brightness.light,
  primaryColor: lily,
  primaryColorBrightness: Brightness.light,
  primaryColorLight: lily,
  primaryColorDark: raven,
  canvasColor: lily,
  accentColor: raven,
  accentColorBrightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  bottomAppBarColor: lily,
  cardColor: lily,
  dividerColor: raven,
  //focusColor: null,
  //hoverColor: null,
  highlightColor: Colors.grey[200],
  splashColor: Colors.grey[200],
  //splashFactory: null,
  //selectedRowColor: Colors.grey[500],
  //unselectedWidgetColor: null,
  //disabledColor: null,
  //buttonTheme: null,
  buttonColor: lily,
  //secondaryHeaderColor: null,
  textSelectionColor: Colors.blueGrey[300],
  cursorColor: raven,
  textSelectionHandleColor: Colors.blueGrey[400],
  backgroundColor: lily,
  //dialogBackgroundColor: null,
  //indicatorColor: null,
  hintColor: Colors.grey[400],
  //errorColor: darkRuby,
  //toggleableActiveColor: null,
  textTheme: _buildJournalTextTheme(ThemeData.light().textTheme),
  //primaryTextTheme: null,
  //accentTextTheme: null,
  //inputDecorationTheme: null,
  iconTheme: journalLightPrimaryIconThemeData,
  primaryIconTheme: journalLightPrimaryIconThemeData,
  accentIconTheme: journalLightSecondaryIconThemeData,
  //sliderTheme: null,
  //tabBarTheme: null
  //cardTheme: null,
  //chipTheme: null,
  //platform: TargetPlatform.android,
  //materialTapTargetSize: MaterialTapTargetSize.padded,
  //pageTransitionsTheme: null,
  //appBarTheme: null,
  //bottomAppBarTheme: null,
  colorScheme: journalLightColorScheme,
  //dialogTheme: null,
  //floatingActionButtonTheme: null,
  //typography: null,
  //cupertinoOverrideTheme: null,
  //snackBarTheme: null,
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: lily,
  ),
);
