import 'package:redux/redux.dart';
import 'package:journal/models/journal_entry.dart';

class JournalState {
  final List<JournalEntry> journalEntries;

  JournalState({
    this.journalEntries,
  });

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
  return JournalState(journalEntries: journalEntries);
}

JournalState _onJournalDelete(JournalState state, JournalDeleteAction action) {
  List<JournalEntry> journalEntries = state.journalEntries;
  journalEntries.remove(action.entry);
  return JournalState(journalEntries: journalEntries);
}

JournalState _onJournalModify(JournalState state, JournalModifyAction action) {
  List<JournalEntry> journalEntries = state.journalEntries;
  journalEntries[journalEntries.indexOf(journalEntries.firstWhere((e) => e.id == action.entry.id))] = action.entry;
  return JournalState(journalEntries: journalEntries);
}