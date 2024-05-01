import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_to_be_free/cubits/domain/user/cubit.dart';
import 'package:serve_to_be_free/data/users/handlers/user_handlers.dart';

class NewUserWelcome2 extends StatefulWidget {
  const NewUserWelcome2({super.key});

  @override
  _NewUserWelcome2State createState() => _NewUserWelcome2State();
}

class _NewUserWelcome2State extends State {
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
              'Serving Made Simple',
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
              'No longer is finding a way to serve difficult. Serve to be Free has organized the process for you.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Want to volunteer, donate, or start a project of your own? You now have the tools to do so. Want to be a leader or a sponsor? These opportunities are just a click away.  Best of all share the expirience with others and recieve positive rewards and recognition along the way by your community peers and merchants.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  context.go('/newwelcome');
                },
                icon: Icon(Icons.arrow_left),
              ),
              Dot(color: Colors.grey),
              Dot(color: Colors.blue),
              Dot(color: Colors.grey),
              IconButton(
                onPressed: () {
                  context.go('/newwelcome3');
                },
                icon: Icon(Icons.arrow_right),
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
                    context.go('/newwelcome3');
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
