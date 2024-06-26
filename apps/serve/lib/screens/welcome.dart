import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_to_be_free/cubits/domain/user/cubit.dart';
import 'package:serve_to_be_free/data/users/handlers/user_handlers.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State {
  bool isNotLoggedIn = true;

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
          // ignore: use_build_context_synchronously
          BlocProvider.of<UserCubit>(context).fromUUser(uUser: user);
        }

        context.go('/projects');
        return true;
      }
    }
    setState(() {
      isNotLoggedIn = true;
    });
    return false;
  }

  Future<AuthUser> getCurrentUser() async {
    final user = await Amplify.Auth.getCurrentUser();
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: isNotLoggedIn
            ? () {
                context.go('/newwelcome');
              }
            : null,
        child: Container(
          color: Color(0xFF001B48), // Background color #001B48
          child: Column(
            children: [
              Expanded(
                flex: 4, // 40% of available space
                child: Column(
                  verticalDirection: VerticalDirection.up,
                  children: [
                    const SizedBox(height: 50),
                    Image.asset(
                      'assets/images/welcome_logo.png',
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 6, // 60% of available space
                child: AspectRatio(
                  aspectRatio: 16 / 9, // Aspect ratio of your second image
                  child: Image.asset(
                    'assets/images/welcome_girl.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
