import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_validator/form_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
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
  bool _isLoading = false;
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  late UProject _project;
  UEvent? _event;
  XFile? unchangedImage;

  String? dateValidator(DateTime? value) {
    if (value == null) {
      return 'This field is required';
    }
    return null;
  }

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

  Future<Uint8List?> fetchImageFromUrl(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Failed to load image');
    }
  }

  Future<void> _fetchProjectandEventData() async {
    setState(() {
      _isLoading = true;
    });
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

      if (_event!.eventPicture != null && _event!.eventPicture != "") {
        fetchImageFromUrl(_event!.eventPicture ?? "").then((uint8List) {
          XFile xFile = XFile.fromData(uint8List!);
          setState(() {
            unchangedImage = xFile;
          });
          _formKey.currentState?.patchValue({
            'eventPicture': [xFile]
          });
        });
      }

      _formKey.currentState?.patchValue({
        'eventName': _event!.name,
        'eventDetails': _event!.details,
        'streetAddress': _event!.streetAddress,
        'city': _event!.city,
        'state': _event!.state,
        'zipCode': _event!.zipCode,
        'eventDateTime': eventDate,
      });
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Details'),
      ),
      body: Stack(
        children: [
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: FormBuilder(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    FormBuilderTextField(
                      name: 'eventName',
                      decoration: InputDecoration(labelText: 'Event Name'),
                      validator: ValidationBuilder().required().build(),
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
                      validator: ValidationBuilder().required().build(),
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
                      validator: dateValidator,
                    ),
                    const SizedBox(height: 20),
                    FormBuilderImagePicker(
                      name: "eventPicture",
                      decoration: const InputDecoration(
                        labelText: 'Event Image (optional)',
                        // border: OutlineInputBorder(
                        //   borderSide: BorderSide.none,
                        // ),
                      ),
                      // validator: FormBuilderValidators.compose([
                      //   FormBuilderValidators.required(),
                      // ]),
                      // fit: BoxFit.cover,
                      maxImages: 1,
                    ),
                    SizedBox(height: 20),
                    if (widget.eventId != '')
                      ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            _isLoading = true;
                          });
                          bool? confirmDelete = await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Confirm Delete'),
                                content: Text(
                                    'Are you sure you want to delete this event?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(false); // Cancel
                                    },
                                    child: Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(true); // Confirm
                                    },
                                    child: Text('Confirm'),
                                  ),
                                ],
                              );
                            },
                          );

                          if (confirmDelete == true) {
                            await EventHandlers.deleteUEventfromId(
                                widget.eventId);
                            context.pushNamed(
                              "projectevents",
                              queryParameters: {
                                'projectId': widget.projectId,
                              },
                              pathParameters: {
                                'projectId': widget.projectId,
                              },
                            );
                          }
                          setState(() {
                            _isLoading = true;
                          });
                        },
                        child: Text('Delete'),
                      ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.saveAndValidate()) {
                          final formData = _formKey.currentState!.value;
                          _submitForm(formData, _event!.eventPicture ?? "");
                        }
                      },
                      child: Text('Submit'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _submitForm(
      Map<String, dynamic> formData, String oldImageUrl) async {
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

      const bucketName = 'servetobefree-images-dev';
      const region = 'us-east-1';
      const url = 'https://$bucketName.s3.$region.amazonaws.com';
      DateTime now = DateTime.now();
      String timestamp = now.millisecondsSinceEpoch.toString();

      var finalUrl = oldImageUrl;
      print(unchangedImage);

      if (formData['eventPicture'] != null &&
          formData['eventPicture'].length > 0 &&
          unchangedImage != formData['eventPicture'][0]) {
        final selectedFile = formData['eventPicture'][0];

        finalUrl = url;
        if (selectedFile != null) {
          if (selectedFile != imageCache) {
            final file = File(selectedFile.path);

            finalUrl = await uploadImageToS3(file, 'servetobefree-images',
                BlocProvider.of<UserCubit>(context).state.id, timestamp);
          }
        }
      }

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
          eventPicture: finalUrl,
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
          project: _project,
          eventPicture: finalUrl,
        );

        await ProjectHandlers.addEvent(widget.projectId, uevent);
      }

      // Button action goes here
      context.pushNamed("projectevents", queryParameters: {
        'projectId': widget.projectId,
      }, pathParameters: {
        'projectId': widget.projectId
      });
    }
  }

  Future<String> uploadImageToS3(
      File imageFile, String bucketName, String projName, String timestamp,
      {String region = 'us-east-1'}) async {
    final key = '/ProjectImages/$projName/$timestamp';
    final url = 'https://servetobefree-images-dev.s3.amazonaws.com/$key'
        .replaceAll('+', '%20');
    final response = await http.put(Uri.parse(url),
        headers: {'Content-Type': 'image/jpeg'},
        body: await imageFile.readAsBytes());
    if (response.statusCode != 200) {
      throw Exception('Failed to upload image to S3');
    }
    return url;
  }
}
