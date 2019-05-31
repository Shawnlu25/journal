import 'package:flutter/material.dart';

final double minHeight = 56;

class ActivityOverview extends StatelessWidget {
  final String title;
  final DateTime startTime;
  final DateTime endTime;

  static const WeekdayMap = {
    1: "Mon",
    2: "Tue",
    3: "Wed",
    4: "Thu",
    5: "Fri",
    6: "Sat",
    7: "Sun"
  };

  ActivityOverview(
      {@required this.startTime, @required this.endTime, @required this.title});

  String _addHeadingZero(String x) {
    if (x.length == 1) {
      return "0" + x;
    } else {
      return x;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(56, 0, 0, 0),
      child: Material(
        elevation: 0.0,
        color: Colors.white,
        animationDuration: Duration(milliseconds: 100),
        child: InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 4.0, 0.0, 4.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[700]),
                  ),
                  Container(height: 4),
                  Text(
                      "${startTime.hour}:${_addHeadingZero(startTime.minute.toString())} - ${endTime.hour}:${_addHeadingZero(endTime.minute.toString())}",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w300))
                ]),
          ),
        ),
      ),
    );
  }
}