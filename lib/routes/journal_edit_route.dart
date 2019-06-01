import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:journal/models/journal_entry.dart';
import 'package:journal/redux.dart';
import 'package:journal/widgets/tiled_dashboard.dart';

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
  JournalEntry journalEntryCache;
  bool newEntry;

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
    } else if (newEntry) {
      stateToDispatchMap.addJournal(
          oldJournalEntry); //JournalEntry(newAct, DateTime.now(), DateTime.now()));
      Navigator.pop(context);
    } else {
      // Modify existing journalEntry
      final newJournalEntry = JournalEntry(
          newAct, oldJournalEntry.startTime, oldJournalEntry.endTime,
          id: oldJournalEntry.id);
      stateToDispatchMap.modifyJournal(oldJournalEntry);
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

    if (journalEntryCache == null) {
      if (journalEntry != null) {
        newEntry = false;
        journalEntryCache = JournalEntry.copy(journalEntry);
      } else {
        newEntry = true;
        journalEntryCache = JournalEntry.createEntry(DateTime.now());
      }
    }
    _controller.text = journalEntryCache?.act ?? "";

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
                        this.submit(
                            context, stateToDispatchMap, journalEntryCache);
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
                        dateTime: journalEntryCache.startTime,
                        flex: 3,
                        onTap: () {
                          DatePicker.showDateTimePicker(
                            context,
                            showTitleActions: true,
                            onConfirm: (date) {
                              setState(() {
                                journalEntryCache.startTime = date;
                              });
                            },
                            currentTime: journalEntryCache.startTime,
                            locale: LocaleType.en,
                          );
                        },
                        onDoubleTap: () {
                          setState(() {
                            journalEntryCache.endTime = DateTime.now();
                          });
                        },
                        mode: TiledTimeDisplayMode.StartMode,
                      ),
                      TiledTimeDisplay(
                        dateTime: journalEntryCache.endTime,
                        flex: 3,
                        onTap: () {
                          DatePicker.showDateTimePicker(
                            context,
                            showTitleActions: true,
                            onConfirm: (date) {
                              setState(() {
                                journalEntryCache.endTime = date;
                              });
                            },
                            currentTime: journalEntryCache.endTime,
                            locale: LocaleType.en,
                          );
                        },
                        onDoubleTap: () {
                          setState(() {
                            journalEntryCache.endTime = DateTime.now();
                          });
                        },
                        mode: TiledTimeDisplayMode.InProgressMode,
                      ),
                      TiledIconButton(
                        onTap: () {
                          this.delete(
                              context, stateToDispatchMap, journalEntryCache);
                        },
                        iconData: Icons.delete,
                        flex: 1,
                        iconSizeFactor: 1.0,
                      ),
                      TiledIconButton(
                        onTap: () {
                          this.submit(
                              context, stateToDispatchMap, journalEntryCache);
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
                      alignLabelWithHint: true,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 16.0),
                      hintText: "Take an action...",
                      hintStyle: TextStyle(
                        fontSize: 22,
                      ),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      fontSize: 22,
                      //color: Colors.grey[700],
                    ),
                    autofocus: true,
                    autocorrect: true,
                    //cursorColor: Colors.grey[400],
                    cursorWidth: 2.0,
                    minLines: 1,
                    maxLines: 4,
                    maxLength: 60,
                    maxLengthEnforced: true,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    controller: _controller,
                    onChanged: (value) {
                      journalEntryCache.act = value;
                    },
                  ),
                ]),
              ),
              resizeToAvoidBottomInset: true,
            ));
  }
}
