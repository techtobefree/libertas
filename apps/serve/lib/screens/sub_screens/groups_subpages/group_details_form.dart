import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_validator/form_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:serve_to_be_free/cubits/domain/user/cubit.dart';
import 'package:serve_to_be_free/data/groups/group_handlers.dart';

import '../../../models/ModelProvider.dart';

class GroupDetailsForm extends StatefulWidget {
  const GroupDetailsForm({Key? key}) : super(key: key);

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
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Group Name",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w600),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 12),
                              child: FormBuilderTextField(
                                name: 'name',
                                validator: ValidationBuilder()
                                    .required()
                                    .minLength(3)
                                    .maxLength(50)
                                    .build(),
                                decoration: _fieldDecoration('Group Name'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(color: Colors.grey, thickness: 0.5),
                      Container(
                        padding: const EdgeInsets.all(30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Privacy",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w600),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 12),
                              child: FormBuilderDropdown<String>(
                                name: 'privacy',
                                decoration: _fieldDecoration("Privacy"),
                                validator:
                                    ValidationBuilder().required().build(),
                                items: const [
                                  DropdownMenuItem(
                                      value: 'Private', child: Text('Private')),
                                  DropdownMenuItem(
                                      value: 'Public', child: Text('Public')),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(color: Colors.grey, thickness: 0.5),
                      Container(
                        padding: const EdgeInsets.all(30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Short Description",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w600),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 12),
                              child: FormBuilderTextField(
                                name: 'bio',
                                decoration:
                                    _fieldDecoration('Short Description'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(color: Colors.grey, thickness: 0.5),
                      Container(
                        padding: const EdgeInsets.all(30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Detailed Description",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w600),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 12),
                              child: FormBuilderTextField(
                                name: 'description',
                                decoration:
                                    _fieldDecoration('Detailed Description'),
                                validator:
                                    ValidationBuilder().required().build(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(color: Colors.grey, thickness: 0.5),
                      Container(
                        padding: const EdgeInsets.all(30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Group Photo",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w600),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: FormBuilderImagePicker(
                                name: 'groupPicture',
                                decoration: _fieldDecoration('Group Photo'),
                                validator: listValidator,
                                maxImages: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(color: Colors.grey, thickness: 0.5),
                      Container(
                        padding: const EdgeInsets.all(30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "City",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w600),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 12),
                              child: FormBuilderTextField(
                                name: 'city',
                                decoration: _fieldDecoration('City'),
                                validator:
                                    ValidationBuilder().required().build(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(color: Colors.grey, thickness: 0.5),
                      Container(
                        padding: const EdgeInsets.all(30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "State",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w600),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 12),
                              child: FormBuilderDropdown<String>(
                                name: 'state',
                                decoration: _fieldDecoration('State'),
                                validator:
                                    ValidationBuilder().required().build(),
                                items: _states
                                    .map((state) => DropdownMenuItem(
                                          value: state,
                                          child: Text(state),
                                        ))
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(color: Colors.grey, thickness: 0.5),
                      Container(
                        padding: const EdgeInsets.all(30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Zip Code",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w600),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 12),
                              child: FormBuilderTextField(
                                name: 'zipCode',
                                decoration: _fieldDecoration('Zip Code'),
                                validator: ValidationBuilder()
                                    .required()
                                    .maxLength(5)
                                    .minLength(5)
                                    // .length(5)
                                    .regExp(RegExp(r'^\d{5}$'),
                                        'Enter a valid 5-digit zip code')
                                    .build(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.saveAndValidate()) {
                            final formData = _formKey.currentState!.value;
                            _submitForm(formData);
                          }
                        },
                        child: const Text('Create Group'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? listValidator(List<dynamic>? value) {
    final validator =
        ValidationBuilder().required('Please select an Image').build();
    return validator(value != null && value.isNotEmpty ? 'selected' : null);
  }

  InputDecoration _fieldDecoration(hintText) {
    return InputDecoration(
      hintText: hintText,
      // For some reason this does not work if I am only styling one or two borders. So I specified all 4 down below.
      // border: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(10),
      //     borderSide: BorderSide.none),
      contentPadding: const EdgeInsets.all(16),
      fillColor: Colors.grey[200],
      filled: true,
      // Many other way to customize this to make it feel interactive, otherwise the enabledBorder and the focusedBorder can just be deleted.
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
      errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10)),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 2,
        ),
      ),
      errorStyle: const TextStyle(fontSize: 12, color: Colors.red),
    );
  }

  Future<void> _submitForm(Map<String, dynamic> formData) async {
    print(formData); // Print all form data
    const bucketName = 'servetobefree-images-dev';
    const region = 'us-east-1';
    const url = 'https://$bucketName.s3.$region.amazonaws.com';

    debugPrint(url);
    DateTime now = DateTime.now();
    String timestamp = now.millisecondsSinceEpoch.toString();

    final selectedFile = formData['groupPicture'][0];

    if (selectedFile != null) {
      if (selectedFile != imageCache) {
        final file = File(selectedFile.path);

        final url = await uploadImageToS3(
            file, 'servetobefree-images', formData['name'], timestamp);

        UGroup newGroup = UGroup(
            name: formData['name'],
            privacy: formData['privacy'],
            description: formData['description'],
            leader: BlocProvider.of<UserCubit>(context).state.id,
            members: [BlocProvider.of<UserCubit>(context).state.id],
            projects: [],
            bio: formData['bio'],
            city: formData['city'],
            state: formData['state'],
            zipCode: formData['zipCode'],
            groupPicture: url);
        var createdGroup = await GroupHandlers.createGroup(newGroup);
        if (createdGroup != null) {
          // ignore: use_build_context_synchronously
          context.go('/groups');
        }
      }
    }
  }

  Future<String> uploadImageToS3(
      File imageFile, String bucketName, String groupName, String timestamp,
      {String region = 'us-east-1'}) async {
    final key = '/GroupImages/$groupName/$timestamp';
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
