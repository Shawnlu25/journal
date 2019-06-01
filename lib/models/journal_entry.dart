import 'package:uuid/uuid.dart';
//import 'package:journal/models/tag.dart';

enum JournalEntryState { Past, InProgress, Future }

class JournalEntry implements Comparable<JournalEntry> {
  String _id;
  String _act;
  DateTime _startTime;
  DateTime _endTime;
  //List<Tag> tags;
  //String description;

  // =========== Constructors ============
  // Default Constructor
  JournalEntry(this._act, this._startTime, this._endTime, {String id}) {
    if (_endTime != null && _endTime.isBefore(_startTime)) {
      _endTime = _startTime;
    }
    if (id != null) {
      _id = id;
    } else {
      _id = Uuid().v4();
    }
  }

  // Constructor for creating a new entry
  JournalEntry.createEntry(DateTime startTime) {
    this._id = Uuid().v4();
    this._act = "";
    this._startTime = startTime;
  }

  // Constructor for copying an existing entry
  JournalEntry.copy(JournalEntry e) {
    _id = e._id;
    _act = e._act;
    _startTime = e._startTime;
    _endTime = e._endTime;
  }

  // ========== Getter & Setters ==========
  String get id => _id;

  String get act => _act;

  set act(String value) {
    _act = value;
  }

  DateTime get startTime => _startTime;

  set startTime(DateTime value) {
    if (_endTime != null && value.isAfter(_endTime)) {
      _endTime = value;
    }
    _startTime = value;
  }

  DateTime get endTime => _endTime;

  set endTime(DateTime value) {
    if (value != null && value.isBefore(_startTime)) {
      _startTime = value;
    } else {
      _endTime = value;
    }
  }

  // ============= Comparable =================
  @override
  int compareTo(JournalEntry e) {
    if (startTime.compareTo(e.startTime) != 0) {
      return startTime.compareTo(e.startTime);
    }

    if (endTime != null) {
      if (e.endTime == null) {
        return -1;
      } else if (endTime.compareTo(e.endTime) != 0) {
        return endTime.compareTo(e.endTime);
      }
    } else if (e.endTime != null) {
      return 1;
    }

    if (act.compareTo(e.act) != 0) {
      return act.compareTo(e.act);
    }

    return id.compareTo(e.id);
  }

  // ============= Other methods ==============

  /*@override
  int get hashCode {
    return id.hashCode;
  }*/

  JournalEntryState getState() {
    final now = new DateTime.now();

    if (this._startTime.isAfter(now)) {
      return JournalEntryState.Future;
    }

    if (this._endTime != null && this._endTime.isBefore(now)) {
      return JournalEntryState.Past;
    }

    return JournalEntryState.InProgress;
  }

  Duration getDuration() {
    return this._endTime?.difference(this._startTime);
  }

  String toString() {
    return "${_id}:${_act}";
  }

  JournalEntry.fromJson(Map<String, dynamic> json) {
    this._act = json["act"];
    this._id = json["id"];
    this._startTime = json["startTime"] != null
        ? DateTime.fromMillisecondsSinceEpoch(json["startTime"])
        : null;
    this._endTime = json["endTime"] != null
        ? DateTime.fromMillisecondsSinceEpoch(json["endTime"])
        : null;
  }

  dynamic toJson() {
    return {
      "act": _act,
      "id": _id,
      "startTime": _startTime.millisecondsSinceEpoch,
      "endTime": _endTime.millisecondsSinceEpoch
    };
  }
}
