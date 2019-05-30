import 'package:flutter/material.dart';
import 'package:journal/models/record_time.dart';

class ActivityOverview extends StatelessWidget {
  final String title;
  final DateTime startTime;
  final DateTime endTime;

  static final WeekdayMap = {
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
      child: Row(
        children: <Widget>[
          Container(
            width: 60,
          ),
          Expanded(
            child: Container(
              child: Container(
                decoration: BoxDecoration(
                    // color: Colors.blue,
                    borderRadius: BorderRadius.circular(5.0)),
                margin: EdgeInsets.only(top: 6),
                child: Row(
                  children: <Widget>[
                    // Container(color: Colors.red, width: 8, height: 80),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(6, 6, 6, 6),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              title,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black87),
                            ),
                            Container(height: 4),
                            Text(
                                "${startTime.hour}:${_addHeadingZero(startTime.minute.toString())} - ${endTime.hour}:${_addHeadingZero(endTime.minute.toString())}",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w300))
                          ]),
                    ),
                  ],
                ),
              ),
              /*
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(200, 200, 200, 1),
                    blurRadius: 8.0,
                    //spreadRadius: 0.5
                  )
                ])*/
            ),
          )
        ],
      ),
    );
  }
}
