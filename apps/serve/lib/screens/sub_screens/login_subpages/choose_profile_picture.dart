import 'dart:io';
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

  Future<void> tryCreateAccount(UserClass user) async {
    print(user.toJson());

    final createdUser = await UserHandlers.createUser(user);
    if (createdUser != null) {
      // Do something with the created user
      print('User created: ${createdUser.toJson()}');

      final s3url = uploadProfileImageToS3(_image!, createdUser.id);

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
        context.go('/projects');
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




// Future<void> createUser(UserClass user) async {
  //   if (_image == null) {
  //     setState(() {
  //       errorText =
  //           'Error creating an account. Please select an image for your profile.';
  //     });
  //     return;
  //   }

  //   // Access the existing UserProvider instance using Provider.of<UserProvider>(context)
  //   final userProvider = Provider.of<UserProvider>(context, listen: false);

  //   //authenticateUser(user.email, user.password);
  //   final url = Uri.parse('http://44.203.120.103:3000/users');
  //   final headers = <String, String>{
  //     'Content-Type': 'application/json; charset=UTF-8',
  //   };
  //   var response = null; // initialize to null
  //   try {
  //     response = await http.post(
  //       url,
  //       headers: headers,
  //       body: jsonEncode(<String, dynamic>{
  //         'email': user.email,
  //         'password': user.password,
  //         'firstName': user.firstName,
  //         'lastName': user.lastName,
  //         'projects': user.projects,
  //         'bio': user.bio,
  //         'profilePictureUrl': user.profilePictureUrl,
  //         'coverPictureUrl': user.coverPictureUrl,
  //         'isLeader': user.isLeader,
  //         'friends': user.friends,
  //         'friendRequests': user.friendRequests,
  //       }),
  //     );
  //   } catch (e) {
  //     // handle error
  //     // Failure
  //     throw Exception('Failed to create user: $response');
  //   }

  //   //   // Check if response is not null before using it
  //   if (response != null && response.statusCode == 201) {
  //     final res = json.decode(response.body);
  //     // Success

  //     print(res);
  //     // Update the UserProvider instance with the new user details
  //     userProvider.email = res['email'];
  //     userProvider.password = res['password'];
  //     userProvider.id = res['_id'];
  //     userProvider.firstName = res['firstName'];
  //     userProvider.lastName = res['lastName'];
  //     userProvider.profilePictureUrl = res['profilePictureUrl'];
  //     userProvider.bio = res['bio'];
  //     userProvider.coverPictureUrl = res['coverPictureUrl'];
  //     userProvider.isLeader = res['isLeader'];
  //     userProvider.friends = res['friends'];
  //     userProvider.friendRequests = res['friendRequests'];

  //     print('User created successfully');

  //     // Authenticate the user using the existing UserProvider instance
  //     final authenticated =
  //         authenticateUser(userProvider.email, userProvider.password);

  //     if (authenticated != null) {
  //       print("Authenticated");
  //       await userProvider.uploadImageToS3(
  //           _image!, 'servetobefree-images', userProvider.id, 'profilePicture');
  //       context.go('/dashboard');
  //     }
  //   } else {
  //     throw Exception('Something went wrong');
  //   }
  // }


















  // Access the existing UserProvider instance using Provider.of<UserProvider>(context)
      // final userProvider = Provider.of<UserProvider>(context, listen: false);

      // //authenticateUser(user.email, user.password);
      // final url = Uri.parse('http://44.203.120.103:3000/users');
      // // final url = Uri.parse('http://10.0.2.2:3000/users');

      // final headers = <String, String>{
      //   'Content-Type': 'application/json; charset=UTF-8',
      // };
      // var response = null; // initialize to null
      // try {
      //   response = await http.post(
      //     url,
      //     headers: headers,
      //     body: jsonEncode(<String, dynamic>{
      //       'email': user.email,
      //       'password': user.password,
      //       'firstName': user.firstName,
      //       'lastName': user.lastName,
      //       'projects': user.projects,
      //       'bio': user.bio,
      //       'profilePictureUrl': user.profilePictureUrl,
      //       'coverPictureUrl': user.coverPictureUrl,
      //       'isLeader': user.isLeader,
      //       'friends': user.friends,
      //       'friendRequests': user.friendRequests,
      //     }),
      //   );
      // } catch (e) {
      //   // handle error
      //   // Failure
      //   throw Exception('Failed to create user: $response');
      // }

      // //   // Check if response is not null before using it
      // if (response != null && response.statusCode == 201) {
      //   final res = json.decode(response.body);
      //   // Success

      //   print(res);
      //   // Update the UserProvider instance with the new user details
      //   userProvider.email = res['email'];
      //   userProvider.password = res['password'];
      //   userProvider.id = res['_id'];
      //   userProvider.firstName = res['firstName'];
      //   userProvider.lastName = res['lastName'];
      //   userProvider.profilePictureUrl = res['profilePictureUrl'];
      //   // userProvider.bio = res['bio'];
      //   userProvider.coverPictureUrl = res['coverPictureUrl'];
      //   // userProvider.isLeader = res['isLeader'];
      //   // userProvider.friends = res['friends'];
      //   // userProvider.friendRequests = res['friendRequests'];

      //   print('User created successfully');

      //   // Authenticate the user using the existing UserProvider instance
      //   final authenticated =
      //       authenticateUser(userProvider.email, userProvider.password);

      //   if (authenticated != null) {
      //     print("Authenticated");
      //     await userProvider.uploadImageToS3(
      //         _image!, 'servetobefree-images', userProvider.id, 'profilePicture');
      //     final url = Uri.parse(
      //         'http://44.203.120.103:3000/users/${userProvider.id}/updateProfilePic');
      //     final response = await http.put(
      //       url,
      //       headers: <String, String>{
      //         'Content-Type': 'application/json; charset=UTF-8',
      //       },
      //       body: jsonEncode(<String, String>{
      //         'profilePictureUrl':
      //             'https://servetobefree-images.s3.amazonaws.com/ServeToBeFree/ProfilePictures/${userProvider.id}/profilePicture',
      //       }),
      //     );
      //     context.go('/dashboard');
      //   }