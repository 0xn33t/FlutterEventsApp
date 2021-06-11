import 'package:eventsapp/core/common/environment.dart';
import 'package:eventsapp/core/models/event_model.dart';
import 'package:sqflite/sqflite.dart';

class EventDbServerice {
  Database? db;

  Future<void> open() async {
    db = await openDatabase(
      dbKey,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
        create table $tableEvent ( 
          $columnId integer primary key autoincrement, 
          $columnTitle text not null,
          $columnLocation text not null,
          $columnDescription text not null,
          $columnStarts text not null,
          $columnEnds text not null)
        ''');
      },
    );
  }

  Future<Event> insert(Event event) async {
    event.id = await db!.insert(tableEvent, event.toMap());
    return event;
  }

  Future<List<Event>?> getEvents() async {
    final _mapsResults = await db!.query(
      tableEvent,
      columns: [
        columnId,
        columnTitle,
        columnLocation,
        columnDescription,
        columnStarts,
        columnEnds
      ],
    );
    return _mapsResults.isNotEmpty ? _mapsResults.map((event) => Event.fromMap(event)).toList() : null;
  }

  Future<List<Event>?> getEventsByDate(String date) async {
    final _mapsResults = await db!.query(
      tableEvent,
      columns: [
        columnId,
        columnTitle,
        columnLocation,
        columnDescription,
        columnStarts,
        columnEnds
      ],
      where: '? BETWEEN strftime(\'%Y-%m-%d\', $columnStarts) AND strftime(\'%Y-%m-%d\', $columnEnds)',
      whereArgs: [date],
    );
    return _mapsResults.isNotEmpty ? _mapsResults.map((event) => Event.fromMap(event)).toList() : null;
  }

  Future<Event?> getEvent(int id) async {
    final _mapsResults = await db!.query(
      tableEvent,
      columns: [
        columnId,
        columnTitle,
        columnLocation,
        columnDescription,
        columnStarts,
        columnEnds
      ],
      where: '$columnId = ?',
      whereArgs: [id],
    );
    return _mapsResults.isNotEmpty ? Event.fromMap(_mapsResults.first) : null;
  }

  Future<int> delete(int id) async {
    return await db!.delete(
      tableEvent,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future<int> update(Event event) async {
    return await db!.update(
      tableEvent,
      event.toMap(),
      where: '$columnId = ?',
      whereArgs: [event.id],
    );
  }

  Future close() async => db!.close();
}
