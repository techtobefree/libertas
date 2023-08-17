import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../data/users/providers/user_provider.dart';
import '../../../models/ModelProvider.dart';
import 'package:provider/provider.dart';

class ConfirmationCodePage extends StatefulWidget {
  final String email;

  const ConfirmationCodePage({Key? key, required this.email}) : super(key: key);

  @override
  _ConfirmationCodePageState createState() => _ConfirmationCodePageState();
}

class _ConfirmationCodePageState extends State<ConfirmationCodePage> {
  String _confirmationCode = "";

  void _onCodeChanged(String code) {
    setState(() {
      _confirmationCode = code;
    });
  }

  void _onSubmit() async {
    if (_confirmationCode.length == 6) {
      var confirmed = await confirmUser(
          username: widget.email, confirmationCode: _confirmationCode);
      if (confirmed == false) {
        _showErrorDialog("The code was wrong");
        return;
      }
      // Perform the necessary actions with the confirmation code
      // For example: validate the code and navigate to the next screen
      context.go('/projects'); // Replace with the actual route
    } else {
      // Show an error message or handle invalid code length
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  Future<bool> confirmUser({
    required String username,
    required String confirmationCode,
  }) async {
    try {
      final result = await Amplify.Auth.confirmSignUp(
        username: username,
        confirmationCode: confirmationCode,
      );
      print(result);
      // Check if further confirmations are needed or if
      // the sign up is complete.
      if (result.isSignUpComplete == false) {
        return false;
      }
      safePrint('sign up complete');
      return true;
    } on AuthException catch (e) {
      safePrint('Error confirming user: ${e.message}');
      return false;
    }
  }

  Future<void> _onResendCode() async {
    try {
      final resendResult = await Amplify.Auth.resendSignUpCode(
        username: widget.email,
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
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 28, 72, 1.0),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Confirmation Code',
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
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                onChanged: _onCodeChanged,
                keyboardType: TextInputType.number,
                maxLength: 6,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Enter 6-digit code',
                  hintStyle: TextStyle(color: Colors.white70),
                  counterText: "",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _onSubmit,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: Color(0xff256C8D),
              ),
              child: Text(
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
            SizedBox(height: 16),
            TextButton(
              onPressed: _onResendCode,
              child: Text(
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
      ),
    );
  }
}
