import 'dart:io';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import 'package:serve_to_be_free/data/users/models/user_class.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'dart:convert';

import 'package:serve_to_be_free/data/users/providers/user_provider.dart';
import 'package:serve_to_be_free/utilities/auth.dart';
import 'package:serve_to_be_free/utilities/s3_image_utility.dart';

import '../../../data/users/handlers/user_handlers.dart';

class ChooseProfilePicture extends StatefulWidget {
  const ChooseProfilePicture({Key? key}) : super(key: key);

  @override
  _ChooseProfilePictureState createState() => _ChooseProfilePictureState();

  // passed from the create account.
  static UserClass? _user;

  static UserClass? getUser() {
    return _user;
  }

  static void setUser(UserClass? user) {
    _user = user;
  }
}

class _ChooseProfilePictureState extends State<ChooseProfilePicture> {
  File? _image;
  String? errorText;

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
        errorText = null; // set errorText to null when _image is not null
      }
    });
  }

  Future<void> _signUp({
    required String password,
    required String email,
  }) async {
    final result = await Amplify.Auth.signUp(
      username: email,
      password: password,
    );
    Provider.of<UserProvider>(context, listen: false).signUpResult = result;
    // await _handleSignUpResult(result);
  }

  Future<void> _handleSignUpResult(SignUpResult result) async {
    switch (result.nextStep.signUpStep) {
      case AuthSignUpStep.confirmSignUp:
        final codeDeliveryDetails = result.nextStep.codeDeliveryDetails!;
        _handleCodeDelivery(codeDeliveryDetails);
        break;
      case AuthSignUpStep.done:
        safePrint('Sign up is complete');
        break;
    }
  }

  void _handleCodeDelivery(AuthCodeDeliveryDetails codeDeliveryDetails) {
    safePrint(
      'A confirmation code has been sent to ${codeDeliveryDetails.destination}. '
      'Please check your ${codeDeliveryDetails.deliveryMedium.name} for the code.',
    );
  }

  Future<void> tryCreateAccount(UserClass user) async {
    await _signUp(password: user.password, email: user.email);

    final createdUser = await UserHandlers.createUser(user);

    if (createdUser != null) {
      // Do something with the created user
      print('User created: ${createdUser.toJson()}');

      final s3url = await uploadProfileImageToS3(_image!, createdUser.id);

      final updatedUser = await UserHandlers.updateUser(createdUser.id, {
        'profilePictureUrl': s3url,
      });
      if (updatedUser != null) {
        // User was successfully updated
        print('User created and updated: ${updatedUser.toJson()}');
        Provider.of<UserProvider>(context, listen: false).email =
            updatedUser.email;
        Provider.of<UserProvider>(context, listen: false).id = updatedUser.id;
        Provider.of<UserProvider>(context, listen: false).firstName =
            updatedUser.firstName;
        Provider.of<UserProvider>(context, listen: false).lastName =
            updatedUser.lastName;
        if (updatedUser.profilePictureUrl != null) {
          Provider.of<UserProvider>(context, listen: false).profilePictureUrl =
              updatedUser.profilePictureUrl;
        }
        context.goNamed('confirmemail', queryParameters: {'email': user.email});
      } else {
        // Failed to update user
        throw Exception("failed to update profile picture of user.");
      }
    } else {
      // Handle error
      print('Failed to create user');
    }
  }

  Widget _buildCreateAccBtn() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          UserClass? user = ChooseProfilePicture._user;
          if (user != null) {
            tryCreateAccount(user);
            //createUser(user);
          }
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // <-- Radius
          ),
          backgroundColor: Color(0xff256C8D),
        ),
        child: Text(
          'Create Account',
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 28, 72, 1.0),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Choose Profile Picture',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: _image != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.file(
                          _image!,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Icon(
                        Icons.camera_alt,
                        size: 80,
                        color: Color.fromRGBO(0, 28, 72, 1.0),
                      ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Tap to select a profile picture',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            if (errorText != null)
              Container(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                margin: EdgeInsets.only(left: 16.0, right: 16, top: 16),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  errorText!,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
            _buildCreateAccBtn()
          ],
        ),
      ),
    );
  }
}
