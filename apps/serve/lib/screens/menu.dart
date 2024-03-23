import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:serve_to_be_free/cubits/domain/user/cubit.dart';
import 'package:serve_to_be_free/widgets/buttons/menu_button.dart';
import 'package:serve_to_be_free/widgets/profile_picture.dart';

class MenuPage extends StatelessWidget {
  final String myProfilePath;
  final String finishProjectsPath;
  //final String favoritesPath;
  final String howItWorksPath;
  final String aboutPath;

  // Is having the const here necessary? I feel it improves performance since we are not changing it after instantiation.
  const MenuPage({
    super.key,
    required this.myProfilePath,
    required this.finishProjectsPath,
    //required this.favoritesPath,
    required this.howItWorksPath,
    required this.aboutPath,
  });

  Future<void> signOutCurrentUser() async {
    final result = await Amplify.Auth.signOut();
    if (result is CognitoCompleteSignOut) {
      safePrint('Sign out completed successfully');
    } else if (result is CognitoFailedSignOut) {
      safePrint('Error signing user out: ${result.exception.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize:
              const Size.fromHeight(150.0), // Set the height of the AppBar
          child: AppBar(
            title: const Text("SERVE TO BE FREE",
                style: TextStyle(color: Colors.white)),
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
                      Color.fromRGBO(35, 107, 140, 1.0),
                      Color.fromRGBO(0, 28, 72, 1.0),
                    ]),
              ),
            ),
          ),
        ),
        body: Container(
            margin: const EdgeInsets.only(top: 10, right: 20),
            child: Column(
              children: [
                MenuButton(
                    ProfilePicture(
                        Colors.amberAccent,
                        45,
                        BlocProvider.of<UserCubit>(context)
                            .state
                            .profilePictureUrl,
                        '',
                        borderRadius: 7),
                    "My Profile",
                    myProfilePath),

                MenuButton(
                    Icon(
                      Icons.checklist_rounded,
                      size: 30,
                      color: Colors.lightBlue[900],
                    ),
                    "Finish Projects",
                    finishProjectsPath),
                // MenuButton(
                //     Icon(
                //       Icons.favorite_border_rounded,
                //       size: 25,
                //       color: Colors.lightBlue[900],
                //     ),
                //     "Favorites",
                //     "Path"),

                MenuButton(
                    Icon(
                      Icons.lightbulb_outline_rounded,
                      size: 25,
                      color: Colors.lightBlue[900],
                    ),
                    "How It Works",
                    howItWorksPath),

                MenuButton(
                    Icon(
                      Icons.info_outline_rounded,
                      size: 25,
                      color: Colors.lightBlue[900],
                    ),
                    "About Serve To Be Free",
                    aboutPath),

                MenuButton(
                    Icon(
                      Icons.man,
                      size: 25,
                      color: Colors.lightBlue[900],
                    ),
                    "Friends",
                    '',
                    onTapReplacement: () => context
                            .pushNamed("friends", queryParameters: {
                          'userId': BlocProvider.of<UserCubit>(context).state.id
                        }, pathParameters: {
                          'userId': BlocProvider.of<UserCubit>(context).state.id
                        })),
                const SizedBox(
                    height:
                        20), // Add some space between the last item and the logout button
                MenuButton(
                    Icon(
                      Icons.account_box,
                      size: 25,
                      color: Colors.lightBlue[900],
                    ),
                    "My Events",
                    '',
                    onTapReplacement: () => context
                            .pushNamed("myevents", queryParameters: {
                          'userId': BlocProvider.of<UserCubit>(context).state.id
                        }, pathParameters: {
                          'userId': BlocProvider.of<UserCubit>(context).state.id
                        })),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    // Handle Logout action
                    signOutCurrentUser();
                    context.go("/login");
                  },
                  child: const Text(
                    "Logout",
                    style: TextStyle(
                      color: Colors.red, // Change the text color as desired
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            )));
  }
}
