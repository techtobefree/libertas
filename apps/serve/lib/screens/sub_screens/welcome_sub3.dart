import 'dart:ffi';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_to_be_free/cubits/domain/user/cubit.dart';
import 'package:serve_to_be_free/data/users/handlers/user_handlers.dart';

class NewUserWelcome3 extends StatefulWidget {
  const NewUserWelcome3({super.key});

  @override
  _NewUserWelcome3State createState() => _NewUserWelcome3State();
}

class _NewUserWelcome3State extends State {
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
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/volunteer.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Welcome title
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Join the Movement',
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
              'Join today and be a part of the solution.  Together, the foundational strength of your community will be strong. Find joy in being an active participant. Many hands do make light work and insure greater fairness and well-being for all. With your help, your community will thrive to greatness,  Welcome aboard your gateway to meaningful service opportunities.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  context.go('/newwelcome2');
                },
                icon: Icon(Icons.arrow_left),
              ),
              Dot(color: Colors.grey),
              Dot(color: Colors.grey),
              Dot(color: Colors.blue),
              IconButton(
                color: Colors.white,
                onPressed: () {
                  context.go('/newwelcome2');
                },
                icon: Icon(Icons.arrow_right),
              ),
            ],
          ),
          // Skip and Next buttons
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.go('/login');
                  },
                  child: Text('Login'),
                ),
                const SizedBox(
                  width: 7,
                ),
                ElevatedButton(
                  onPressed: () {
                    context.go('/login/createaccountscreen');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.blueAccent, // Set background color to blue
                  ),
                  child: const Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
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
