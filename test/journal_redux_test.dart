import 'package:journal/models/journal_entry.dart';
import 'package:journal/redux.dart';
import 'package:redux/redux.dart';
import 'package:test/test.dart';

final JournalEntry e0 = JournalEntry("0", "start to sleep", DateTime(2019, 5, 29, 0, 48, 0), DateTime(2019, 5, 29, 0, 48, 0));
final JournalEntry e1 = JournalEntry("1", "wake up", DateTime(2019, 5, 29, 8, 14, 0), DateTime(2019, 5, 29, 8, 14, 0));
final JournalEntry e2 = JournalEntry("2", "study Japanese", DateTime(2019, 5, 29, 8, 22, 0), DateTime(2019, 5, 29, 8, 36, 0));
final JournalEntry e3 = JournalEntry("3", "purchase computers", DateTime(2019, 5, 29, 9, 35, 0), DateTime(2019, 5, 29, 10, 35, 0));
final JournalEntry e4 = JournalEntry("4", "develop Flutter app", DateTime(2019, 5, 29, 10, 35, 0), DateTime(2019, 5, 29, 12, 1, 0));
final JournalEntry e5 = JournalEntry("5", "lunch KFC", DateTime(2019, 5, 29, 12, 12, 0), DateTime(2019, 5, 29, 12, 25, 0));
final JournalEntry e6 = JournalEntry("6", "Flutter hackathon", DateTime(2019, 5, 29, 12, 52, 0), DateTime(2019, 5, 29, 18, 27, 0));
final JournalEntry e7 = JournalEntry("7", "read Bloomberg newsletter", DateTime(2019, 5, 29, 15, 12, 0), DateTime(2019, 5, 29, 15, 34, 0));
final JournalEntry e8 = JournalEntry("8", "dinner 胡桃里", DateTime(2019, 5, 29, 19, 1, 0), DateTime(2019, 5, 29, 19, 53, 0));
final JournalEntry e9 = JournalEntry("9", "study Japanese", DateTime(2019, 5, 29, 20, 7, 0), DateTime(2019, 5, 29, 20, 18, 0));
final JournalEntry e10 = JournalEntry("10", "rowing machine", DateTime(2019, 5, 29, 21, 48, 0), DateTime(2019, 5, 29, 22, 04, 0));

final List<JournalEntry> journalsAll = [e0, e1, e2, e3, e4, e5, e6, e7, e8, e9, e10];
final List<JournalEntry> journalsMorning = [e0, e1, e2, e3, e4];

void main() {
  group("Test JournalState", () {
    test("1", () {
      final store = new Store<JournalState>(journalReducer,
          initialState: JournalState(journalEntries: [e0, e1, e2, e3, e4, e5, e6, e7, e8, e9]),
          middleware: []);

      store.dispatch(JournalAddAction(e10));
      expect(store.state.journalEntries.length, 11);
    });
    test("2", () {
      final store = new Store<JournalState>(journalReducer,
          initialState: JournalState(journalEntries: [e0, e1, e2, e3, e4, e5, e6, e7, e8, e9]),
          middleware: []);

      store.dispatch(JournalDeleteAction(e9));
      expect(store.state.journalEntries.length, 9);
    });
  });
}