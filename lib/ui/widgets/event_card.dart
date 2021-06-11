import 'package:eventsapp/core/common/app_color.dart';
import 'package:eventsapp/core/common/app_theme.dart';
import 'package:eventsapp/core/models/event_model.dart';
import 'package:eventsapp/ui/widgets/event_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

class EventCard extends StatelessWidget {
  final Event event;

  EventCard({required this.event});

  void _onEventOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: modalSheetShape,
      isScrollControlled: true,
      builder: (_) => EventOptions(event: event),
    );
  }

  Widget _eventMetaListItem({
    required IconData icon,
    required String text,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 18,
          color: AppColors.secondaryColor,
        ),
        const SizedBox(
          width: 6,
        ),
        Text(
          text,
          style: TextStyle(fontSize: 13),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(right: 20, left: 20, top: 12),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.borderColor),
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  event.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => _onEventOptions(context),
                child: Icon(
                  FlutterRemix.more_2_fill,
                  size: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            event.description,
            style: TextStyle(
              color: AppColors.metaColor,
            ),
          ),
          const SizedBox(height: 12),
          _eventMetaListItem(
            icon: FlutterRemix.time_line,
            text: event.eventTime(),
          ),
          const SizedBox(height: 6),
          _eventMetaListItem(
            icon: FlutterRemix.map_pin_line,
            text: event.location,
          ),
        ],
      ),
    );
  }
}
