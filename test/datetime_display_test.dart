import 'package:journal/utils/datetime_util.dart';
import 'package:test/test.dart';

final current = DateTime.now();
final yesterday = current.add(Duration(days: -1));
final tommorrow = current.add(Duration(days: 1));
final monday = current.add(Duration(days: -current.weekday-7));
final nextMonth = current.add(Duration(days: 30));

void main() {
  group("Test time display", () {
    test("Current day", () {
      print(getDisplayString(current));
      print(getDisplayString(yesterday));
      print(getDisplayString(tommorrow));
      print(getDisplayString(monday));
      print(getDisplayString(nextMonth));
    });
  });

}