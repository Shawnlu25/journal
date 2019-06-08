import 'package:flutter/material.dart';
import 'package:journal/utils/datetime_util.dart';

final double minHeight = 56;

typedef void OnTap();

class JournalEntryOverview extends StatelessWidget {
  final String title;
  final DateTime startTime;
  final DateTime endTime;
  final OnTap onTap;
  final VoidCallback onDoubleTap;

  JournalEntryOverview(
      {@required this.startTime,
      @required this.endTime,
      @required this.title,
      @required this.onTap,
      @required this.onDoubleTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(56, 0, 0, 0),
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            left: BorderSide(
              width: 4.0,
              color: Colors.blueGrey,
            ),
          ),
        ),
        child: Material(
          elevation: 0.0,
          animationDuration: Duration(milliseconds: 100),
          child: InkWell(
            onTap: this.onTap,
            onDoubleTap: this.onDoubleTap,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 4.0, 0.0, 4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Container(height: 4),
                  Text(
                    getPairDisplayString(startTime, endTime),
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
