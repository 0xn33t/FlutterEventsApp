import 'package:eventsapp/core/common/app_theme.dart';
import 'package:eventsapp/core/common/enums.dart';
import 'package:eventsapp/core/models/event_model.dart';
import 'package:eventsapp/core/providers/event_provider.dart';
import 'package:eventsapp/core/utils/ui_utils.dart';
import 'package:eventsapp/ui/screens/event_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:provider/provider.dart';

class EventOptions extends StatelessWidget {
  final Event event;

  EventOptions({required this.event});

  void _onEditEvent(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EventFormScreen(
          mode: EventMode.edit,
          event: event,
        ),
        fullscreenDialog: true,
      ),
    );
  }

  Future<void> _onDeleteEvent(BuildContext context) async {
    final _res = await context.read<EventProvider>().deleteEvent(event.id!);
    if (_res) {
      notifyUser(message: 'Event deleted successfully', success: true);
      Navigator.of(context).pop();
    } else {
      notifyUser(message: 'Faild to delete your event', success: false);
    }
  }

  ListTile _listTile({
    required String title,
    required IconData icon,
    required Function() onTap,
  }) {
    return ListTile(
      horizontalTitleGap: 0,
      minVerticalPadding: 0,
      contentPadding: EdgeInsets.all(0),
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(mainAppPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _listTile(
              icon: FlutterRemix.edit_2_line,
              title: 'Edit the event',
              onTap: () => _onEditEvent(context),
            ),
            _listTile(
              icon: FlutterRemix.delete_bin_3_line,
              title: 'Delete the event',
              onTap: () => _onDeleteEvent(context),
            ),
          ],
        ),
      ),
    );
  }
}
