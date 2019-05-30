import 'package:uuid/uuid.dart';
import 'package:journal/models/tag.dart';

enum JournalEntryState { Past, InProgress, Future }

class JournalEntry {
  String _id;
  String act;
  DateTime startTimestamp;
  DateTime endTimestamp;
  List<Tag> tags;
  String description;

  JournalEntry(DateTime startTimestamp) {
    this._id = Uuid().v4();
    this.act = "";
    this.description = "";
    this.startTimestamp = startTimestamp;
    this.tags = new List<Tag>();
  }

  String id() {
    return this._id;
  }

  JournalEntryState getState() {
    final now = new DateTime.now();
    if (startTimestamp.isAfter(now)) {
      return JournalEntryState.Future;
    }
    if (endTimestamp != null && endTimestamp.isBefore(now)) {
      return JournalEntryState.Past;
    }
    return JournalEntryState.InProgress;
  }

  Duration getDuration() {
    if (endTimestamp != null) {
      return endTimestamp.difference(startTimestamp);
    }
    return null;
  }
}
