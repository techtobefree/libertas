import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_to_be_free/widgets/ui/my_account_info_row.dart';

class MyAccount extends StatelessWidget {
  final String generalInfoPath;
  final String loginInfoPath;
  final String contactInfoPath;
  final String emergencyInfoPath;

  const MyAccount({
    Key? key,
    required this.generalInfoPath,
    required this.loginInfoPath,
    required this.contactInfoPath,
    required this.emergencyInfoPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Account'),
        ),
        body: SingleChildScrollView(
            child: Container(
          margin: EdgeInsets.only(top: 5),
          padding: EdgeInsets.all(5),
          child: Column(
            children: [
              Container(
                // make this a variable above for all to use
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 1,
                    ),
                  ],
                ),
                padding: EdgeInsets.only(
                  left: 20,
                  top: 10,
                  right: 10,
                ),
                child: Column(children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 15),
                    child: Row(children: [
                      Text(
                        "General Info",
                        style: TextStyle(
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      Spacer(),
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 16),
                        ),
                        // go to the general info form
                        onPressed: () {
                          context.go(generalInfoPath);
                        },
                        child: const Text('Edit'),
                      ),
                    ]),
                  ),
                  // VALUES from user
                  MyAccountInfoRow(subject: "First Name", value: "Ayana"),
                  //VALUES
                  MyAccountInfoRow(subject: "Last Name", value: "Brown"),
                  //VALUES
                  // get a stringed date value in here.
                  MyAccountInfoRow(
                      subject: "Birthday", value: "October 19, 1988"),
                  //VALUES
                  MyAccountInfoRow(subject: "Gender"),
                ]),
              ),
              Container(
                height: 15,
              ),
              Container(
                // make this a variable above for all to use
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 1,
                    ),
                  ],
                ),
                padding: EdgeInsets.only(
                  left: 20,
                  top: 10,
                  right: 10,
                ),
                child: Column(children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 15),
                    child: Row(children: [
                      Text(
                        "Login Info",
                        style: TextStyle(
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      Spacer(),
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 16),
                        ),
                        // go to the general info form
                        onPressed: () {
                          context.go(loginInfoPath);
                        },
                        child: const Text('Edit'),
                      ),
                    ]),
                  ),
                  // VALUES from user object after api call
                  MyAccountInfoRow(
                      subject: "Email",
                      value: "shannonbasdfsdfsadfea@gmail.com"),
                  //VALUES
                  MyAccountInfoRow(
                      subject: "Password",
                      // Maybe need a better fix here. Not sure if this is the correct way to display a users password.
                      value: "123456789012345".replaceAll(RegExp(r"."), "*")),
                ]),
              ),
              Container(
                height: 15,
              ),
              Container(
                // make this a variable above for all to use
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 1,
                    ),
                  ],
                ),
                padding: EdgeInsets.only(
                  left: 20,
                  top: 10,
                  right: 10,
                ),
                child: Column(children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 15),
                    child: Row(children: [
                      Text(
                        "Contact Info",
                        style: TextStyle(
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      Spacer(),
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 16),
                        ),
                        // go to the general info form
                        onPressed: () {
                          context.go(contactInfoPath);
                        },
                        child: const Text('Edit'),
                      ),
                    ]),
                  ),
                  // VALUES from user object after api call
                  MyAccountInfoRow(
                    subject: "Address",
                    value: null,
                  ),
                  //VALUES
                  MyAccountInfoRow(
                    subject: "City",
                  ),
                  MyAccountInfoRow(
                    subject: "State",
                  ),
                  MyAccountInfoRow(
                    subject: "Zip Code",
                  ),
                  MyAccountInfoRow(
                    subject: "Phone",
                  ),
                ]),
              ),
              Container(
                height: 15,
              ),
              Container(
                // make this a variable above for all to use
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 1,
                    ),
                  ],
                ),
                padding: EdgeInsets.only(
                  left: 20,
                  top: 10,
                  right: 10,
                ),
                child: Column(children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 15),
                    child: Row(children: [
                      Text(
                        "Emergency Contact Info",
                        style: TextStyle(
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      Spacer(),
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 16),
                        ),
                        // go to the general info form
                        onPressed: () {
                          context.go(emergencyInfoPath);
                        },
                        child: const Text('Edit'),
                      ),
                    ]),
                  ),
                  // VALUES from user object after api call
                  MyAccountInfoRow(
                    subject: "First Name",
                    value: null,
                  ),
                  MyAccountInfoRow(
                    subject: "Last Name",
                    value: null,
                  ),
                  MyAccountInfoRow(
                    subject: "Phone",
                    value: null,
                  ),
                ]),
              )
            ],
          ),
        )));
  }
}
