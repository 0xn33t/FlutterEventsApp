import 'package:eventsapp/core/common/environment.dart';
import 'package:eventsapp/core/utils/date_utils.dart';

final String tableEvent = 'event';
final String columnId = '_id';
final String columnTitle = 'title';
final String columnLocation = 'location';
final String columnDescription = 'description';
final String columnStarts = 'starts';
final String columnEnds = 'ends';

class Event {
  int? id;
  String title, location, description;
  DateTime starts, ends;

  Event({
    this.id,
    required this.title,
    required this.location,
    required this.description,
    required this.starts,
    required this.ends,
  });

  String eventTime(){
    String _time = '${starts.format(timePattern)} to ';
    _time += ends.format(starts.isSameDate(ends) ? timePattern : fullDateTimePattern);
    return _time;
  }

  Map<String, dynamic> toMap() {
    var _eventMap = <String, dynamic>{
      columnTitle: title,
      columnLocation: location,
      columnDescription: description,
      columnStarts: starts.format(dateTimePattern),
      columnEnds: ends.format(dateTimePattern),
    };
    if (id != null) _eventMap[columnId] = id;
    return _eventMap;
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map[columnId]!,
      title: map[columnTitle]!,
      location: map[columnLocation]!,
      description: map[columnDescription]!,
      starts: DateTime.parse(map[columnStarts]!),
      ends: DateTime.parse(map[columnEnds]!),
    );
  }
}
