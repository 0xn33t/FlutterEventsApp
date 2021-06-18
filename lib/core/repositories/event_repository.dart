import 'package:collection/collection.dart';
import 'package:eventsapp/core/common/environment.dart';
import 'package:eventsapp/core/models/event_model.dart';
import 'package:eventsapp/core/services/event_db_service.dart';
import 'package:eventsapp/core/services/widgetkit_service.dart';
import 'package:eventsapp/core/utils/date_utils.dart';

class EventRepository {
  
  static final EventRepository _singleton = EventRepository._internal();
  EventRepository._internal();
  factory EventRepository() => _singleton;

  final EventDbServerice _eventDbServerice = EventDbServerice();
  final WidgetkitService _widgetkitService = WidgetkitService();

  Future<Map<String, List<Event>>?> getAllEvents() async {
    try {
      await _eventDbServerice.open();
      final _events = await _eventDbServerice.getEvents();
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

  Future<List<Event>?> getAllActiveEvents() async {
    try {
      await _eventDbServerice.open();
      final _events = await _eventDbServerice.getActiveEvents();
      if(_events != null){
        _events.sort((a, b) => a.starts.compareTo(b.starts));
        return _events;
      }
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<Map<String, List<Event>>?> getEventsByDate(DateTime date) async {
    try {
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

  Future<Event?> addNewEvent(Event event) async {
    try {
      await _eventDbServerice.open();
      final _event = await _eventDbServerice.insert(event);
      await _reloadWidgetKit();
      return _event;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<int?> updateEvent(Event event) async {
    try {
      await _eventDbServerice.open();
      final _id = await _eventDbServerice.update(event);
      await _reloadWidgetKit();
      return _id;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<int?> deleteEvent(int eventId) async {
    try {
      await _eventDbServerice.open();
      final _id = await _eventDbServerice.delete(eventId);
      await _reloadWidgetKit();
      return _id;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> deleteAllEvents() async {
    try {
      await _eventDbServerice.open();
      await _eventDbServerice.deleteAll();
      await _reloadWidgetKit();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _reloadWidgetKit() async {
    final _activeEvents = await getAllActiveEvents();
    if(_activeEvents != null && _activeEvents.isNotEmpty){
      await _widgetkitService.setEvents(_activeEvents);
    }else{
      await _widgetkitService.clearEvents();
    }
  }

}
