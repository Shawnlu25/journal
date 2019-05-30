import 'package:flutter/material.dart';

class RecordTime {
  final int month;
  final int day;
  final int hour;
  final int minute;
  final int weekday;

  RecordTime(
      {@required this.month,
      @required this.day,
      @required this.hour,
      @required this.minute,
      @required this.weekday});

  RecordTime.fromJSON(Map<String, dynamic> json)
      : this.month = json["month"],
        this.day = json["day"],
        this.hour = json["hour"],
        this.minute = json["minute"],
        this.weekday = json["weekday"];

  Map<String, dynamic> toJSON() => {
        "month": this.month,
        "day": this.day,
        "hour": this.hour,
        "minute": this.minute,
        "weekday": this.weekday
      };
}
