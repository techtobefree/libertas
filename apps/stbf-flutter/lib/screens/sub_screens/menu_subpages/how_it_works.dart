import 'package:flutter/material.dart';

class HowItWorksPage extends StatelessWidget {
  const HowItWorksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('How it Works'),
          flexibleSpace: Container(
            decoration: BoxDecoration(
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Joining and Posting on Projects',
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(height: 16.0),
              Text(
                'Joining a project and getting out there to help the community is easy with our platform.',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(height: 9.0),
              Text(
                'Simply browse the available projects, and join the one that interests you.',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(height: 9.0),
              Text(
                'Once you\'re a member, you can post your thoughts, questions, and feedback on the project for all the other members to see.',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(height: 32.0),
              Text(
                'Creating a Project',
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(height: 16.0),
              Text(
                'If you have an idea for a project that could use some collaboratoin, you can create a new project on our platform.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(height: 16.0),
              Text(
                'To create a project, simply click the "Create Project" button on the projects, fill out project details on the form, and choose an image to promote your project.',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(height: 16.0),
              Text(
                'Once your project is created, other members can join and start contributing.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(height: 32.0),
              Text(
                'Finishing a Project',
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(height: 16.0),
              Text(
                'When a project you created is finished, you can finish the project by clicking the "Finish Project" button on the menu tab.',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(height: 16.0),
              Text(
                'Once a project is finished, it will no longer appear in find a project or sponsor a project.',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(height: 16.0),
              Text(
                'However, the project page will remain accessible to members, so you can review the progress and contributions of the project over time.',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
