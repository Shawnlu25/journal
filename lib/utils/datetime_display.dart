import 'package:intl/intl.dart';

final timeOnlyFormatter = new DateFormat('HH : mm');
final dayOfWeekTimeFormatter = new DateFormat('EEE HH : mm');
final dateTimeFormatter = new DateFormat('MMM d HH : mm');

String getDisplayString(DateTime timestamp) {
  DateTime cur = DateTime.now();
  if (sameDay(cur, timestamp)) {
    return timeOnlyFormatter.format(timestamp);
  }

  if (nextDay(cur, timestamp)) {
    return "TMRO " + timeOnlyFormatter.format(timestamp);
  }

  if (prevDay(cur, timestamp)) {
    return "YDAY " + timeOnlyFormatter.format(timestamp);
  }

  if (sameWeek(cur, timestamp)) {
    return dayOfWeekTimeFormatter.format(timestamp);
  }
  return dateTimeFormatter.format(timestamp);
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