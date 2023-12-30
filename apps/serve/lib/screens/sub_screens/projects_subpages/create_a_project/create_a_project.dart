import 'package:flutter/material.dart';
import 'package:serve_to_be_free/services/dimensions.dart';
import 'package:serve_to_be_free/widgets/buttons/solid_rounded_button.dart';

class CreateAProject extends StatelessWidget {
  final String? projectFormPath;
  const CreateAProject(this.projectFormPath, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Create a Project'),
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(0, 28, 72, 1.0),
                    Color.fromRGBO(35, 107, 140, 1.0),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            )),
        body: Container(
            alignment: Alignment.center,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 40),
                    height: dimensions.height * 0.3,
                    child: Image.asset("assets/images/19219.jpg"),
                  ),
                  Container(
                      margin:
                          const EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: const Text(
                          style: TextStyle(fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                          "Anybody can create a project! Projects are a great way to connect with the people around you.")),
                  Container(
                      padding: const EdgeInsets.only(top: 40),
                      child: SolidRoundedButton("Start", path: projectFormPath))
                ])));
  }
}
