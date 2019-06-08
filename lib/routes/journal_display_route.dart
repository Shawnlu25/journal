import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:journal/models/journal_entry.dart';
import 'package:journal/widgets/tiled_dashboard.dart';
import 'package:journal/widgets/journal_entry_overview.dart';
import 'package:journal/redux.dart';
import 'package:journal/utils/datetime_util.dart';

class JournalDisplayRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        child: TiledDashboard(),
      ),
      body: SafeArea(
        child: StoreConnector<JournalState, _StateToDispatchMap>(
          converter: (store) => _StateToDispatchMap(
              (journalEntry) => store.dispatch(JournalAddAction(journalEntry)),
              () => store.state.journalEntries),
          builder: (context, stateToDispatchMap) {
            return _JournalDisplayRoute(
              journalEntries: stateToDispatchMap.getJournal(),
              stateToDispatchMap: stateToDispatchMap,
            );
          },
        ),
      ),
    );
  }
}

typedef void _AddJournal(JournalEntry journalEntry);
typedef List<JournalEntry> _GetJournal();

class _StateToDispatchMap {
  final _GetJournal getJournal;
  final _AddJournal addJournal;

  _StateToDispatchMap(this.addJournal, this.getJournal);
}

class _JournalDisplayRoute extends StatefulWidget {
  final List<JournalEntry> journalEntries;
  final _StateToDispatchMap stateToDispatchMap;

  _JournalDisplayRoute(
      {Key key,
      @required this.journalEntries,
      @required this.stateToDispatchMap})
      : super(key: key);

  @override
  _JournalDisplayRouteState createState() {
    return _JournalDisplayRouteState();
  }
}

class _JournalDisplayRouteState extends State<_JournalDisplayRoute> {
  @override
  void initState() {
    super.initState();
  }

  void addEntryWithSameAct(BuildContext context,
      _StateToDispatchMap stateToDispatchMap, JournalEntry oldJournalEntry) {
    JournalEntry e = JournalEntry.createEntry(DateTime.now());
    e.act = oldJournalEntry.act;
    stateToDispatchMap.addJournal(e);
  }

  Widget _buildJournalEntryOverviewList(
      BuildContext context, _StateToDispatchMap stateToDispatchMap) {
    List<List<JournalEntry>> groups = [];
    // Assume that journalEntries have already been sorted
    widget.journalEntries.reversed.toList().forEach((data) {
      var startTime = data.startTime;
      if (groups.isNotEmpty) {
        var lastStartTime = groups[groups.length - 1][0].startTime;

        if (sameDay(startTime, lastStartTime)) {
          groups[groups.length - 1].add(data);
        } else {
          groups.add([data]);
        }
      } else {
        groups.add([data]);
      }
    });

    var list = groups.map((records) {
      return StickyHeader(
          overlapHeaders: false,
          header: _buildHeader(records[0].startTime),
          content: Column(
            children: List.generate(records.length, (j) {
              var i = records.length - 1 - j;
              return JournalEntryOverview(
                title: records[i].act,
                startTime: records[i].startTime,
                endTime: records[i].endTime,
                onTap: () {
                  Navigator.pushNamed(context, "/edit", arguments: records[i]);
                },
                onDoubleTap: () {
                  this.addEntryWithSameAct(
                      context, stateToDispatchMap, records[i]);
                },
              );
            }),
          ));
    }).toList();

    return ListView.builder(
      reverse: true,
      padding: EdgeInsets.only(top: 96.0, bottom: 48),
      itemBuilder: (_, i) {
        return list[i];
      },
      itemCount: list.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return this
        ._buildJournalEntryOverviewList(context, widget.stateToDispatchMap);
  }
}

Widget _buildHeader(DateTime time) {
  return Row(
    children: [
      Container(
        width: 56,
        height: 56,
        color: Colors.transparent,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                getDayOfWeek(time),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              Text(
                //startTime.day.toString(),
                time.day.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
      Expanded(
        child: Container(
          height: 56,
          color: Colors.transparent,
        ),
      ),
    ],
  );
}
