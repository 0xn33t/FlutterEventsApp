import 'package:eventsapp/core/common/app_theme.dart';
import 'package:eventsapp/core/common/enums.dart';
import 'package:eventsapp/core/common/environment.dart';
import 'package:eventsapp/core/models/event_model.dart';
import 'package:eventsapp/core/providers/event_provider.dart';
import 'package:eventsapp/core/utils/date_utils.dart';
import 'package:eventsapp/core/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum _DateTimeField { start, end }

class EventFormScreen extends StatefulWidget {
  final EventMode mode;
  final Event? event;

  EventFormScreen({required this.mode, this.event});

  @override
  _EventFormScreenState createState() => _EventFormScreenState();
}

class _EventFormScreenState extends State<EventFormScreen> {
  final _form = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _startDateTimeController = TextEditingController();
  final _endDateTimeController = TextEditingController();

  bool get _isEditing => (widget.mode == EventMode.edit);

  bool _enableSubmit = true;

  @override
  void initState() {
    super.initState();
    if (_isEditing) {
      final _event = widget.event!;
      _titleController.text = _event.title;
      _locationController.text = _event.location;
      _descriptionController.text = _event.description;
      _startDateTimeController.text = _event.starts.format(dateTimePattern);
      _endDateTimeController.text = _event.ends.format(dateTimePattern);
    }
  }

  Future<void> _onFormSubmitted() async {
    if (_form.currentState!.validate()) {
      setState(() => _enableSubmit = false);
      final _event = Event(
        title: _titleController.text,
        location: _locationController.text,
        description: _descriptionController.text,
        starts: DateTime.parse(_startDateTimeController.text),
        ends: DateTime.parse(_endDateTimeController.text),
      );

      if (_isEditing) {
        _event.id = widget.event!.id;
      }

      final _res = await context
          .read<EventProvider>()
          .eventFormOperation(_event, widget.mode);
      if (_res) {
        notifyUser(
            message: _isEditing
                ? 'Event updated successfully'
                : 'Event added successfully',
            success: true);
        Navigator.of(context).pop();
      } else {
        notifyUser(
            message: _isEditing
                ? 'Faild to update your event'
                : 'Faild to add your event',
            success: false);
      }

      setState(() => _enableSubmit = true);
    }
  }

  Future<void> _onDateTimePicker({
    required TextEditingController controller,
    required _DateTimeField field,
  }) async {
    var _initialDate = DateTime.now();
    var _initialTime = TimeOfDay.now();
    if (_isEditing) {
      final _event = widget.event!;
      if (field == _DateTimeField.start) {
        _initialDate = _event.starts;
        _initialTime = TimeOfDay.fromDateTime(_event.starts);
      } else {
        _initialDate = _event.ends;
        _initialTime = TimeOfDay.fromDateTime(_event.ends);
      }
    }

    var _dateSelected = await showDatePicker(
      context: context,
      initialDate: _initialDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (_dateSelected == null) return;
    final _timeSelected = await showTimePicker(
      context: context,
      initialTime: _initialTime,
      initialEntryMode: TimePickerEntryMode.input,
    );
    if (_timeSelected == null) return;
    final _dateTimeSelected = _dateSelected.add(Duration(
      hours: _timeSelected.hour,
      minutes: _timeSelected.minute,
    ));
    setState(() {
      controller.text = _dateTimeSelected.format(dateTimePattern);
    });
  }

  InputDecoration _fieldDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(fontSize: 13),
      border: OutlineInputBorder(),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1,
          color: Colors.black12,
        ),
      ),
      contentPadding: const EdgeInsets.all(15),
      alignLabelWithHint: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(!_isEditing ? 'Add New Event' : 'Edit event'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(mainAppPadding),
          child: Form(
            key: _form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: TextFormField(
                    controller: _titleController,
                    decoration: _fieldDecoration('Title'),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      return value == null || value.isEmpty
                          ? 'Title is required'
                          : null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: TextFormField(
                    controller: _locationController,
                    decoration: _fieldDecoration('Location'),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      return value == null || value.isEmpty
                          ? 'Location is required'
                          : null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: TextFormField(
                    controller: _descriptionController,
                    decoration: _fieldDecoration('Description'),
                    keyboardType: TextInputType.multiline,
                    maxLines: 4,
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      return value == null || value.isEmpty
                          ? 'Description is required'
                          : null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: TextFormField(
                    controller: _startDateTimeController,
                    decoration: _fieldDecoration('Starts'),
                    keyboardType: TextInputType.datetime,
                    textInputAction: TextInputAction.done,
                    readOnly: true,
                    onTap: () => _onDateTimePicker(
                      controller: _startDateTimeController,
                      field: _DateTimeField.start,
                    ),
                    validator: (value) {
                      return value == null || value.isEmpty
                          ? 'Starting date and time are required'
                          : null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: TextFormField(
                    controller: _endDateTimeController,
                    decoration: _fieldDecoration('Ends'),
                    keyboardType: TextInputType.datetime,
                    textInputAction: TextInputAction.done,
                    readOnly: true,
                    onTap: () => _onDateTimePicker(
                      controller: _endDateTimeController,
                      field: _DateTimeField.end,
                    ),
                    validator: (value) {
                      return value == null || value.isEmpty
                          ? 'Ending date and time are required'
                          : null;
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: _enableSubmit ? _onFormSubmitted : null,
                  child: Text(!_isEditing
                      ? 'Add Event'
                      : 'Edit Event'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
