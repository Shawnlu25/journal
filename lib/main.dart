import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:journal/tiled_dashboard.dart';
import 'package:journal/widgets/activity_overview.dart';

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

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        brightness: Brightness.light,
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      home: Scaffold(
        bottomSheet: Container(
          color: Colors.white,
          //elevation: 8.0,
          child: TiledDashboard(),
        ),
        body: MyHomePage(),
      ),
    );
  }
}

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

    var list = groups.map((records) {
      return StickyHeader(
          overlapHeaders: false,
          header: _buildHeader(records[0]['startTime']),
          content: Column(
            children: List.generate(records.length, (j) {
              var i = records.length - 1 - j;
              return ActivityOverview(
                title: records[i]["title"],
                startTime: DateTime.fromMillisecondsSinceEpoch(
                    records[i]["startTime"]),
                endTime:
                    DateTime.fromMillisecondsSinceEpoch(records[i]["endTime"]),
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
    return this._buildOverviewList();
  }
}

Widget _buildHeader(num timestampInMilliseconds) {
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
                ActivityOverview.WeekdayMap[
                    DateTime.fromMillisecondsSinceEpoch(timestampInMilliseconds)
                        .weekday],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Text(
                //startTime.day.toString(),
                DateTime.fromMillisecondsSinceEpoch(timestampInMilliseconds)
                    .day
                    .toString(),
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
