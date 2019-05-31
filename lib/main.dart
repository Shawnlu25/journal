import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:journal/redux.dart';
import 'package:journal/routes/home_route.dart';
import 'package:redux/redux.dart';
import 'package:journal/routes/journal_edit_route.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_persist_flutter/redux_persist_flutter.dart';

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
        //fontFamily: 'Noto Sans',
        displayColor: Colors.grey[800],
        bodyColor: Colors.grey[800],
      );
}

ThemeData _buildJournalTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    accentColor: Colors.grey[800],
    primaryColor: Colors.white,
    buttonTheme: base.buttonTheme.copyWith(
      buttonColor: Colors.grey[400],
      textTheme: ButtonTextTheme.normal,
      colorScheme: ColorScheme.light(),
    ),
    scaffoldBackgroundColor: Colors.white,
    cardColor: Colors.white,
    textSelectionColor: Colors.grey[400],
    errorColor: Color.fromRGBO(50, 30, 30, 100.0),
    textTheme: _buildJournalTextTheme(base.textTheme),
    // TODO: Add the icon themes (103)
    // TODO: Decorate the inputs (103)
  );
}

void main() async {
  final persistor = Persistor<JournalState>(
    storage: FlutterStorage(location: FlutterSaveLocation.sharedPreferences),
    serializer: JsonSerializer<JournalState>(JournalState.fromJson),
  );

  // Load initial state
  final persistentState = await persistor.load();
  final store = new Store<JournalState>(journalReducer,
      initialState: persistentState ?? initialState,
      middleware: [persistor.createMiddleware()]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  runApp(MyApp(
    store: store,
  ));
}

class MyApp extends StatelessWidget {
  final Store<JournalState> store;

  MyApp({Key key, @required this.store}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
        store: store,
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: _buildJournalTheme(),
          routes: {
            "/": (context) => HomeRoute(),
            "/edit": (context) => JournalEditRoute()
          },
          initialRoute: "/",
        ));
  }
}
