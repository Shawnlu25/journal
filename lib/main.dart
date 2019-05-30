import 'package:flutter/material.dart';
import 'package:journal/models/record_time.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import './widgets/activity_overview.dart';

final List<Map<String, dynamic>> fakeData = [
  {
    "title": "在办公室工作 1",
    "startTime": DateTime(2019, 5, 27, 11, 0).millisecondsSinceEpoch,
    "endTime": DateTime(2019, 5, 27, 11, 30).millisecondsSinceEpoch
  },
  {
    "title": "在办公室工作 2",
    "startTime": DateTime(2019, 5, 27, 11, 0).millisecondsSinceEpoch,
    "endTime": DateTime(2019, 5, 27, 11, 30).millisecondsSinceEpoch
  },
  {
    "title": "在办公室工作 3",
    "startTime": DateTime(2019, 5, 27, 11, 0).millisecondsSinceEpoch,
    "endTime": DateTime(2019, 5, 27, 11, 30).millisecondsSinceEpoch
  },
  {
    "title": "在办公室工作 4",
    "startTime": DateTime(2019, 5, 27, 11, 0).millisecondsSinceEpoch,
    "endTime": DateTime(2019, 5, 27, 11, 30).millisecondsSinceEpoch
  },
  {
    "title": "在办公室工作 5",
    "startTime": DateTime(2019, 5, 27, 11, 0).millisecondsSinceEpoch,
    "endTime": DateTime(2019, 5, 27, 11, 30).millisecondsSinceEpoch
  },
  {
    "title": "在办公室工作 6",
    "startTime": DateTime(2019, 5, 27, 11, 0).millisecondsSinceEpoch,
    "endTime": DateTime(2019, 5, 27, 11, 30).millisecondsSinceEpoch
  },
  {
    "title": "在办公室工作 7",
    "startTime": DateTime(2019, 5, 27, 11, 0).millisecondsSinceEpoch,
    "endTime": DateTime(2019, 5, 27, 11, 30).millisecondsSinceEpoch
  },
  {
    "title": "在办公室工作 8",
    "startTime": DateTime(2019, 5, 27, 11, 0).millisecondsSinceEpoch,
    "endTime": DateTime(2019, 5, 27, 11, 30).millisecondsSinceEpoch
  },
  {
    "title": "在办公室工作 9",
    "startTime": DateTime(2019, 5, 27, 11, 0).millisecondsSinceEpoch,
    "endTime": DateTime(2019, 5, 27, 11, 30).millisecondsSinceEpoch
  },
  {
    "title": "在办公室工作 1",
    "startTime": DateTime(2019, 5, 28, 11, 0).millisecondsSinceEpoch,
    "endTime": DateTime(2019, 5, 28, 11, 30).millisecondsSinceEpoch
  },
  {
    "title": "在办公室工作 2",
    "startTime": DateTime(2019, 5, 28, 11, 0).millisecondsSinceEpoch,
    "endTime": DateTime(2019, 5, 28, 11, 30).millisecondsSinceEpoch
  },
  {
    "title": "在办公室工作 3",
    "startTime": DateTime(2019, 5, 28, 11, 0).millisecondsSinceEpoch,
    "endTime": DateTime(2019, 5, 28, 11, 30).millisecondsSinceEpoch
  },
  {
    "title": "在办公室工作 4",
    "startTime": DateTime(2019, 5, 28, 11, 0).millisecondsSinceEpoch,
    "endTime": DateTime(2019, 5, 28, 11, 30).millisecondsSinceEpoch
  },
  {
    "title": "在办公室工作 5",
    "startTime": DateTime(2019, 5, 28, 11, 0).millisecondsSinceEpoch,
    "endTime": DateTime(2019, 5, 28, 11, 30).millisecondsSinceEpoch
  },
  {
    "title": "在办公室工作 6",
    "startTime": DateTime(2019, 5, 28, 11, 0).millisecondsSinceEpoch,
    "endTime": DateTime(2019, 5, 28, 11, 30).millisecondsSinceEpoch
  },
  {
    "title": "在办公室工作 7",
    "startTime": DateTime(2019, 5, 28, 11, 0).millisecondsSinceEpoch,
    "endTime": DateTime(2019, 5, 28, 11, 30).millisecondsSinceEpoch
  },
  {
    "title": "在办公室工作 8",
    "startTime": DateTime(2019, 5, 28, 11, 0).millisecondsSinceEpoch,
    "endTime": DateTime(2019, 5, 28, 11, 30).millisecondsSinceEpoch
  },
  {
    "title": "在办公室工作 9",
    "startTime": DateTime(2019, 5, 28, 11, 0).millisecondsSinceEpoch,
    "endTime": DateTime(2019, 5, 28, 11, 30).millisecondsSinceEpoch
  },
];

main() => runApp(MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
        brightness: Brightness.light,
        //primaryColor: Color.fromRGBO(59, 66, 84, 1),
        //scaffoldBackgroundColor: Color.fromRGBO(59, 66, 84, 1),
        //accentColor: Colors.cyan[600],
        //backgroundColor: Colors.lightBlue[800],
        //cardTheme: CardTheme(color: Color.fromRGBO(84, 92, 110, 1)),
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
    ));

class MyHomePage extends StatelessWidget {
  List<Widget> _buildOverviewList() {
    var groups = [];
    fakeData.forEach((data) {
      var startTime = DateTime.fromMillisecondsSinceEpoch(data["startTime"]);
      if (groups.isNotEmpty) {
        var lastStartTime = DateTime.fromMillisecondsSinceEpoch(
            groups[groups.length - 1][0]["startTime"]);

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

    return groups.map((records) {
      return SliverStickyHeaderBuilder(
          overlapsContent: true,
          builder: (context, state) {
            return Container(
              color: Colors.transparent,
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: <Widget>[
                    Text(
                        ActivityOverview.WeekdayMap[
                            DateTime.fromMillisecondsSinceEpoch(
                                    records[0]["startTime"])
                                .weekday],
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w300)),
                    Text(
                      //startTime.day.toString(),
                      DateTime.fromMillisecondsSinceEpoch(
                              records[0]["startTime"])
                          .day
                          .toString(),
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            );
          },
          sliver: new SliverList(
            delegate: new SliverChildBuilderDelegate(
              (context, i) {
                return Padding(
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child: ActivityOverview(
                    title: records[i]["title"],
                    startTime: DateTime.fromMillisecondsSinceEpoch(
                        records[i]["startTime"]),
                    endTime: DateTime.fromMillisecondsSinceEpoch(
                        records[i]["endTime"]),
                  ),
                );
              },
              childCount: records.length,
            ),
          ));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("点点时刻しました"),
        ),
        body: CustomScrollView(
          slivers: this._buildOverviewList(),
        ));
  }
}
