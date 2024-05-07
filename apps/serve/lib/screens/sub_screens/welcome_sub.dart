import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_to_be_free/cubits/domain/user/cubit.dart';
import 'package:serve_to_be_free/data/users/handlers/user_handlers.dart';

class NewUserWelcome extends StatefulWidget {
  const NewUserWelcome({super.key});

  @override
  _NewUserWelcomeState createState() => _NewUserWelcomeState();
}

class _NewUserWelcomeState extends State {
  bool isNotLoggedIn = true;

  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Image from assets
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/volunteer.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Welcome title
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Welcome to Serve To Be Free',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Description text
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Join likeminded citizens that believe the health of a community is directly correlated to the involvement of its community members',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                color: Colors.white,
                onPressed: () {
                  context.go('/newwelcome2');
                },
                icon: Icon(Icons.arrow_left),
              ),
              Dot(color: Colors.blue),
              Dot(color: Colors.grey),
              Dot(color: Colors.grey),
              IconButton(
                onPressed: () {
                  context.go('/newwelcome2');
                },
                icon: const Icon(Icons.arrow_right),
              ),
            ],
          ),
          // Skip and Next buttons
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.go('/login');
                  },
                  child: Text('Skip'),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.go('/newwelcome2');
                  },
                  child: Text(
                    'Next',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.blueAccent, // Set background color to blue
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );

    // @override
    // Widget build(BuildContext context) {
    //   return Scaffold(
    //     body: GestureDetector(
    //       onTap: isNotLoggedIn
    //           ? () {
    //               context.go('/login');
    //             }
    //           : null,
    //       child: Container(
    //         color: Color(0xFF001B48), // Background color #001B48
    //         child: Column(
    //           children: [
    //             Expanded(
    //               flex: 4, // 40% of available space
    //               child: Column(
    //                 verticalDirection: VerticalDirection.up,
    //                 children: [
    //                   const SizedBox(height: 50),
    //                   Image.asset(
    //                     'assets/images/volunteer.png',
    //                     fit: BoxFit.cover,
    //                   ),
    //                 ],
    //               ),
    //             ),
    //             Expanded(
    //               flex: 6, // 60% of available space
    //               child: AspectRatio(
    //                 aspectRatio: 16 / 9, // Aspect ratio of your second image
    //                 child: Image.asset(
    //                   'assets/images/volunteer.png',
    //                   fit: BoxFit.cover,
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   );
    // }
  }
}

class Dot extends StatelessWidget {
  final Color color;

  Dot({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      width: 10.0,
      height: 10.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
