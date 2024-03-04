import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_to_be_free/data/projects/project_handlers.dart';
import 'package:serve_to_be_free/models/ModelProvider.dart';

class EventDetailsForm extends StatefulWidget {
  final String projectId;

  const EventDetailsForm({Key? key, required this.projectId}) : super(key: key);

  @override
  _EventDetailsFormState createState() => _EventDetailsFormState();
}

class _EventDetailsFormState extends State<EventDetailsForm> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  late UProject _project;
  void initState() {
    super.initState();
    _fetchProjectData();
  }

  Future<void> _fetchProjectData() async {
    // Simulating asynchronous data fetching

    // Assume fetchData() is an asynchronous method in UProject class
    UProject? project = await ProjectHandlers.getUProjectById(widget.projectId);
    setState(() {
      if (project != null) {
        _project = project;
      } else {
        safePrint('project not found event page');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              FormBuilderTextField(
                name: 'eventName',
                decoration: InputDecoration(labelText: 'Event Name'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              FormBuilderTextField(
                name: 'eventDetails',
                decoration: InputDecoration(labelText: 'Event Details'),
              ),
              FormBuilderDateTimePicker(
                name: 'eventDateTime',
                inputType: InputType.both,
                decoration: InputDecoration(labelText: 'Date & Time'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.saveAndValidate()) {
                    final formData = _formKey.currentState!.value;
                    _submitForm(formData);
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submitForm(Map<String, dynamic> formData) async {
    print(formData); // Print all form data
    if (_project != null) {
      // Extract form data
      String eventName = formData['eventName'];
      String eventDetails = formData['eventDetails'];
      DateTime eventDateTime = formData['eventDateTime'];

      // Extract date and time
      int year = eventDateTime.year;
      String month = eventDateTime.month.toString().padLeft(2, '0');
      String day = eventDateTime.day.toString().padLeft(2, '0');
      int hour = eventDateTime.hour;
      int minute = eventDateTime.minute;

      print('Event Name: $eventName');
      print('Event Details: $eventDetails');
      print('Date: $year-$month-$day');
      print('Time: $hour:$minute');
      UEvent uevent = UEvent(
          name: eventName,
          details: eventDetails,
          date: '$year-$month-$day',
          time: '$hour:$minute',
          membersAttending: [],
          membersNotAttending: [],
          project: _project);
      await ProjectHandlers.addEvent(widget.projectId, uevent);

      // Button action goes here
      // ignore: use_build_context_synchronously
      context.pushNamed("projectevents", queryParameters: {
        'projectId': widget.projectId,
      }, pathParameters: {
        'projectId': widget.projectId
      });
    }
  }
}
