import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:serve_to_be_free/data/users/handlers/user_handlers.dart';
import 'package:serve_to_be_free/cubits/domain/user/cubit.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  late XFile? imageCache;

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    final userCubit = BlocProvider.of<UserCubit>(context).state;

    fetchImageFromUrl(userCubit.profilePictureUrl).then((uint8List) {
      XFile xFile = XFile.fromData(uint8List!);

      imageCache = xFile;
      _formKey.currentState?.patchValue({
        'profilePicture': [xFile],
        'firstName': userCubit.firstName,
        'lastName': userCubit.lastName,
        'bio': userCubit.bio,
        'city': userCubit.city,
        'state': userCubit.state,
      });

      setState(() {
        _isLoading = false; // Set isLoading to false after data is fetched
      });
    }).catchError((error) {
      // Handle error if fetchImageFromUrl fails
      setState(() {
        _isLoading = false; // Set isLoading to false on error as well
      });
      // Optionally show an error message to the user
      print('Error fetching image: $error');
    });
  }

  Future<Uint8List?> fetchImageFromUrl(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Failed to load image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: FormBuilder(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    FormBuilderTextField(
                      name: 'firstName',
                      decoration: InputDecoration(labelText: 'First Name'),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                    ),
                    FormBuilderTextField(
                      name: 'lastName',
                      decoration: InputDecoration(labelText: 'Last Name'),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                    ),
                    SizedBox(height: 16),
                    FormBuilderTextField(
                      name: 'bio',
                      decoration: InputDecoration(labelText: 'Bio'),
                      maxLines: 3, // Allowing multiple lines for bio
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                    ),
                    SizedBox(height: 16),
                    FormBuilderTextField(
                      name: 'city',
                      decoration: InputDecoration(labelText: 'City'),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                    ),
                    SizedBox(height: 16),
                    FormBuilderTextField(
                      name: 'state',
                      decoration: InputDecoration(labelText: 'State'),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                    ),
                    SizedBox(height: 16),
                    const Text(
                      "Profile Photo",
                      style: TextStyle(fontSize: 12),
                    ),
                    FormBuilderImagePicker(
                      name: "profilePicture",
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                      fit: BoxFit.cover,
                      maxImages: 1,
                    ),
                    SizedBox(height: 32),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 16, 34, 65)),
                      ),
                      onPressed: () {
                        submitForm();
                      },
                      child: const Text(
                        'Submit',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Open Sans',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black54,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> submitForm() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      final values = _formKey.currentState!.value;

      const bucketName = 'servetobefree-images-dev';
      const region = 'us-east-1';
      const url = 'https://$bucketName.s3.$region.amazonaws.com';

      final formData = _formKey.currentState!.value;

      DateTime now = DateTime.now();
      String timestamp = now.millisecondsSinceEpoch.toString();

      final selectedFile = formData['profilePicture'][0];
      var finalUrl =
          BlocProvider.of<UserCubit>(context).state.profilePictureUrl;

      if (selectedFile != null) {
        if (selectedFile != imageCache) {
          final file = File(selectedFile.path);

          finalUrl = await uploadImageToS3(file, 'servetobefree-images',
              BlocProvider.of<UserCubit>(context).state.id, timestamp);
        }
      }

      await UserHandlers.modifyUser(
        BlocProvider.of<UserCubit>(context).state.id,
        firstName: values['firstName'],
        lastName: values['lastName'],
        bio: values['bio'],
        city: values['city'],
        state: values['state'],
        profilePictureUrl: finalUrl,
      );

      BlocProvider.of<UserCubit>(context).update(
        firstName: values['firstName'],
        lastName: values['lastName'],
        bio: values['bio'],
        city: values['city'],
        stateStr: values['state'],
        profilePictureUrl: finalUrl,
      );

      setState(() {
        _isLoading = false;
      });
      context.go('/menu/myprofile');
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
