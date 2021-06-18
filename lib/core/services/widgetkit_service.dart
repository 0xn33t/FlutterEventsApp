import 'dart:convert';

import 'package:eventsapp/core/common/environment.dart';
import 'package:eventsapp/core/models/event_model.dart';
import 'package:flutter_widgetkit/flutter_widgetkit.dart';

class WidgetkitService {
  static final WidgetkitService _singleton = WidgetkitService._internal();

  WidgetkitService._internal();

  factory WidgetkitService() => _singleton;

  Future<bool> setEvents(List<Event> data) async {
    try {
      await WidgetKit.setItem(iosUserDefaultsKey, jsonEncode(data), iosUserDefaultsAppGroup);
      WidgetKit.reloadAllTimelines();
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> clearEvents() async {
    try {
      final _res = await WidgetKit.removeItem(iosUserDefaultsKey, iosUserDefaultsAppGroup);
      WidgetKit.reloadAllTimelines();
      return _res;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

}
