import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:serve_to_be_free/cubits/domain/user/cubit.dart';
import 'package:serve_to_be_free/cubits/pages/signup/cubit.dart';
import 'package:serve_to_be_free/data/users/models/user_class.dart';
import 'package:serve_to_be_free/data/users/handlers/user_handlers.dart';

class ConfirmationCodePage extends StatelessWidget {
  const ConfirmationCodePage({super.key});

  void _onCodeChanged(String code, SignupCubit cubit) {
    cubit.update(confirmationCode: code);
  }

  void _onSubmit(
    BuildContext context,
    SignupCubit cubit,
    UserCubit userCubit,
  ) async {
    if (cubit.state.confirmBusy) {
      return;
    }
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
    cubit.update(confirmBusy: true);
    if (cubit.state.confirmationCode.length == 6) {
      var confirmed = await cubit.confirmUser();
      if (confirmed == false) {
        _showErrorDialog(context, 'The code was wrong');
        return;
      }
      await userCubit.signInUser(
        userCubit.state.email,
        userCubit.state.password,
      );
      UserClass user = userCubit.state.userClass;
      user.friendRequests = [];
      user.friends = [];
      user.posts = [];
      user.projects = [];
      final isSignedIn = await userCubit.isUserSignedIn();
      if (isSignedIn) {
        final createdUser = await UserHandlers.createUser(user);
        if (createdUser != null) {
          // Do something with the created user
          print('User created: ${createdUser.toJson()}');
          cubit.update(id: createdUser.id);
          userCubit.update(id: createdUser.id);
          context.go('/projects'); // Replace with the actual route
        }
      } else {
        // Show an error message or handle invalid code length
      }
    }
    cubit.update(confirmBusy: false);
    Navigator.of(context).pop(); // Dismiss the progress indicator
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _onResendCode(SignupCubit cubit) async {
    try {
      final resendResult = await Amplify.Auth.resendSignUpCode(
        username: cubit.state.email,
      );
      _handleCodeDelivery(resendResult.codeDeliveryDetails);
    } on AuthException catch (e) {
      safePrint('Error resending code: ${e.message}');
    }
  }

  void _handleCodeDelivery(AuthCodeDeliveryDetails codeDeliveryDetails) {
    safePrint(
      'A confirmation code has been sent to ${codeDeliveryDetails.destination}. '
      'Please check your ${codeDeliveryDetails.deliveryMedium.name} for the code.',
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
          'Confirmation Code',
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
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  onChanged: (value) => _onCodeChanged(value, cubit),
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Enter 6-digit code',
                    hintStyle: const TextStyle(color: Colors.white70),
                    counterText: "",
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => _onSubmit(context, cubit, userCubit),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: state.confirmBusy
                      ? Color.fromARGB(255, 141, 160, 168)
                      : const Color(0xff256C8D),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 1.5,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'OpenSans',
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => _onResendCode(cubit),
                child: const Text(
                  'Resend Code',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
