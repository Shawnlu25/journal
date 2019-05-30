import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';
import './widgets/activity_overview.dart';
import 'package:flutter_redux/flutter_redux.dart';

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
    "title": "在办公室工作 10",
    "startTime": DateTime(2019, 5, 27, 11, 0).millisecondsSinceEpoch,
    "endTime": DateTime(2019, 5, 27, 11, 30).millisecondsSinceEpoch
  },
  {
    "title": "在办公室工作 11",
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
  {
    "title": "在办公室工作 10",
    "startTime": DateTime(2019, 5, 28, 11, 0).millisecondsSinceEpoch,
    "endTime": DateTime(2019, 5, 28, 11, 30).millisecondsSinceEpoch
  },
  {
    "title": "在办公室工作 11",
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

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  Widget _buildOverviewList() {
    var groups = [];
    fakeData.reversed.toList().forEach((data) {
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

    print("Enter here");
    var list = groups.map((records) {
      return StickyHeader(
          overlapHeaders: true,
          header: Container(
            color: Colors.transparent,
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Text(
                      ActivityOverview.WeekdayMap[
                          DateTime.fromMillisecondsSinceEpoch(
                                  records[0]["startTime"])
                              .weekday],
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w300)),
                  Text(
                    //startTime.day.toString(),
                    DateTime.fromMillisecondsSinceEpoch(records[0]["startTime"])
                        .day
                        .toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ),

          // header: Text("Hi"),

          content: Column(
            children: List.generate(records.length, (j) {
              var i = records.length - 1 - j;
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
            }),
          ));
    }).toList();
    return ListView.builder(
      reverse: true,
      itemBuilder: (_, i) {
        return list[i];
      },
      itemCount: list.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("点点时刻しました"),
        ),
        body: this._buildOverviewList());
  }
}
