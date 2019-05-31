import 'package:journal/models/journal_entry.dart';
import 'package:journal/redux.dart';
import 'package:redux/redux.dart';
import 'package:test/test.dart';

final JournalEntry e0 = JournalEntry("start to sleep",
    DateTime(2019, 5, 29, 0, 48, 0), DateTime(2019, 5, 29, 0, 48, 0),
    id: "0");
final JournalEntry e1 = JournalEntry(
    "wake up", DateTime(2019, 5, 29, 8, 14, 0), DateTime(2019, 5, 29, 8, 14, 0),
    id: "1");
final JournalEntry e2 = JournalEntry("study Japanese",
    DateTime(2019, 5, 29, 8, 22, 0), DateTime(2019, 5, 29, 8, 36, 0),
    id: "2");
final JournalEntry e3 = JournalEntry("purchase computers",
    DateTime(2019, 5, 29, 9, 35, 0), DateTime(2019, 5, 29, 10, 35, 0),
    id: "3");
final JournalEntry e4 = JournalEntry("develop Flutter app",
    DateTime(2019, 5, 29, 10, 35, 0), DateTime(2019, 5, 29, 12, 1, 0),
    id: "4");
final JournalEntry e5 = JournalEntry("lunch KFC",
    DateTime(2019, 5, 29, 12, 12, 0), DateTime(2019, 5, 29, 12, 25, 0),
    id: "5");
final JournalEntry e6 = JournalEntry("Flutter hackathon",
    DateTime(2019, 5, 29, 12, 52, 0), DateTime(2019, 5, 29, 18, 27, 0),
    id: "6");
final JournalEntry e7 = JournalEntry("read Bloomberg newsletter",
    DateTime(2019, 5, 29, 15, 12, 0), DateTime(2019, 5, 29, 15, 34, 0),
    id: "7");
final JournalEntry e8 = JournalEntry("dinner 胡桃里",
    DateTime(2019, 5, 29, 19, 1, 0), DateTime(2019, 5, 29, 19, 53, 0),
    id: "8");
final JournalEntry e9 = JournalEntry("study Japanese",
    DateTime(2019, 5, 29, 20, 7, 0), DateTime(2019, 5, 29, 20, 18, 0),
    id: "9");
final JournalEntry e10 = JournalEntry("rowing machine",
    DateTime(2019, 5, 29, 21, 48, 0), DateTime(2019, 5, 29, 22, 04, 0),
    id: "10");

final List<JournalEntry> journalsAll = [
  e0,
  e1,
  e2,
  e3,
  e4,
  e5,
  e6,
  e7,
  e8,
  e9,
  e10
];
final List<JournalEntry> journalsMorning = [e0, e1, e2, e3, e4];

void main() {
  group("Test JournalState", () {
    test("1", () {
      final store = new Store<JournalState>(journalReducer,
          initialState: JournalState(
              journalEntries: [e0, e1, e2, e3, e4, e5, e6, e7, e8, e9]),
          middleware: []);

      store.dispatch(JournalAddAction(e10));
      expect(store.state.journalEntries.length, 11);
    });
    test("2", () {
      final store = new Store<JournalState>(journalReducer,
          initialState: JournalState(
              journalEntries: [e0, e1, e2, e3, e4, e5, e6, e7, e8, e9]),
          middleware: []);

      store.dispatch(JournalDeleteAction(e9));
      expect(store.state.journalEntries.length, 9);
    });
    test("3", () {
      final store = new Store<JournalState>(journalReducer,
          initialState: JournalState(
              journalEntries: [e0, e1, e2, e3, e4, e5, e6, e7, e8, e9]),
          middleware: []);
      final JournalEntry new_e9 = JournalEntry(
          "new e9", DateTime(2019, 5, 29, 20, 7, 0), null,
          id: "9");
      expect(store.state.journalEntries[9].act, "study Japanese");
      store.dispatch(JournalModifyAction(new_e9));
      expect(store.state.journalEntries.length, 10);
      expect(store.state.journalEntries[9].act, "new e9");
      expect(store.state.journalEntries[9].endTime, null);
    });
  });
}
