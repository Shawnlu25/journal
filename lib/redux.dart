import 'package:redux/redux.dart';
import 'package:journal/models/journal_entry.dart';

class JournalState {
  final List<JournalEntry> journalEntries;

  JournalState({
    this.journalEntries,
  });

  static JournalState fromJson(dynamic json) => JournalState(
      journalEntries: ((json ?? {})["entries"] as List<dynamic> ?? [])
          .map((x) => JournalEntry.fromJson(x))
          .toList());

  dynamic toJson() {
    return {
      "entries": this
          .journalEntries
          .map((journalEntry) => journalEntry.toJson())
          .toList()
    };
  }
}

// ========== Actions ==========
class JournalAddAction {
  final JournalEntry newEntry;

  JournalAddAction(this.newEntry);
}

class JournalDeleteAction {
  final JournalEntry entry;

  JournalDeleteAction(this.entry);
}

class JournalModifyAction {
  final JournalEntry entry;

  JournalModifyAction(this.entry);
}

// ========== Reducers =========
final journalReducer = combineReducers<JournalState>([
  TypedReducer<JournalState, JournalAddAction>(_onJournalAdd),
  TypedReducer<JournalState, JournalDeleteAction>(_onJournalDelete),
  TypedReducer<JournalState, JournalModifyAction>(_onJournalModify),
]);

JournalState _onJournalAdd(JournalState state, JournalAddAction action) {
  List<JournalEntry> journalEntries = state.journalEntries;
  journalEntries.add(action.newEntry);
  journalEntries.sort();
  return JournalState(journalEntries: journalEntries);
}

JournalState _onJournalDelete(JournalState state, JournalDeleteAction action) {
  List<JournalEntry> journalEntries = state.journalEntries;
  JournalState(
      journalEntries: journalEntries.map((journalEntry) {
        if (journalEntry.id == action.entry.id) {
          return action.entry;
        } else {
          return journalEntry;
        }
      }).toList());
  journalEntries.removeWhere((JournalEntry e) => e.id == action.entry.id);
  return JournalState(journalEntries: journalEntries);
}

JournalState _onJournalModify(JournalState state, JournalModifyAction action) {
  List<JournalEntry> journalEntries = state.journalEntries;
  List<JournalEntry> newEntries = journalEntries.map((journalEntry) {
    if (journalEntry.id == action.entry.id) {
      return action.entry;
    } else {
      return journalEntry;
    }
  }).toList();
  newEntries.sort();
  return JournalState(journalEntries: newEntries);
}

final initialState = JournalState(journalEntries: [
  JournalEntry("Hello World", DateTime.now(), DateTime.now())
]);
