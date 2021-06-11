import 'package:eventsapp/core/common/app_color.dart';
import 'package:eventsapp/core/common/app_theme.dart';
import 'package:eventsapp/core/common/enums.dart';
import 'package:eventsapp/core/models/event_model.dart';
import 'package:eventsapp/core/providers/event_provider.dart';
import 'package:eventsapp/ui/screens/event_form_screen.dart';
import 'package:eventsapp/ui/widgets/data_loading.dart';
import 'package:eventsapp/ui/widgets/event_list_item.dart';
import 'package:eventsapp/ui/widgets/ui_message.dart';
import 'package:eventsapp/core/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Events'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _DateToolbar(),
          Expanded(
            child: FutureBuilder(
              future: context.read<EventProvider>().loadEvents(),
              builder: (BuildContext context,
                  AsyncSnapshot<Map<String, List<Event>>?> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return DataLoading();
                } else {
                  if (snapshot.error != null) {
                    return UiMessage(message: 'Failed to load your events');
                  } else {
                    return Selector<EventProvider, Map<String, List<Event>>?>(
                      selector: (_, model) => model.events,
                      builder: (_, _eventsData, __) {
                        if (_eventsData == null) {
                          return UiMessage(
                              message: 'Failed to load your events');
                        }

                        if (_eventsData.isEmpty) {
                          return UiMessage(
                            message: 'No events found on the selected date',
                            messageColor: Colors.orange[700],
                          );
                        }

                        return ListView.builder(
                          itemCount: _eventsData.length,
                          itemBuilder: (BuildContext context, int index) {
                            final _key = _eventsData.keys.elementAt(index);
                            final _events = _eventsData[_key]!;
                            return EventListItem(
                              startTime: _key,
                              events: _events,
                            );
                          },
                        );
                      },
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => EventFormScreen(
                    mode: EventMode.add,
                  ),
              fullscreenDialog: true));
          // Add your onPressed code here!
        },
        child: const Icon(FlutterRemix.add_line),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class _DateToolbar extends StatelessWidget {
  Future<void> _onChangeSelectedDate(BuildContext context) async {
    final _date = await showDatePicker(
      context: context,
      initialDate: context.read<EventProvider>().selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (_date != null) {
      context.read<EventProvider>().changeDate(_date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(mainAppPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Selector<EventProvider, DateTime>(
            selector: (_, model) => model.selectedDate,
            builder: (_, date, __) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    date.format('MMM, d'),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(width: 6),
                  Text(
                    date.year.toString(),
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.metaColor,
                    ),
                  ),
                ],
              );
            },
          ),
          GestureDetector(
            onTap: () => _onChangeSelectedDate(context),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                color: Color(0xFFe3e7fa),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                'Change',
                style: TextStyle(
                  fontSize: 11,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
