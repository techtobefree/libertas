import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:serve_to_be_free/cubits/domain/user/cubit.dart';
import 'package:serve_to_be_free/cubits/pages/signup/cubit.dart';
import 'package:serve_to_be_free/data/policy_info.dart';
import 'package:serve_to_be_free/data/users/models/user_class.dart';
import 'package:serve_to_be_free/data/users/handlers/user_handlers.dart';

class CommunityPledge extends StatelessWidget {
  const CommunityPledge({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 28, 72, 1.0),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Community Pledge',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        top: true,
        child: Stack(
          children: [
            const Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    'We have standards :)',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            Align(
              alignment: AlignmentDirectional(0, 0),
              child: Container(
                width: 320,
                height: 333,
                decoration: BoxDecoration(
                  color: Color(0xFF71D0E5),
                  borderRadius:
                      BorderRadius.circular(20), // Adjust the radius as needed
                ),
                child: Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'I agree to abide by the ',
                            style: TextStyle(color: Colors.black),
                          ),
                          TextSpan(
                            text: 'Code of Conduct',
                            style: TextStyle(
                              color: Colors.indigo,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.pushNamed('information',
                                    queryParameters: {
                                      'title': 'Code of Conduct',
                                      'info': Policies.codeOfConduct
                                    });
                              },
                          ),
                          TextSpan(
                            text:
                                ' and agree to post only items that are in alignment with the ',
                            style: TextStyle(color: Colors.black),
                          ),
                          TextSpan(
                            text: 'Serve To Be Free mission',
                            style: TextStyle(
                              color: Colors.indigo,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context
                                    .pushNamed('information', queryParameters: {
                                  'title': 'Serve To Be Free Mission',
                                  'info': Policies.mission,
                                });
                              },
                          ),
                          TextSpan(
                            text: ' and ',
                            style: TextStyle(color: Colors.black),
                          ),
                          TextSpan(
                            text: 'terms and conditions',
                            style: TextStyle(
                              color: Colors.indigo,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.pushNamed('information',
                                    queryParameters: {
                                      'title': 'Terms and Conditions',
                                      'info': Policies.termsAndConditions
                                    });
                              },
                          ),
                          TextSpan(
                            text:
                                ' while using the Serve To Be Free application.',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(-0.0, -0.5),
              child: Icon(
                Icons.circle,
                color: Color(0xFFFBFCFD),
                size: 120,
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0, -0.45),
              child: Icon(
                Icons.favorite,
                color: Color(0xFFDD307B),
                size: 45,
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0.66, 0.84),
              child: ElevatedButton(
                onPressed: () {
                  context.go('/login/createaccountscreen/chooseprofilepicture');
                },
                child: Text('I agree'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
