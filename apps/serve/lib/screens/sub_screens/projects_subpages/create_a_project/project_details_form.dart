import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_to_be_free/widgets/buttons/solid_rounded_button.dart';
import 'package:provider/provider.dart';

import 'package:serve_to_be_free/data/users/providers/user_provider.dart';

class ProjectDetailsForm extends StatefulWidget {
  final String _path; // private variable
  ProjectDetailsForm({Key? key, required String path})
      : _path = path, // initialize the private variable
        super(key: key);

  @override
  _ProjectDetailsFormState createState() => _ProjectDetailsFormState();
}

class _ProjectDetailsFormState extends State<ProjectDetailsForm> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final List<String> privacyOptions = ['Friends', 'Public'];

  String _selectedState = '';

  Future<void> _submitForm() async {
    // a null check on here?
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      _formKey.currentState!.save();

      final bucketName = 'servetobefree-images';
      final region = 'us-east-1';
      final url = 'https://$bucketName.s3.$region.amazonaws.com';

      debugPrint(url);

      // final response = await http.head(Uri.parse(url));

      final formData = _formKey.currentState!.value;
      final selectedFile = formData['projectImage'][0];
      DateTime now = DateTime.now();
      String timestamp = now.millisecondsSinceEpoch.toString();

      if (selectedFile != null) {
        final file = File(selectedFile.path);

        await uploadImageToS3(
            file, 'servetobefree-images', formData['projectName'], timestamp);
      }
      final imageURL =
          'https://$bucketName.s3.$region.amazonaws.com/ServeToBeFree/ProfilePictures/${formData['projectName']}/$timestamp';

      final posturl = Uri.parse('http://44.203.120.103:3000/projects');
      // final posturl = Uri.parse('http://10.0.2.2:3000/projects');

      final headers = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      };
      var members =
          jsonEncode([Provider.of<UserProvider>(context, listen: false).id]);
      final postResponse = await http.post(
        posturl,
        headers: headers,
        body: jsonEncode(
          <String, String>{
            'name': formData['projectName'],
            'description': formData['projectDescription'],
            'privacy': formData['privacy'],
            'date': formData['projectDate'].toString().split(' ')[0],
            'projectPhoto':
                // 'data:image/jpeg;base64,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'
                imageURL,
            'city': formData['city'],
            'state': formData['state'],
            'bio': formData['projectBio']
          },
        ),
      );
      print(postResponse);
      // //Check the response status code
      if (postResponse.statusCode == 201) {
        // Success
        var projId = jsonDecode(postResponse.body)['_id'];
        addMember(projId);
        context.goNamed("projectdetails", params: {'id': projId});
      } else {
        print('failed');
      }
      // Make it so the context only goes if the s3 upload is successful
      // context.go(widget._path);
    }
  }

  Future<void> uploadImageToS3(
      File imageFile, String bucketName, String projName, String timestamp,
      {String region = 'us-east-1'}) async {
    final key = 'ServeToBeFree/ProfilePictures/$projName/$timestamp';
    final url =
        'https://$bucketName.s3.amazonaws.com/$key'.replaceAll('+', '%20');
    final response = await http.put(Uri.parse(url),
        headers: {'Content-Type': 'image/jpeg'},
        body: await imageFile.readAsBytes());
    if (response.statusCode != 200) {
      throw Exception('Failed to upload image to S3');
    }
  }

  Future<void> addMember(projId) async {
    final url =
        Uri.parse('http://44.203.120.103:3000/projects/${projId}/member');
    final Map<String, dynamic> data = {
      'memberId': Provider.of<UserProvider>(context, listen: false).id
    };
    final response = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      // API call successful\
    } else {
      // API call unsuccessful
      print('Failed to fetch data');
    }
  }

  InputDecoration _fieldDecoration(_hintText) {
    return InputDecoration(
      hintText: _hintText,
      // For some reason this does not work if I am only styling one or two borders. So I specified all 4 down below.
      // border: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(10),
      //     borderSide: BorderSide.none),
      contentPadding: EdgeInsets.all(16),
      fillColor: Colors.grey[200],
      filled: true,
      // Many other way to customize this to make it feel interactive, otherwise the enabledBorder and the focusedBorder can just be deleted.
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
      errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10)),
      focusedErrorBorder: new OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: Colors.red,
          width: 2,
        ),
      ),
      errorStyle: TextStyle(fontSize: 12, color: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    String? _selectedState;

    return Scaffold(
        appBar: AppBar(
            title: const Text('Project Details'),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(0, 28, 72, 1.0),
                    Color.fromRGBO(35, 107, 140, 1.0),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            )),
        body: SingleChildScrollView(
            child: Container(
                child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Project Name",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 12),
                      child: FormBuilderTextField(
                          name: 'projectName',
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.minLength(3),
                            FormBuilderValidators.maxLength(50),
                            FormBuilderValidators.match(
                              r'^[a-zA-Z0-9 ]+$',
                              errorText:
                                  'Only alphanumeric characters are allowed',
                            ),
                          ]),
                          decoration: _fieldDecoration("Project Name")),
                    ),
                  ],
                ),
              ),
              Divider(
                //height: 1,
                color: Colors.grey,
                thickness: 0.5,
              ),
              Container(
                padding: EdgeInsets.all(30),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Date",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: FormBuilderDateTimePicker(
                            name: 'projectDate',
                            inputType: InputType.date,
                            validator: FormBuilderValidators.compose(
                                [FormBuilderValidators.required()]),
                            decoration: _fieldDecoration("Date")),
                      ),
                    ]),
              ),
              Divider(
                //height: 1,
                color: Colors.grey,
                thickness: 0.5,
              ),
              Container(
                padding: EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Privacy",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 12),
                      // decoration: BoxDecoration(
                      //   color: Colors.grey[200],
                      //   borderRadius: BorderRadius.circular(10),
                      // ),
                      child: FormBuilderDropdown<String>(
                        name: 'privacy',
                        decoration: _fieldDecoration("Project Privacy"),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                        elevation: 2,
                        iconSize: 30,
                        isExpanded: true,
                        //Right here we just have to map it to make them DropdownMenuItems instead of strings
                        items: privacyOptions
                            .map((option) => DropdownMenuItem(
                                  alignment: AlignmentDirectional.center,
                                  value: option,
                                  child: Text(option),
                                ))
                            .toList(),
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                //height: 1,
                color: Colors.grey,
                thickness: 0.5,
              ),
              Container(
                padding: EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Project Photo",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                    ),
                    Container(
                      child: Align(
                        alignment: Alignment.topLeft,
                        // child: Container(
                        //   width: 100,
                        child: FormBuilderImagePicker(
                          name: "projectImage",
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            //errorText: 'Please select an image',
                            // errorBorder: OutlineInputBorder(
                            //   borderRadius: BorderRadius.circular(10),
                            //   borderSide:
                            //       BorderSide(color: Colors.red, width: 2),
                            // ),
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                              errorText: 'Please select an Image',
                            ),
                          ]),

                          // previewHeight: 100,
                          // previewWidth: 100,
                          //previewAutoSizeWidth: true,
                          fit: BoxFit.cover,
                          maxImages: 1,
                        ),
                      ),
                    ),
                    //),
                  ],
                ),
              ),
              Divider(
                //height: 1,
                color: Colors.grey,
                thickness: 0.5,
              ),
              Container(
                padding: EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 15),
                      child: Text(
                        "State",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600),
                      ),
                    ),
                    // Container(
                    //   child: Align(
                    //     alignment: Alignment.topLeft,
                    //     // child: Container(
                    //     //   width: 100,
                    //     child: FormBuilderDropdown<String>(
                    //       name: 'state',
                    //       hint: Text('Select state'),
                    //       items: [
                    //         'Alabama',
                    //         'Alaska',
                    //         'Arizona',
                    //         'Arkansas',
                    //         'California',
                    //         'Colorado',
                    //         'Connecticut',
                    //         'Delaware',
                    //         'Florida',
                    //         'Georgia',
                    //         'Hawaii',
                    //         'Idaho',
                    //         'Illinois',
                    //         'Indiana',
                    //         'Iowa',
                    //         'Kansas',
                    //         'Kentucky',
                    //         'Louisiana',
                    //         'Maine',
                    //         'Maryland',
                    //         'Massachusetts',
                    //         'Michigan',
                    //         'Minnesota',
                    //         'Mississippi',
                    //         'Missouri',
                    //         'Montana',
                    //         'Nebraska',
                    //         'Nevada',
                    //         'New Hampshire',
                    //         'New Jersey',
                    //         'New Mexico',
                    //         'New York',
                    //         'North Carolina',
                    //         'North Dakota',
                    //         'Ohio',
                    //         'Oklahoma',
                    //         'Oregon',
                    //         'Pennsylvania',
                    //         'Rhode Island',
                    //         'South Carolina',
                    //         'South Dakota',
                    //         'Tennessee',
                    //         'Texas',
                    //         'Utah',
                    //         'Vermont',
                    //         'Virginia',
                    //         'Washington',
                    //         'West Virginia',
                    //         'Wisconsin',
                    //         'Wyoming'
                    //       ]
                    //           .map((state) => DropdownMenuItem(
                    //                 value: state,
                    //                 child: Text('$state'),
                    //               ))
                    //           .toList(),
                    //       validator: FormBuilderValidators.required(),
                    //       onChanged: (state) => _selectedState = state,
                    //     ),
                    //   ),
                    // ),
                    FormBuilderDropdown<String>(
                      name: 'state',
                      decoration: _fieldDecoration("State"),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                      elevation: 2,
                      iconSize: 30,
                      isExpanded: true,
                      //Right here we just have to map it to make them DropdownMenuItems instead of strings
                      items: [
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
                        'Wyoming'
                      ]
                          .map((state) => DropdownMenuItem(
                                alignment: AlignmentDirectional.center,
                                value: state,
                                child: Text(state),
                              ))
                          .toList(),
                    ),
                    //),
                  ],
                ),
              ),
              Divider(
                //height: 1,
                color: Colors.grey,
                thickness: 0.5,
              ),
              Container(
                padding: EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "City",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 12),
                      child: FormBuilderTextField(
                          name: 'city',
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.minLength(3),
                            FormBuilderValidators.maxLength(50),
                            FormBuilderValidators.match(
                              r'^[a-zA-Z0-9 ]+$',
                              errorText:
                                  'Only alphanumeric characters are allowed',
                            ),
                          ]),
                          decoration: _fieldDecoration("City")),
                    ),
                  ],
                ),
              ),
              Divider(
                //height: 1,
                color: Colors.grey,
                thickness: 0.5,
              ),
              Container(
                padding: EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Project Bio",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          // width: 350,
                          // height: 200,
                          child: FormBuilderTextField(
                            maxLines: null,
                            minLines: 2,
                            name: "projectBio",
                            decoration: _fieldDecoration(
                                "Short synopsis about your project..."),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                            ]),
                          ),
                        ),
                      ),
                    ),
                    //),
                  ],
                ),
              ),
              Divider(
                //height: 1,
                color: Colors.grey,
                thickness: 0.5,
              ),
              Container(
                padding: EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Project Description",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          // width: 350,
                          // height: 200,
                          child: FormBuilderTextField(
                            maxLines: null,
                            minLines: 10,
                            name: "projectDescription",
                            decoration:
                                _fieldDecoration("About your project..."),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                            ]),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child:
                      SolidRoundedButton("Next", passedFunction: _submitForm))
            ],
          ),
        ))));
  }
}
