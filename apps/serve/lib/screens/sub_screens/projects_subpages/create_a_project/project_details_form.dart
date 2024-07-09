// import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:form_validator/form_validator.dart';
import 'package:serve_to_be_free/services/platform.dart';
import 'package:universal_io/io.dart';
import 'dart:core';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:serve_to_be_free/cubits/domain/user/cubit.dart';
//import 'package:path_provider/path_provider.dart'; // for getting the directory path
import 'package:serve_to_be_free/data/projects/project_handlers.dart';
import 'package:serve_to_be_free/widgets/buttons/solid_rounded_button.dart';

import 'package:serve_to_be_free/models/ModelProvider.dart';

class ProjectDetailsForm extends StatefulWidget {
  // unused
  //final String _path; // private variable
  final String? id;
  const ProjectDetailsForm({super.key, required String path, this.id});
  //: _path = path;

  @override
  ProjectDetailsFormState createState() => ProjectDetailsFormState();
}

class ProjectDetailsFormState extends State<ProjectDetailsForm> {
  bool _isLoading = true;

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final List<String> privacyOptions = ['Friends', 'Group', 'Public'];
  var projectData = UProject(
      name: "Project Name",
      description: "About your project...",
      bio: "Short synopsis about your project...",
      city: "City",
      state: "State",
      date: "Date",
      privacy: "null",
      isCompleted: false,
      zipCode: "",
      projectPicture: "");

  // final UProject proj = await ProjectHandlers.getUProjectById(id);

  late XFile? imageCache;

  Uint8List? webProjImage;

  @override
  void initState() {
    super.initState();

    // Check if id is not null or empty and fetch project data if necessary
    if (widget.id != null && widget.id!.isNotEmpty) {
      // Replace 'getUProjectById' with your actual data fetching method
      ProjectHandlers.getUProjectById(widget.id!).then((data) async {
        projectData = data!;

        Uint8List? uint8List =
            await fetchImageFromUrl(projectData.projectPicture);

        XFile xFile = XFile.fromData(uint8List!);
        imageCache = xFile;

        _formKey.currentState?.patchValue({
          'projectName': projectData.name,
          'projectDate': DateTime.parse(projectData.date!),
          'privacy': projectData.privacy,
          'state': projectData.state,
          'city': projectData.city,
          'projectBio': projectData.bio,
          'projectDescription': projectData.description,
          'zipCode': projectData.zipCode,
          'projectImage': [xFile],
          // 'leadership': "leader chosen"
        });
        setState(() {
          _isLoading = false;
        });
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<Uint8List?> fetchImageFromUrl(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Failed to load image');
    }
  }

  Future<void> _submitForm() async {
    setState(() {
      _isLoading = true;
    });
    // a null check on here?
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      _formKey.currentState!.save();

      const bucketName = 'servetobefree-images-dev';
      const region = 'us-east-1';
      const url = 'https://$bucketName.s3.$region.amazonaws.com';

      debugPrint(url);

      // final response = await http.head(Uri.parse(url));

      final formData = _formKey.currentState!.value;

      DateTime now = DateTime.now();
      String timestamp = now.millisecondsSinceEpoch.toString();

      if (isWeb()) {
        if (webProjImage != null) {
          uploadImageToS3Web(webProjImage!, 'servetobefree-images',
              formData['projectName'], timestamp);
        }
      } else {
        final selectedFile = formData['projectImage'][0];

        if (selectedFile != null) {
          if (selectedFile != imageCache) {
            final file = File(selectedFile.path);

            await uploadImageToS3(file, 'servetobefree-images',
                formData['projectName'], timestamp);
          }
        }
      }
      final key = '/ProjectImages/${formData['projectName']}/$timestamp';
      final imageURL = 'https://servetobefree-images-dev.s3.amazonaws.com/$key';

      if (widget.id == null || widget.id!.isEmpty) {
        String? leaderStr = "";
        if (formData['leadership'] == 'Same as owner') {
          leaderStr = BlocProvider.of<UserCubit>(context).state.id;
        }
        if (formData['leadership'] == 'Current Leader') {
          leaderStr = projectData.leader;
        }
        UProject uproject = UProject(
          name: formData['projectName'],
          description: formData['projectDescription'],
          privacy: formData['privacy'],
          date: formData['projectDate'].toString().split(' ')[0],
          uUserProjectsId: "724a6ce3-47ed-402e-80c0-69e75601d2dd",
          posts: [],
          projectPicture: imageURL,
          city: formData['city'],
          state: formData['state'],
          sponsors: [],
          bio: formData['projectBio'],
          isCompleted: false,
          leader: leaderStr,
          members: [BlocProvider.of<UserCubit>(context).state.id],
          zipCode: formData['zipCode'],
        );

        final request = ModelMutations.create(uproject);
        final response = await Amplify.API.mutate(request: request).response;

        // If not, create a new account
        // final response = await http.post(
        //   _baseUrl,
        //   headers: headers,
        //   body: body,
        // );
        final createdUser = response.data;
        if (createdUser == null) {
          safePrint('errors: ${response.errors}');
          setState(() {
            _isLoading = false;
          });
        } else {
          if (leaderStr == "") {
            setState(() {
              _isLoading = false;
            });
            context.goNamed("leadprojectdetails",
                pathParameters: {'id': createdUser.id},
                queryParameters: {'id': createdUser.id});
          } else {
            setState(() {
              _isLoading = false;
            });
            context.goNamed("projectdetails",
                pathParameters: {'id': createdUser.id},
                queryParameters: {'id': createdUser.id});
          }
        }
      } else {
        UProject? uproject =
            await ProjectHandlers.getUProjectById(widget.id ?? "");
        late UProject uprojectUpdate;

        var leaderStr = uproject?.leader;
        if (formData['leadership'] == 'Same as owner') {
          leaderStr = uproject!.members![0];
        } else if (formData['leadership'] == 'Recruit leadership') {
          leaderStr = "";
        }

        if (isWeb()) {
          uprojectUpdate = uproject!.copyWith(
            name: formData['projectName'],
            description: formData['projectDescription'],
            privacy: formData['privacy'],
            date: formData['projectDate'].toString().split(' ')[0],
            uUserProjectsId: "724a6ce3-47ed-402e-80c0-69e75601d2dd",
            city: formData['city'],
            state: formData['state'],
            bio: formData['projectBio'],
            zipCode: formData['zipCode'],
            leader: leaderStr,
          );
        }
        if (formData['projectImage'][0] != imageCache) {
          uprojectUpdate = uproject!.copyWith(
            name: formData['projectName'],
            description: formData['projectDescription'],
            privacy: formData['privacy'],
            date: formData['projectDate'].toString().split(' ')[0],
            uUserProjectsId: "724a6ce3-47ed-402e-80c0-69e75601d2dd",
            projectPicture: imageURL,
            city: formData['city'],
            state: formData['state'],
            bio: formData['projectBio'],
            zipCode: formData['zipCode'],
            leader: leaderStr,
          );
        } else {
          uprojectUpdate = uproject!.copyWith(
            name: formData['projectName'],
            description: formData['projectDescription'],
            privacy: formData['privacy'],
            date: formData['projectDate'].toString().split(' ')[0],
            uUserProjectsId: "724a6ce3-47ed-402e-80c0-69e75601d2dd",
            city: formData['city'],
            state: formData['state'],
            bio: formData['projectBio'],
            zipCode: formData['zipCode'],
            leader: leaderStr,
          );
        }
        try {
          final request = ModelMutations.update(uprojectUpdate);
          final response = await Amplify.API.mutate(request: request).response;
          var createdUser = response.data;
          setState(() {
            _isLoading = false;
          });
          context.goNamed("projectdetails",
              pathParameters: {'id': createdUser!.id},
              queryParameters: {'id': createdUser.id});
        } catch (e) {
          throw Exception('Failed to finish project: $e');
        }
      }

      // Make it so the context only goes if the s3 upload is successful
      // context.go(widget._path);
    }
  }

  Future<void> uploadImageToS3(
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
  }

  Future<void> uploadImageToS3Web(Uint8List imageBytes, String bucketName,
      String projName, String timestamp,
      {String region = 'us-east-1'}) async {
    final key = '/ProjectImages/$projName/$timestamp';
    final url = 'https://servetobefree-images-dev.s3.amazonaws.com/$key'
        .replaceAll('+', '%20');
    final response = await http.put(Uri.parse(url),
        headers: {'Content-Type': 'image/jpeg'}, body: imageBytes);
    if (response.statusCode != 200) {
      throw Exception('Failed to upload image to S3');
    }
  }

  Future<void> addMember(projId) async {
    final url =
        Uri.parse('http://44.203.120.103:3000/projects/${projId}/member');
    final Map<String, dynamic> data = {
      'memberId': BlocProvider.of<UserCubit>(context).state.id
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

  String? dateValidator(DateTime? value) {
    if (value == null) {
      return 'This field is required';
    }
    return null;
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

  Future<void> _pickImage() async {
    if (isWeb()) {
      FilePickerResult? filePickerResult =
          await FilePicker.platform.pickFiles();

      if (filePickerResult != null) {
        setState(() {
          webProjImage = filePickerResult.files.first.bytes;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Project Details',
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
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
      body: Stack(
        children: [
          SingleChildScrollView(
            child: FormBuilder(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Project Name",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w600),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 12),
                          child: FormBuilderTextField(
                              name: 'projectName',
                              textCapitalization: TextCapitalization.words,
                              validator: ValidationBuilder()
                                  .required()
                                  .minLength(3)
                                  .maxLength(50)
                                  .regExp(
                                    RegExp(r'^[a-zA-Z0-9 ]+$'),
                                    'Only alphanumeric characters are allowed',
                                  )
                                  .build(),
                              decoration: _fieldDecoration(projectData.name)),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    //height: 1,
                    color: Colors.grey,
                    thickness: 0.5,
                  ),
                  Container(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Date",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w600),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 12),
                            child: FormBuilderDateTimePicker(
                                name: 'projectDate',
                                inputType: InputType.date,
                                validator: dateValidator,

                                //  FormBuilderValidators.compose(
                                //     [FormBuilderValidators.required()]),
                                decoration: _fieldDecoration(projectData.date)),
                          ),
                        ]),
                  ),
                  const Divider(
                    //height: 1,
                    color: Colors.grey,
                    thickness: 0.5,
                  ),
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
                          // decoration: BoxDecoration(
                          //   color: Colors.grey[200],
                          //   borderRadius: BorderRadius.circular(10),
                          // ),
                          child: FormBuilderDropdown<String>(
                            name: 'privacy',
                            decoration: _fieldDecoration("Project Privacy"),
                            validator: ValidationBuilder().required().build(),

                            // FormBuilderValidators.compose([
                            //   FormBuilderValidators.required(),
                            // ]),
                            // elevation: 2,
                            iconSize: 30,
                            isExpanded: true,
                            initialValue: null,
                            items: privacyOptions
                                .map((option) => DropdownMenuItem(
                                      alignment: AlignmentDirectional.center,
                                      value: option,
                                      child: Text(option),
                                    ))
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    //height: 1,
                    color: Colors.grey,
                    thickness: 0.5,
                  ),
                  Container(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Leadership",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w600),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 12),
                          child: FormBuilderDropdown<String>(
                            name: 'leadership',
                            decoration: _fieldDecoration(
                                projectData.leader != null
                                    ? 'Use Current leader'
                                    : "Leadership Option"),
                            validator: ValidationBuilder().required().build(),

                            // FormBuilderValidators.compose([
                            //   FormBuilderValidators.required(),
                            // ]),
                            elevation: 2,
                            iconSize: 30,
                            isExpanded: true,
                            initialValue: (projectData.leader != null &&
                                    projectData.leader!.isNotEmpty)
                                ? 'Current leader'
                                : "Recruit leadership",
                            items: [
                              if (projectData.leader != null) 'Current leader',
                              'Same as owner',
                              'Recruit leadership',
                            ]
                                .map((option) => DropdownMenuItem(
                                      alignment: AlignmentDirectional.center,
                                      value: option,
                                      child: Text(option),
                                    ))
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    //height: 1,
                    color: Colors.grey,
                    thickness: 0.5,
                  ),
                  Container(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Project Photo",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w600),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          // child: Container(
                          //   width: 100,
                          child: isWeb()
                              ? GestureDetector(
                                  onTap: () => _pickImage(),
                                  child: Container(
                                    width: 160,
                                    height: 160,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: const Icon(
                                      Icons.camera_alt,
                                      size: 80,
                                      color: Color.fromRGBO(0, 28, 72, 1.0),
                                    ),
                                  ),
                                )
                              : FormBuilderImagePicker(
                                  name: "projectImage",
                                  // initialValue: projectData
                                  //         .projectPicture.isNotEmpty
                                  //     ? [
                                  //         File(Uri.encodeFull(
                                  //             projectData.projectPicture))
                                  //       ] // Provide the initial image as a File
                                  //     : [], // Or an empty list if there's no initial image
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  validator: listValidator,

                                  fit: BoxFit.cover,
                                  maxImages: 1,
                                ),
                        ),
                        //),
                      ],
                    ),
                  ),
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
                              textCapitalization: TextCapitalization.words,
                              validator: ValidationBuilder()
                                  .required()
                                  .minLength(3)
                                  .maxLength(50)
                                  .regExp(
                                    RegExp(r'^[a-zA-Z0-9 ]+$'),
                                    'Only alphanumeric characters are allowed',
                                  )
                                  .build(),
                              decoration: _fieldDecoration("City")),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    //height: 1,
                    color: Colors.grey,
                    thickness: 0.5,
                  ),
                  const Divider(
                    //height: 1,
                    color: Colors.grey,
                    thickness: 0.5,
                  ),
                  Container(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: const Text(
                            "State",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w600),
                          ),
                        ),

                        //),

                        FormBuilderDropdown<String>(
                          name: 'state',
                          decoration: _fieldDecoration("State"),
                          validator: ValidationBuilder().required().build(),

                          // FormBuilderValidators.compose([
                          //   FormBuilderValidators.required(),
                          // ]),
                          elevation: 2,
                          iconSize: 30,
                          isExpanded: true,
                          initialValue: null,
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
                      ],
                    ),
                  ),
                  const Divider(
                    //height: 1,
                    color: Colors.grey,
                    thickness: 0.5,
                  ),
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
                          padding: const EdgeInsets.only(top: 10),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              // width: 350,
                              // height: 200,
                              child: FormBuilderTextField(
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                  ],
                                  keyboardType: TextInputType.text,
                                  name: "zipCode",
                                  decoration: _fieldDecoration("Zip Code"),
                                  validator: ValidationBuilder()
                                      .required(
                                          'Zip code must be 5 digits long')
                                      .build()

                                  // FormBuilderValidators.compose([
                                  //   FormBuilderValidators.required(),
                                  //   (value) {
                                  //     if (value == null || value.isEmpty) {
                                  //       return 'Please enter a 5-digit zip code';
                                  //     }
                                  //     if (value.length != 5) {
                                  //       return 'Zip code must be 5 digits long';
                                  //     }
                                  //     return null;
                                  //   },
                                  // ]),
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    //height: 1,
                    color: Colors.grey,
                    thickness: 0.5,
                  ),
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
                          padding: const EdgeInsets.only(top: 10),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              // width: 350,
                              // height: 200,
                              child: FormBuilderTextField(
                                maxLines: null,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                keyboardType: TextInputType.text,
                                minLines: 2,
                                name: "projectBio",
                                decoration: _fieldDecoration(
                                    "Short synopsis about your project..."),
                                validator:
                                    ValidationBuilder().required().build(),

                                // FormBuilderValidators.compose([
                                //   FormBuilderValidators.required(),
                                // ]),
                              ),
                            ),
                          ),
                        ),
                        //),
                      ],
                    ),
                  ),
                  const Divider(
                    //height: 1,
                    color: Colors.grey,
                    thickness: 0.5,
                  ),
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
                          padding: const EdgeInsets.only(top: 10),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              // width: 350,
                              // height: 200,
                              child: FormBuilderTextField(
                                maxLines: null,
                                minLines: 10,
                                name: "projectDescription",
                                textCapitalization:
                                    TextCapitalization.sentences,
                                keyboardType: TextInputType.text,

                                decoration:
                                    _fieldDecoration("About your project..."),
                                validator:
                                    ValidationBuilder().required().build(),

                                // FormBuilderValidators.compose([
                                //   FormBuilderValidators.required(),
                                // ]),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: SolidRoundedButton("Next",
                          passedFunction: _submitForm))
                ],
              ),
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ], // Circular progress indicator displayed on top of the form when submitting
      ),
    );
  }
}
