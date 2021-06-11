import 'package:eventsapp/core/common/enums.dart';
import 'package:eventsapp/core/models/event_model.dart';
import 'package:eventsapp/core/repositories/event_repository.dart';
import 'package:flutter/material.dart';

class EventProvider with ChangeNotifier {
  final _eventRepository = EventRepository();

  DateTime _selectedDate = DateTime.now();
  DateTime get selectedDate => _selectedDate;

  Map<String, List<Event>>? _events = {};
  Map<String, List<Event>>? get events => _events;

  Future<Map<String, List<Event>>?> loadEvents() async {
    _events = await _eventRepository.getEventsByDate(_selectedDate);
    notifyListeners();
    return events;
  }

  void changeDate(DateTime date) {
    _selectedDate = date;
    loadEvents();
  }

  Future<bool> eventFormOperation(Event event, EventMode mode) async {
    return (mode == EventMode.edit)
        ? await updateEvent(event)
        : await addEvent(event);
  }

  Future<bool> addEvent(Event event) async {
    Event? _event = await _eventRepository.addNewEvent(event);
    return await _dataResults<Event>(_event);
  }

  Future<bool> updateEvent(Event event) async {
    int? _id = await _eventRepository.updateEvent(event);
    return await _dataResults<int>(_id);
  }

  Future<bool> deleteEvent(int id) async {
    int? _id = await _eventRepository.deleteEvent(id);
    return await _dataResults<int>(_id);
  }

  Future<bool> _dataResults<T>(T? data) async {
    if (data != null) {
      await loadEvents();
      return true;
    }
    return false;
  }
}
