import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:journal/models/journal_entry.dart';
import 'package:journal/redux.dart';
import 'package:journal/routes/home_route.dart';
import 'package:journal/widgets/tiled_dashboard.dart';
import 'package:redux/redux.dart';

class JournalEditRoute extends StatefulWidget {
  JournalEditRoute();

  @override
  _JournalEditRouteState createState() => _JournalEditRouteState();
}

typedef void _AddJournal(JournalEntry journalEntry);
typedef void _ModifyJournal(JournalEntry journalEntry);
typedef void _DeleteJournal(JournalEntry journalEntry);

class _StateToDispatchMap {
  final _AddJournal addJournal;
  final _ModifyJournal modifyJournal;
  final _DeleteJournal _deleteJournal;

  _StateToDispatchMap(this.addJournal, this.modifyJournal, this._deleteJournal);
}

class _JournalEditRouteState extends State<JournalEditRoute> {
  TextEditingController _controller;
  JournalEntry selectedJournalEntry;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void submit(BuildContext context, _StateToDispatchMap stateToDispatchMap,
      JournalEntry oldJournalEntry) {
    final newAct = _controller.text ?? "";
    if (newAct.length == 0) {
      Navigator.pop(context);
    } else if (oldJournalEntry == null) {
      // Create new journalEntry
      stateToDispatchMap
          .addJournal(JournalEntry(newAct, DateTime.now(), DateTime.now()));
      Navigator.pop(context);
    } else {
      // Modify exissting journalEntry
      final newJournalEntry = JournalEntry(
          newAct, oldJournalEntry.startTime, oldJournalEntry.endTime,
          id: oldJournalEntry.id);
      stateToDispatchMap.modifyJournal(newJournalEntry);
      Navigator.pop(context);
    }
  }

  void delete(BuildContext context, _StateToDispatchMap stateToDispatchMap,
      JournalEntry oldJournalEntry) {
    if (oldJournalEntry == null) {
      Navigator.pop(context);
    } else {
      stateToDispatchMap._deleteJournal(oldJournalEntry);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    JournalEntry journalEntry = ModalRoute.of(context).settings.arguments;
    if (selectedJournalEntry != journalEntry) {
      _controller.text = journalEntry?.act ?? "";
      selectedJournalEntry = journalEntry;
    }
    return StoreConnector<JournalState, _StateToDispatchMap>(
        converter: (store) => _StateToDispatchMap(
            (journalEntry) => store.dispatch(JournalAddAction(journalEntry)),
            (journalEntry) => store.dispatch(JournalModifyAction(journalEntry)),
            (journalEntry) =>
                store.dispatch(JournalDeleteAction(journalEntry))),
        builder: (context, stateToDispatchMap) => Scaffold(
              appBar: AppBar(
                leading: Builder(
                  builder: (BuildContext context) {
                    return IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        this.submit(context, stateToDispatchMap, journalEntry);
                      },
                    );
                  },
                ),
                elevation: 0.0,
                actions: <Widget>[],
              ),
              bottomSheet: Container(
                height: 48.0,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      TiledTimeDisplay(
                        dateTime: DateTime.now(),
                        flex: 3,
                        onTap: () {},
                        mode: TiledTimeDisplayMode.StartMode,
                      ),
                      TiledTimeDisplay(
                        dateTime:
                            null, //DateTime.now().add(Duration(minutes: 20, hours: 30, days: 8)),
                        flex: 3,
                        onTap: () {
                          Future<TimeOfDay> selectedTimeRTL = showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                            builder: (BuildContext context, Widget child) {
                              return MediaQuery(
                                data: MediaQuery.of(context)
                                    .copyWith(alwaysUse24HourFormat: true),
                                child: child,
                              );
                            },
                          );
                        },
                        mode: TiledTimeDisplayMode.InProgressMode,
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: 48,
                          height: 48,
                          color: Colors.white,
                        ),
                      ),
                      TiledIconButton(
                        onTap: () {
                          this.delete(
                              context, stateToDispatchMap, journalEntry);
                        },
                        iconData: Icons.delete,
                        flex: 1,
                        iconSizeFactor: 1.0,
                      ),
                      TiledIconButton(
                        onTap: () {
                          this.submit(
                              context, stateToDispatchMap, journalEntry);
                        },
                        iconData: Icons.check,
                        flex: 1,
                        iconSizeFactor: 1.0,
                      ),
                    ],
                  ),
                ),
              ),
              body: Container(
                color: Colors.white,
                child: Column(children: [
                  TextField(
                    decoration: InputDecoration(
                      prefix: Padding(
                        padding: EdgeInsets.only(
                          right: 8,
                          left: 4,
                        ),
                        child: Icon(
                          Icons.edit,
                          color: Colors.grey[700],
                          size: 24,
                        ),
                      ),
                      alignLabelWithHint: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                      hintText: "Take an action...",
                      hintStyle:
                          TextStyle(fontSize: 22, color: Colors.grey[500]),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.grey[700],
                    ),
                    autofocus: true,
                    autocorrect: true,
                    cursorColor: Colors.grey[400],
                    cursorWidth: 2.0,
                    enableInteractiveSelection: true,
                    minLines: 1,
                    maxLines: 4,
                    maxLength: 60,
                    maxLengthEnforced: true,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    controller: _controller,
                  ),
                ]),
              ),
              resizeToAvoidBottomInset: true,
            ));
  }
}
