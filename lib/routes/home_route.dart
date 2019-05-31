import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:journal/models/journal_entry.dart';
import 'package:journal/widgets/tiled_dashboard.dart';
import 'package:journal/widgets/activity_overview.dart';
import 'package:journal/redux.dart';
import 'package:sticky_headers/sticky_headers.dart';

class HomeRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        color: Colors.white,
        child: TiledDashboard(),
      ),
      body: StoreConnector<JournalState, JournalState>(
        converter: (store) {
          return store.state;
        },
        builder: (context, journalState) {
          return MyHomePage(journalEntries: journalState.journalEntries);
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final List<JournalEntry> journalEntries;

  MyHomePage({Key key, @required this.journalEntries}) : super(key: key);

  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  Widget _buildOverviewList(BuildContext context) {
    List<List<JournalEntry>> groups = [];
    widget.journalEntries.reversed.toList().forEach((data) {
      var startTime = data.startTime;
      if (groups.isNotEmpty) {
        var lastStartTime = groups[groups.length - 1][0].startTime;

        if (startTime.year == lastStartTime.year &&
            startTime.month == lastStartTime.month &&
            startTime.day == lastStartTime.day) {
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
              return ActivityOverview(
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
    return this._buildOverviewList(context);
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
                ActivityOverview.WeekdayMap[time.weekday],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Text(
                //startTime.day.toString(),
                time.day.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
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
