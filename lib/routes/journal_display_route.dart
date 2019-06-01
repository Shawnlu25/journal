import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:journal/models/journal_entry.dart';
import 'package:journal/widgets/tiled_dashboard.dart';
import 'package:journal/widgets/journal_entry_overview.dart';
import 'package:journal/redux.dart';
import 'package:journal/utils/datetime_display.dart';


class JournalDisplayRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        //color: Colors.white,
        child: TiledDashboard(),
      ),
      body: StoreConnector<JournalState, JournalState>(
        converter: (store) {
          return store.state;
        },
        builder: (context, journalState) {
          return _JournalDisplayRoute(journalEntries: journalState.journalEntries);
        },
      ),
    );
  }
}

class _JournalDisplayRoute extends StatefulWidget {
  final List<JournalEntry> journalEntries;

  _JournalDisplayRoute({Key key, @required this.journalEntries}) : super(key: key);

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

  Widget _buildJournalEntryOverviewList(BuildContext context) {
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
              );
            }),
          ));
    }).toList();

    return ListView.builder(
      reverse: true,
      padding: EdgeInsets.only(bottom: 48),
      itemBuilder: (_, i) {
        return list[i];
      },
      itemCount: list.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return this._buildJournalEntryOverviewList(context);
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
                  //fontWeight: FontWeight.w300,
                ),
              ),
              Text(
                //startTime.day.toString(),
                time.day.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  //fontWeight: FontWeight.w400,
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
