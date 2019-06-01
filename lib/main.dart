import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:journal/redux.dart';
import 'package:journal/routes/journal_display_route.dart';
import 'package:redux/redux.dart';
import 'package:journal/routes/journal_edit_route.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_persist_flutter/redux_persist_flutter.dart';
import 'package:journal/styles.dart';


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

  // System Chrome
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: lily,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));

  runApp(MyApp(
    store: store,
  ));
}

class MyApp extends StatelessWidget {
  final Store<JournalState> store;

  MyApp({Key key, @required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
        store: store,
        child: MaterialApp(
          title: '',
          theme: journalLightThemeData,
          debugShowCheckedModeBanner: false,
          routes: {
            "/": (context) => JournalDisplayRoute(),
            "/edit": (context) => JournalEditRoute()
          },
          initialRoute: "/",
        ));
  }
}
