import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:serve_to_be_free/cubits/domain/user/cubit.dart';
import 'package:serve_to_be_free/cubits/pages/notifications/cubit.dart';
import 'package:serve_to_be_free/cubits/pages/signup/cubit.dart';
import 'package:serve_to_be_free/data/users/handlers/user_handlers.dart';
import 'package:serve_to_be_free/utilities/constants.dart';

//import '../utilities/user_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  bool? _rememberMe = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUserSignedIn();
  }

  Future<bool> isUserSignedIn() async {
    final result = await Amplify.Auth.fetchAuthSession();
    if (result.isSignedIn) {
      var authUser = await getCurrentUser();

      if (authUser.signInDetails is CognitoSignInDetailsApiBased) {
        var apiBasedSignInDetails =
            authUser.signInDetails as CognitoSignInDetailsApiBased;
        String email = apiBasedSignInDetails.username;

        final user = await UserHandlers.getUUserByEmail(email);

        if (user != null) {
          BlocProvider.of<UserCubit>(context).fromUUser(uUser: user);
        }
        context.go('/dashboard');
      }
    }
    return result.isSignedIn;
  }

  Future<AuthUser> getCurrentUser() async {
    final user = await Amplify.Auth.getCurrentUser();
    return user;
  }

  Widget _buildUserNameTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Email',
          style: kLabelStyle,
        ),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: emailController,
            keyboardType: TextInputType.text,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.arrow_right_alt,
                color: Colors.white,
              ),
              hintText: 'Enter your Email',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Password',
          style: kLabelStyle,
        ),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: passwordController,
            obscureText: true,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Enter your Password',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () => print('Forgot Password Button Pressed'),
        child: const Text(
          'Forgot Password?',
          style: kLabelStyle,
        ),
      ),
    );
  }

  Widget _buildRememberMeCheckbox() {
    return SizedBox(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: _rememberMe,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value;
                });
              },
            ),
          ),
          const Text(
            'Remember me',
            style: kLabelStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => {tryLogin()},
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // <-- Radius
          ),
          backgroundColor: const Color(0xff256C8D),
        ),
        child: const Text(
          'LOGIN',
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

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () => {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => const CreateAccountScreen()),
        // ),
        // setState(() {
        //   CreateAccountScreen();
        // })
        context.go('/login/createaccountscreen')
      },
      child: RichText(
        text: const TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an Account? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign Up',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xff001B48),
                ),
              ),
              SizedBox(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 120.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'Sign In',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      _buildUserNameTF(),
                      const SizedBox(
                        height: 30.0,
                      ),
                      _buildPasswordTF(),
                      _buildForgotPasswordBtn(),
                      _buildRememberMeCheckbox(),
                      _buildLoginBtn(),
                      _buildSignupBtn(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
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

  Future<void> _handleSignInResult(SignInResult result, String username) async {
    switch (result.nextStep.signInStep) {
      //case AuthSignInStep.continueSignInWithMfaSelection:
      //case AuthSignInStep.continueSignInWithTotpSetup:
      //case AuthSignInStep.confirmSignInWithTotpMfaCode:
      //case AuthSignInStep.resetPassword:
      //case AuthSignInStep.confirmSignUp:
      case AuthSignInStep.confirmSignUp:
        // Resend the sign up code to the registered device.
        final resendResult = await Amplify.Auth.resendSignUpCode(
          username: username,
        );
        _handleCodeDelivery(resendResult.codeDeliveryDetails);

        //update signUpCubit
        BlocProvider.of<SignupCubit>(context).update(email: username);
        context.goNamed('confirmemail');
        break;

      case AuthSignInStep.confirmSignInWithSmsMfaCode:
        final codeDeliveryDetails = result.nextStep.codeDeliveryDetails!;
        _handleCodeDelivery(codeDeliveryDetails);
        break;
      case AuthSignInStep.confirmSignInWithNewPassword:
        safePrint('Enter a new password to continue signing in');
        break;
      case AuthSignInStep.confirmSignInWithCustomChallenge:
        final parameters = result.nextStep.additionalInfo;
        final prompt = parameters['prompt']!;
        safePrint(prompt);
        break;

      case AuthSignInStep.done:
        safePrint('Sign in is complete');
        break;
      default:
        safePrint('Unexpected sign-in result');
    }
  }

  void _handleCodeDelivery(AuthCodeDeliveryDetails codeDeliveryDetails) {
    safePrint(
      'A confirmation code has been sent to ${codeDeliveryDetails.destination}. '
      'Please check your ${codeDeliveryDetails.deliveryMedium.name} for the code.',
    );
  }

  // TODO: move this function along with all the login functions out of view
  // and into cubit or service or something.
  void onSignInSuccessful() async {
    BlocProvider.of<NotificationsCubit>(context)
        .callPeriodically(userCubit: BlocProvider.of<UserCubit>(context));
  }

  void tryLogin() async {
    print(emailController.text);
    print(passwordController.text);
    final cubit = BlocProvider.of<UserCubit>(context);
    cubit.update(
      email: emailController.text,
      password: passwordController.text,
    );
    final signInResult =
        await cubit.signInUser(emailController.text, passwordController.text);
    if (signInResult.result != null) {
      await _handleSignInResult(signInResult.result!, signInResult.username);
    }
    // final user = await UserHandlers.getUserByEmail(emailController.text);
    final result = await isUserSignedIn();
    if (result) {
      onSignInSuccessful();
    } else {}

    // if (user == null) {
    //   showAlertDialog(context);
    //   return;
    // }

    // // bool isAuthenticated =
    // //     await authenticateUser(user!.email, passwordController.text);
    // // if (isAuthenticated || passwordController.text == user.password) {
    //   Provider.of<UserProvider>(context, listen: false).email = user.email;
    //   Provider.of<UserProvider>(context, listen: false).id = user.id;
    //   Provider.of<UserProvider>(context, listen: false).firstName =
    //       user.firstName;
    //   Provider.of<UserProvider>(context, listen: false).lastName =
    //       user.lastName;
    //   Provider.of<UserProvider>(context, listen: false).profilePictureUrl =
    //       user.profilePictureUrl;
    //   context.go('/dashboard');
    // } else {
    //   showAlertDialog(context);
    // }
  }
//   Future<void> tryLogin() async {
//     final url = Uri.parse(
//         'http://44.203.120.103:3000/users/email/${emailController.text}');
//     // 'http://localhost:3000/users/email/${emailController.text}');
//     print(url);

//     final response = await http.get(url);

//     if (response.statusCode == 200) {
//       // API call successful\

//       final res = json.decode(response.body);
//       print(response.body);
//       print(passwordController.text);

//       bool isAuthenticated =
//           await authenticateUser(res['email'], passwordController.text);
//       if (isAuthenticated || passwordController.text == res['password']) {
//         Provider.of<UserProvider>(context, listen: false).email = res['email'];
//         Provider.of<UserProvider>(context, listen: false).id = res['_id'];
//         Provider.of<UserProvider>(context, listen: false).firstName =
//             res['firstName'];
//         Provider.of<UserProvider>(context, listen: false).lastName =
//             res['lastName'];
//         if (res['profilePictureUrl'] != null) {
//           Provider.of<UserProvider>(context, listen: false).profilePictureUrl =
//               res['profilePictureUrl'];
//         }
//         context.go('/dashboard');
//       } else {
//         // do something else
//         showAlertDialog(context);
//       }

//     } else {
//       // API call unsuccessful
//       showAlertDialog(context);
//       print('Failed to fetch data');
//     }
//   }
}
