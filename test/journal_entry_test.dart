import 'package:journal/models/journal_entry.dart';
import 'package:test/test.dart';

final currentTime = new DateTime.now();
final twentyMinutesBeforeCurrent = currentTime.add(new Duration(minutes: -20));
final tenMinutesBeforeCurrent = currentTime.add(new Duration(minutes: -10));
final twentyMinutesAfterCurrent = currentTime.add(new Duration(minutes: 20));
final tenMinutesAfterCurrent = currentTime.add(new Duration(minutes: 10));

void main() {
  group("Test id uniqueness", () {
    test("Two different journal entries should have different ids", () {
      JournalEntry e1 = JournalEntry.createEntry(twentyMinutesBeforeCurrent);
      JournalEntry e2 = JournalEntry.createEntry(twentyMinutesBeforeCurrent);
      expect(e1.id == e2.id, false);
    });
  });

  group("Test journal entry state", () {
    test('New journal entry with startTimestamp before current time should have state InProgress', () {
      JournalEntry e = JournalEntry.createEntry(twentyMinutesBeforeCurrent);
      expect(e.getState(), JournalEntryState.InProgress);
    });
  });
}