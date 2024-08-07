import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_to_be_free/cubits/pages/signup/cubit.dart';
import 'package:serve_to_be_free/data/policy_info.dart';
import 'package:serve_to_be_free/data/users/handlers/user_handlers.dart';
import 'package:serve_to_be_free/utilities/constants.dart';

enum UserField {
  firstName,
  lastName,
  email,
  password,
  confirmPassword;

  @override
  String toString() {
    switch (this) {
      case UserField.firstName:
        return 'First Name';
      case UserField.lastName:
        return 'Last Name';
      case UserField.email:
        return 'Email';
      case UserField.password:
        return 'Password';
      case UserField.confirmPassword:
        return 'Confirm Password';
      default:
        return 'None';
    }
  }
}

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  CreateAccountState createState() => CreateAccountState();
}

class CreateAccountState extends State<CreateAccountScreen> {
  late SignupCubit cubit;
  bool? _isChecked = false;

  Widget _buildTF(UserField userField, String? fillText) {
    InputDecoration decoration = InputDecoration(
      border: InputBorder.none,
      hintText: ' Enter ${userField.toString()}',
      hintStyle: kHintTextStyle,
    );

    if (userField == UserField.confirmPassword) {
      decoration = decoration.copyWith(
        hintText: ' ${userField.toString()}',
        hintStyle: kHintTextStyle,
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          userField.toString(),
          style: kLabelStyle,
        ),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 50.0,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: TextFormField(
              initialValue: fillText,
              keyboardType: TextInputType.text,
              obscureText: userField == UserField.password ||
                  userField == UserField.confirmPassword,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'OpenSans',
              ),
              onChanged: (value) {
                switch (userField) {
                  case UserField.firstName:
                    return cubit.update(firstName: value);
                  case UserField.lastName:
                    return cubit.update(lastName: value);
                  case UserField.email:
                    return cubit.update(email: value);
                  case UserField.password:
                    return cubit.update(password: value);
                  case UserField.confirmPassword:
                    return cubit.update(confirmPassword: value);
                  default:
                    return;
                }
              },
              decoration: decoration,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCreateAccBtn(SignupCubit cubit) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          if (cubit.state.signingUpBusy) {
            return;
          }
          cubit.update(signingUpBusy: true);
          await tryCreate();
          cubit.update(signingUpBusy: false);
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // <-- Radius
          ),
          backgroundColor: cubit.state.signingUpBusy
              ? Color.fromARGB(255, 141, 160, 168)
              : const Color(0xff256C8D),
        ),
        child: const Text(
          'Next',
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
    cubit = BlocProvider.of<SignupCubit>(context);
    final user = cubit.state.user;

    return Scaffold(
        backgroundColor: const Color(0xff001B48),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            'Create an Account',
            style: TextStyle(color: Colors.white),
          ),
          flexibleSpace: Container(),
          backgroundColor: const Color.fromARGB(0, 210, 206, 206),
          elevation: 0,
        ),
        body: BlocBuilder<SignupCubit, SignupState>(builder: (context, state) {
          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Stack(
                children: <Widget>[
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: const BoxDecoration(color: Color(0xff001B48)),
                  ),
                  SizedBox(
                    height: double.infinity,
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 60.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 16.0),
                              child: Text(
                                'Welcome',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'OpenSans',
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'There\'s just a few things we need from you',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'OpenSans',
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                          const SizedBox(height: 30.0),
                          _buildTF(UserField.firstName, user.firstName),
                          const SizedBox(height: 20.0),
                          _buildTF(UserField.lastName, user.lastName),
                          const SizedBox(height: 20.0),
                          _buildTF(UserField.email, user.email),
                          const SizedBox(height: 20.0),
                          _buildTF(UserField.password, user.password),
                          const SizedBox(height: 20.0),
                          _buildTF(UserField.confirmPassword, user.password),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: _isChecked,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _isChecked = value;
                                  });
                                },
                              ),
                              InkWell(
                                onTap: () {
                                  context.pushNamed("information",
                                      queryParameters: {
                                        'title': 'Terms and Conditions',
                                        'info': Policies.termsAndConditions,
                                      });
                                },
                                child: Text(
                                  'I agree with the Terms and Conditions',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          _buildCreateAccBtn(cubit),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }));
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.of(context).pop(); // dismiss dialog
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Account not found"),
      content: const Text("Username and Password did not match any results"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> tryCreate() async {
    final String email = cubit.state.email;
    final String password = cubit.state.password;
    final String confirmPass = cubit.state.confirmPassword;
    final String firstName = cubit.state.firstName;
    final String lastName = cubit.state.lastName;

    try {
      if (!_isChecked!) {
        throw (Exception('Must agree to terms and conditions'));
      }
      if (password.length < 8) {
        throw (Exception('Passwords must be at least 8 digits long'));
      }
      if (password != confirmPass) {
        throw (Exception('Passwords must match'));
      }
      if (email.isEmpty) {
        throw (Exception('Please enter a valid email'));
      }
      if (password.isEmpty) {
        throw (Exception('Please enter a valid password'));
      }
      if (firstName.isEmpty || lastName.isEmpty) {
        throw (Exception('Please enter a valid name'));
      }

      final user = cubit.state.user;
      final emailCheck = await UserHandlers.getUUserByEmail(email);
      if (emailCheck == null) {
        try {
          await cubit.signUpCognito(password: password, email: email);
        } catch (e) {
          if (e is AuthException) {
            if (e.runtimeTypeName.contains('UsernameExistsException')) {
              var attributes = await cubit.fetchCurrentUserAttributes();
              context.go('/login/communitypledge');
              return;
            }
            if (e.runtimeTypeName.contains('InvalidPasswordException')) {
              throw Exception('Invalid password format');
            }
            // Add more specific exceptions as needed
          }
          throw Exception('Sign up failed: ${e}');
        }
      } else {
        throw (Exception("Email already in use"));
      }

      /// I think isSignUpComplete is only marked as true after the confirmation
      /// process so we have to use a different metric here to see if it failed.
      /// but I don't know what that is right now. We'll just assume it
      /// succeeded since we have good validation before it's called:
      //if (cubit.state.signUpResult.isSignUpComplete) {
      // context.go('/login/createaccountscreen/chooseprofilepicture');
      context.go('/login/communitypledge');

      //} else {
      //  print('Erorr message or sometihng');
      //}
    } catch (err) {
      if (err is AuthException) {
        if (err.runtimeTypeName.contains('UsernameExistsException')) {
          context.go('/login/communitypledge');
          return;
        }
      }
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(err.toString()),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
