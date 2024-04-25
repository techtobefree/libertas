import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_to_be_free/cubits/domain/user/cubit.dart';
import 'package:serve_to_be_free/data/events/handlers/event_handlers.dart';
import 'package:serve_to_be_free/data/projects/project_handlers.dart';
import 'package:serve_to_be_free/data/users/handlers/user_handlers.dart';
import 'package:serve_to_be_free/models/ModelProvider.dart';

class EventDetailsForm extends StatefulWidget {
  final String projectId;
  final String eventId;

  const EventDetailsForm({Key? key, required this.projectId, this.eventId = ''})
      : super(key: key);

  @override
  _EventDetailsFormState createState() => _EventDetailsFormState();
}

class _EventDetailsFormState extends State<EventDetailsForm> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  late UProject _project;
  UEvent? _event;

  final List<String> _states = [
    'Alabama',
    'Alaska',
    'Arizona',
    'Arkansas',
    'California',
    'Colorado',
    'Connecticut',
    'Delaware',
    'Florida',
    'Georgia',
    'Hawaii',
    'Idaho',
    'Illinois',
    'Indiana',
    'Iowa',
    'Kansas',
    'Kentucky',
    'Louisiana',
    'Maine',
    'Maryland',
    'Massachusetts',
    'Michigan',
    'Minnesota',
    'Mississippi',
    'Missouri',
    'Montana',
    'Nebraska',
    'Nevada',
    'New Hampshire',
    'New Jersey',
    'New Mexico',
    'New York',
    'North Carolina',
    'North Dakota',
    'Ohio',
    'Oklahoma',
    'Oregon',
    'Pennsylvania',
    'Rhode Island',
    'South Carolina',
    'South Dakota',
    'Tennessee',
    'Texas',
    'Utah',
    'Vermont',
    'Virginia',
    'Washington',
    'West Virginia',
    'Wisconsin',
    'Wyoming',
  ];

  String? _selectedState;

  @override
  void initState() {
    super.initState();
    _fetchProjectandEventData();
  }

  Future<void> _fetchProjectandEventData() async {
    // Simulating asynchronous data fetching

    // Assume fetchData() is an asynchronous method in UProject class
    UProject? project = await ProjectHandlers.getUProjectById(widget.projectId);
    UEvent? event;
    if (widget.eventId != '') {
      event = await EventHandlers.getUEventById(widget.eventId);
    }
    setState(() {
      if (project != null) {
        _project = project;
      } else {
        safePrint('project not found event page');
      }
      if (event != null) {
        _event = event;
      } else {
        safePrint('event not found');
      }
    });
    if (_event != null) {
      DateTime eventDate =
          DateTime.parse('${_event!.date ?? ''} ${_event!.time ?? ''}');
      _formKey.currentState?.patchValue({
        'eventName': _event!.name,
        'eventDetails': _event!.details,
        'eventDateTime': eventDate,
      });
    }
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
              FormBuilderTextField(
                name: 'streetAddress',
                decoration: InputDecoration(labelText: 'Street Address'),
              ),
              FormBuilderTextField(
                name: 'city',
                decoration: InputDecoration(labelText: 'City'),
              ),
              FormBuilderDropdown(
                name: 'state',
                decoration: InputDecoration(labelText: 'State'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
                items: _states
                    .map((state) => DropdownMenuItem(
                          value: state,
                          child: Text(state),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedState = value as String?;
                  });
                },
              ),
              FormBuilderTextField(
                name: 'zipCode',
                decoration: InputDecoration(labelText: 'Zip Code'),
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
      String streetAddress = formData['streetAddress'];
      String city = formData['city'];
      String state = formData['state'];
      String zipCode = formData['zipCode'];
      // Extract date and time
      int year = eventDateTime.year;
      String month = eventDateTime.month.toString().padLeft(2, '0');
      String day = eventDateTime.day.toString().padLeft(2, '0');
      String hour = eventDateTime.hour.toString().padLeft(2, '0');
      String minute = eventDateTime.minute.toString().padLeft(2, '0');

      print('Event Name: $eventName');
      print('Event Details: $eventDetails');
      print('Date: $year-$month-$day');
      print('Time: $hour:$minute');

      if (_event != null) {
        UEvent updatedEvent = _event!.copyWith(
          name: eventName,
          details: eventDetails,
          date: '$year-$month-$day',
          time: '$hour:$minute',
          streetAddress: streetAddress,
          city: city,
          state: state,
          zipCode: zipCode,
        );
        await EventHandlers.updateUEvent(updatedEvent);
      } else {
        UEvent uevent = UEvent(
            owner: await UserHandlers.getUUserById(
                BlocProvider.of<UserCubit>(context).state.id),
            uEventOwnerId: BlocProvider.of<UserCubit>(context).state.id,
            name: eventName,
            details: eventDetails,
            date: '$year-$month-$day',
            time: '$hour:$minute',
            membersAttending: [],
            membersNotAttending: [],
            streetAddress: streetAddress,
            city: city,
            state: state,
            zipCode: zipCode,
            project: _project);

        await ProjectHandlers.addEvent(widget.projectId, uevent);
      }

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
