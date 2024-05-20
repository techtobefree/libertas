import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_validator/form_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_to_be_free/cubits/domain/user/cubit.dart';
import 'package:serve_to_be_free/data/events/handlers/event_handlers.dart';
import 'package:serve_to_be_free/data/projects/project_handlers.dart';
import 'package:serve_to_be_free/data/users/handlers/user_handlers.dart';
import 'package:serve_to_be_free/models/ModelProvider.dart';

class GroupDetailsForm extends StatefulWidget {

  const GroupDetailsForm({Key? key})
      : super(key: key);

  @override
  _GroupDetailsFormState createState() => _GroupDetailsFormState();
}

class _GroupDetailsFormState extends State<GroupDetailsForm> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();


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
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Group Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
      FormBuilderTextField(
        name: 'name',
        decoration: InputDecoration(labelText: 'Group Name'),
        validator: ValidationBuilder().required().build(),
      ),
      FormBuilderTextField(
        name: 'privacy',
        decoration: InputDecoration(labelText: 'Privacy'),
        validator: ValidationBuilder().required().build(),
      ),
      FormBuilderTextField(
        name: 'bio',
        decoration: InputDecoration(labelText: 'Short Description'),
      ),
      FormBuilderTextField(
        name: 'description',
        decoration: InputDecoration(labelText: 'Detailed Description'),
        validator: ValidationBuilder().required().build(),
      ),
      FormBuilderTextField(
        name: 'city',
        decoration: InputDecoration(labelText: 'City'),
      ),
      FormBuilderDropdown<String>(
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
        name: 'leader',
        decoration: InputDecoration(labelText: 'Leader'),
      ),
      FormBuilderTextField(
        name: 'zipCode',
        decoration: InputDecoration(labelText: 'Zip Code'),
      ),
      FormBuilderTextField(
        name: 'groupPicture',
        decoration: InputDecoration(labelText: 'Group Picture URL'),
        validator: ValidationBuilder().required().build(),
      ),
      ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.saveAndValidate()) {
            final formData = _formKey.currentState!.value;
            _submitForm(formData);
          }
        },
        child: Text('Create Group'),
      ),
    ],
          ),
        ),
      ),
    );
  }

  Future<void> _submitForm(Map<String, dynamic> formData) async {
    // print(formData); // Print all form data
    // if (_project != null) {
    //   // Extract form data
    //   String eventName = formData['eventName'];
    //   String eventDetails = formData['eventDetails'];
    //   DateTime eventDateTime = formData['eventDateTime'];
    //   String streetAddress = formData['streetAddress'];
    //   String city = formData['city'];
    //   String state = formData['state'];
    //   String zipCode = formData['zipCode'];
    //   // Extract date and time
    //   int year = eventDateTime.year;
    //   String month = eventDateTime.month.toString().padLeft(2, '0');
    //   String day = eventDateTime.day.toString().padLeft(2, '0');
    //   String hour = eventDateTime.hour.toString().padLeft(2, '0');
    //   String minute = eventDateTime.minute.toString().padLeft(2, '0');

    //   print('Group Name: $eventName');
    //   print('Group Details: $eventDetails');
    //   print('Date: $year-$month-$day');
    //   print('Time: $hour:$minute');

      
    //     UGroup uevent = UGroup(
    //         owner: await UserHandlers.getUUserById(
    //             BlocProvider.of<UserCubit>(context).state.id),
    //         uGroupOwnerId: BlocProvider.of<UserCubit>(context).state.id,
    //         name: eventName,
    //         details: eventDetails,
    //         date: '$year-$month-$day',
    //         time: '$hour:$minute',
    //         membersAttending: [],
    //         membersNotAttending: [],
    //         streetAddress: streetAddress,
    //         city: city,
    //         state: state,
    //         zipCode: zipCode,
    //         project: _project);

    //     await GroupHandlers.addGroup(widget.projectId, uevent);
    //   }

    //   // Button action goes here
    //   // ignore: use_build_context_synchronously
    //   context.pushNamed("projectevents", queryParameters: {
    //     'projectId': widget.projectId,
    //   }, pathParameters: {
    //     'projectId': widget.projectId
    //   });
    }
  
}
