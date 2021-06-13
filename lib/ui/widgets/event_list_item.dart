import 'package:eventsapp/core/models/event_model.dart';
import 'package:eventsapp/ui/widgets/event_card.dart';
import 'package:flutter/material.dart';

class EventListItem extends StatelessWidget {

  final String startTime;
  final List<Event> events;

  EventListItem({
    required this.startTime,
    required this.events,
  });

  @override
  Widget build(BuildContext context) {
    final _time = startTime.split(' ');
    return Container(
      margin: const EdgeInsets.only(top: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsetsDirectional.only(end: 8),
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                ),
                height: 10,
                width: 20,
              ),
              Text(
                _time[0],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 4),
              Text(
                _time[1],
                style: TextStyle(color: Theme.of(context).textTheme.caption!.color),
              ),
            ],
          ),
          ...events.map((Event event) => EventCard(event: event,)),
        ],
      ),
    );
  }
}