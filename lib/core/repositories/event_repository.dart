import 'package:collection/collection.dart';
import 'package:eventsapp/core/common/environment.dart';
import 'package:eventsapp/core/models/event_model.dart';
import 'package:eventsapp/core/services/event_db_service.dart';
import 'package:eventsapp/core/utils/date_utils.dart';

class EventRepository {
  final EventDbServerice _eventDbServerice = EventDbServerice();

  Future<Event?> addNewEvent(Event event) async {
    try {
      await _eventDbServerice.open();
      return await _eventDbServerice.insert(event);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<int?> updateEvent(Event event) async {
    try {
      await _eventDbServerice.open();
      return await _eventDbServerice.update(event);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<Map<String, List<Event>>?> getEventsByDate(DateTime date) async {
    try {
      //await Future.delayed(Duration(seconds: 15));
      await _eventDbServerice.open();
      final _events = await _eventDbServerice.getEventsByDate(date.format(datePattern));
      if(_events != null){
        _events.sort((a, b) => a.starts.compareTo(b.starts));
        return groupBy(_events, (Event event) => event.starts.format(timePattern));
      }
      return {};
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<int?> deleteEvent(int eventId) async {
    try {
      await _eventDbServerice.open();
      return await _eventDbServerice.delete(eventId);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }


}
