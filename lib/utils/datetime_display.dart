import 'package:intl/intl.dart';

final _timeOnlyFormatter = new DateFormat('HH : mm');
final _timeOnlyCompactFormatter = new DateFormat('HH:mm');
final _dayOfWeekTimeFormatter = new DateFormat('EEE HH : mm');
final _dayOfWeekFormatter = new DateFormat('EEE');
final _dateTimeFormatter = new DateFormat('MMM d HH : mm');
final _dateTimeCompactFormatter = new DateFormat('MMM d HH : mm');

String getDayOfWeek(DateTime timestamp) {
  return _dayOfWeekFormatter.format(timestamp);
}

String getPairDisplayString(DateTime d1, DateTime d2) {
  if (d2 == null) {
    return _timeOnlyCompactFormatter.format(d1);
  }
  if (sameDay(d1, d2) || nextDay(d1, d2)) {
    return _timeOnlyCompactFormatter.format(d1) + " - " + _timeOnlyCompactFormatter.format(d2);
  }
  return _timeOnlyCompactFormatter.format(d1) + " - " + _dateTimeCompactFormatter.format(d2);
}

String getDisplayString(DateTime timestamp) {
  DateTime cur = DateTime.now();
  if (timestamp == null) {
    return "In progress";
  }

  if (sameDay(cur, timestamp)) {
    return _timeOnlyFormatter.format(timestamp);
  }

  if (nextDay(cur, timestamp)) {
    return "TMRO " + _timeOnlyFormatter.format(timestamp);
  }

  if (prevDay(cur, timestamp)) {
    return "YDAY " + _timeOnlyFormatter.format(timestamp);
  }

  if (sameWeek(cur, timestamp)) {
    return _dayOfWeekTimeFormatter.format(timestamp);
  }
  return _dateTimeFormatter.format(timestamp);
}

bool sameWeek(DateTime d1, DateTime d2) {
  DateTime d1monday = d1.add(Duration(days: -d1.weekday));
  DateTime d2monday = d2.add(Duration(days: -d2.weekday));
  return d1monday.day == d2monday.day && d1monday.month == d2monday.month && d1monday.year == d2monday.year;
}

bool sameDay(DateTime d1, DateTime d2) {
  return d1.day == d2.day && d1.month == d2.month && d1.year == d2.year;
}

bool nextDay(DateTime d1, DateTime d2) {
  DateTime d1n = d1.add(Duration(days: 1));
  return d1n.day == d2.day && d1n.month == d2.month && d1n.year == d2.year;
}

bool prevDay(DateTime d1, DateTime d2) {
  DateTime d1p = d1.add(Duration(days: -1));
  return d1p.day == d2.day && d1p.month == d2.month && d1p.year == d2.year;
}