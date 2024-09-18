import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:serve_to_be_free/cubits/domain/user/cubit.dart';
import 'package:serve_to_be_free/cubits/pages/signup/cubit.dart';
import 'package:serve_to_be_free/utilities/s3_image_utility.dart';
import 'package:serve_to_be_free/services/platform.dart';

class ChooseProfilePicture extends StatelessWidget {
  const ChooseProfilePicture({super.key});

  Future<void> _pickImage(SignupCubit cubit) async {
    if (isWeb()) {
      FilePickerResult? filePickerResult =
          await FilePicker.platform.pickFiles();

      if (filePickerResult != null) {
        cubit.update(webImage: filePickerResult.files.first.bytes);
      }
    } else {
      final imagePicker = ImagePicker();
      final pickedImage =
          await imagePicker.pickImage(source: ImageSource.gallery);

      if (pickedImage != null) {
        cubit.update(profilePicture: File(pickedImage.path));
        cubit.update(hasSelectedImage: true);
      }
    }
  }

  Future<void> uploadImage(
    BuildContext context,
    UserCubit userCubit,
    SignupState state,
  ) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(
            color: Colors.lightBlueAccent,
          ),
        );
      },
    );
    String s3url;

    if (isWeb()) {
      s3url = await uploadProfileImageToS3Web(
          state.webImage!, DateTime.now().millisecondsSinceEpoch.toString());
    } else {
      s3url = await uploadProfileImageToS3(state.profilePicture!,
          DateTime.now().millisecondsSinceEpoch.toString());
    }
    userCubit.fromUserClass(userClass: state.user);
    userCubit.update(profilePictureUrl: s3url);

    Navigator.of(context).pop(); // Dismiss the progress indicator
    context.goNamed('confirmemail');
  }

  Widget _buildCreateAccBtn(
    BuildContext context,
    SignupCubit cubit,
    UserCubit userCubit,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          if (!cubit.state.hasSelectedImage) {
            // showDialog(
            //   context: context,
            //   builder: (BuildContext context) {
            //     return AlertDialog(
            //       title: const Text('No Photo Selected'),
            //       content:
            //           const Text('Please select a photo before proceeding.'),
            //       actions: <Widget>[
            //         TextButton(
            //           child: const Text('OK'),
            //           onPressed: () {
            //             Navigator.of(context).pop();
            //           },
            //         ),
            //       ],
            //     );
            //   },
            // );
            // return;
            cubit.update(imageBusy: true);

            userCubit.fromUserClass(userClass: cubit.state.user);
            userCubit.update(
                profilePictureUrl:
                    'https://servetobefree-images-dev.s3.amazonaws.com/ProfileImages/genericProfile/genericUser.jpg');
            cubit.update(imageBusy: false);
            Navigator.of(context).pop(); // Dismiss the progress indicator

            context.goNamed('confirmemail');
            return;
          }

          if (cubit.state.imageBusy) return;

          cubit.update(imageBusy: true);
          await uploadImage(context, userCubit, cubit.state);
          cubit.update(imageBusy: false);
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // <-- Radius
          ),
          backgroundColor: cubit.state.imageBusy
              ? Color.fromARGB(255, 141, 160, 168)
              : const Color(0xff256C8D),
        ),
        child: const Text(
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
    final cubit = BlocProvider.of<SignupCubit>(context);
    final userCubit = BlocProvider.of<UserCubit>(context);
    return Scaffold(
        backgroundColor: const Color.fromRGBO(0, 28, 72, 1.0),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'Choose Profile Picture',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: BlocBuilder<SignupCubit, SignupState>(builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => _pickImage(cubit),
                  child: Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ((cubit.state.profilePicture != null) && (!isWeb()))
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.file(
                              cubit.state.profilePicture!,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Icon(
                            Icons.camera_alt,
                            size: 80,
                            color: Color.fromRGBO(0, 28, 72, 1.0),
                          ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Tap to select a profile picture',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                // if (errorText != null)
                //   Container(
                //     padding: const EdgeInsets.symmetric(
                //         vertical: 8.0, horizontal: 16.0),
                //     margin:
                //         const EdgeInsets.only(left: 16.0, right: 16, top: 16),
                //     decoration: BoxDecoration(
                //       color: Colors.red,
                //       borderRadius: BorderRadius.circular(8.0),
                //     ),
                //     child: Text(
                //       errorText!,
                //       style: const TextStyle(
                //         color: Colors.white,
                //         fontWeight: FontWeight.bold,
                //         fontSize: 16.0,
                //       ),
                //     ),
                //   ),
                _buildCreateAccBtn(context, cubit, userCubit)
              ],
            ),
          );
        }));
  }
}
