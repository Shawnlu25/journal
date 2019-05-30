import 'package:uuid/uuid.dart';
//import 'package:journal/models/tag.dart';

enum JournalEntryState { Past, InProgress, Future }

class JournalEntry implements Comparable<JournalEntry>{
  String _id;
  String _act;
  DateTime _startTimestamp;
  DateTime _endTimestamp;
  //List<Tag> tags;
  //String description;


  // =========== Constructors ============
  // Default Constructor
  JournalEntry(this._id, this._act, this._startTimestamp, this._endTimestamp);

  // Constructor for creating a new entry
  JournalEntry.createEntry(DateTime startTimestamp) {
    this._id = Uuid().v4();
    this._act = "";
    this._startTimestamp = startTimestamp;
  }

  // ========== Getter & Setters ==========
  String get id => _id;

  String get act => _act;

  set act(String value) {
    _act = value;
  }

  DateTime get startTimestamp => _startTimestamp;

  set startTimestamp(DateTime value) {
    if (endTimestamp != null && value.isAfter(endTimestamp)) {
      _endTimestamp = value;
    }
    _startTimestamp = value;
  }

  DateTime get endTimestamp => _endTimestamp;

  set endTimestamp(DateTime value) {
    if (value.isBefore(startTimestamp)) {
      _endTimestamp = startTimestamp;
    } else {
      _endTimestamp = value;
    }
  }

  // ============= Comparable =================
  @override
  int compareTo(JournalEntry e) {
    if (startTimestamp.compareTo(e.startTimestamp) != 0) {
      return startTimestamp.compareTo(e.startTimestamp);
    }

    if (endTimestamp != null) {
      if (e.endTimestamp == null) {
        return -1;
      }
      if (endTimestamp.compareTo(e.endTimestamp) != 0) {
        return endTimestamp.compareTo(e.endTimestamp);
      }
    } else if (e.endTimestamp != null){
      return 1;
    }

    if (act.compareTo(e.act) != 0) {
      return act.compareTo(e.act);
    }

    return id.compareTo(e.id);
  }

  // ============= Other methods ==============

  JournalEntryState getState() {
    final now = new DateTime.now();

    if (this._startTimestamp.isAfter(now)) {
      return JournalEntryState.Future;
    }

    if (this._endTimestamp != null && this._endTimestamp.isBefore(now)) {
      return JournalEntryState.Past;
    }

    return JournalEntryState.InProgress;
  }

  Duration getDuration() {
    return this._endTimestamp?.difference(this._startTimestamp);
  }

}
