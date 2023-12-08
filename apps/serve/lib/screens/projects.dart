import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_to_be_free/cubits/domain/projects/cubit.dart';
import 'package:serve_to_be_free/cubits/domain/user/cubit.dart';
import 'package:serve_to_be_free/cubits/domain/users/cubit.dart';
import 'package:serve_to_be_free/widgets/projects_appbar_display.dart';
import 'package:serve_to_be_free/widgets/buttons/wide_border_button.dart';
import 'package:serve_to_be_free/widgets/sponsor_card.dart';
import 'package:serve_to_be_free/widgets/my_project_card.dart';

class ProjectsPage extends StatefulWidget {
  final String findProjectsPath;
  final String createProjectsPath;
  final String leadProjectsPath;
  final String sponsorProjectsPath;
  final String myProjectsPath;
  const ProjectsPage({
    Key? key,
    required this.createProjectsPath,
    required this.findProjectsPath,
    required this.leadProjectsPath,
    required this.sponsorProjectsPath,
    required this.myProjectsPath,
  }) : super(key: key);

  @override
  ProjectsPageState createState() => ProjectsPageState();
}

class ProjectsPageState extends State<ProjectsPage> {
  int memberCount = 0;
  late UserCubit userCubit;
  late UsersCubit usersCubit;
  late ProjectsCubit projectsCubit;

  /// this used to skipped the first 2 projects -
  /// not allowed to be part of my projects, not sure why.
  //Future<void> getProjects() async {}

  /// TODO: add endpoint for just user count?
  Future<int> getNumUsers() async {
    await usersCubit.load();
    return usersCubit.state.count;
  }

  @override
  void initState() {
    super.initState();
    userCubit = BlocProvider.of<UserCubit>(context);
    usersCubit = BlocProvider.of<UsersCubit>(context);
    projectsCubit = BlocProvider.of<ProjectsCubit>(context);
    projectsCubit.loadProjects();
    getNumUsers().then(
      (data) => {
        if (mounted)
          {
            setState(
              () {
                memberCount = data;
              },
            ),
          },
      },
    );
  }

  void findAPojectButton(
      /*int index or redirect to other page that grabs projects in area*/) async {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('This is a demo alert dialog.'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage("assets/images/19219.jpg"), context);
    return BlocBuilder<ProjectsCubit, ProjectsCubitState>(
        builder: (BuildContext context, ProjectsCubitState state) => Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(192.0),
              child: AppBar(
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(0, 28, 72, 1.0),
                      Color.fromRGBO(35, 107, 140, 1.0),
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  )),
                  padding: const EdgeInsets.only(top: 50),
                  // padding: EdgeInsets.only(bottom: 10)
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width - 10,
                        height: (MediaQuery.of(context).size.width - 10) / 3.5,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/images/STBF_logo_horizontal_navy.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Container(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ProjectAppbarDisplay(
                              subject: "Members",
                              value: memberCount.toString()),
                          ProjectAppbarDisplay(
                              subject: "Projects",
                              value: state.count.toString()),
                          if (state.count > 0)
                            ProjectAppbarDisplay(
                                subject: "Hours",
                                value: state.hoursSpent.toInt().toString()),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: SingleChildScrollView(
                child: Container(
              margin: const EdgeInsets.only(top: 20.0),
              child: Column(
                children: [
                  WideBorderButton(
                      "Find a Project",
                      Icon(
                        Icons.search,
                        color: Colors.indigo[900],
                        size: 28.0,
                      ),
                      widget.findProjectsPath),
                  WideBorderButton(
                      "Create a Project",
                      Icon(
                        Icons.add_outlined,
                        color: Colors.blue[600],
                        size: 28.0,
                      ),
                      widget.createProjectsPath),
                  WideBorderButton(
                      "Lead a Project",
                      Icon(
                        Icons.star_border_rounded,
                        color: Colors.amberAccent[400],
                        size: 28.0,
                      ),
                      widget.leadProjectsPath),
                  WideBorderButton(
                      "Sponsor a Project",
                      Icon(
                        Icons.favorite_border_rounded,
                        color: Colors.pinkAccent[400],
                        size: 28.0,
                      ),
                      widget.sponsorProjectsPath),
                  const SponsorCard(),
                  Container(
                    margin: const EdgeInsets.only(left: 25, right: 25, top: 30),
                    child: Row(children: [
                      const Text("My Projects",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      const Spacer(),
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          context.go(widget.myProjectsPath);
                        },
                        child: const Text('See all'),
                      ),
                    ]),
                  ),
                  if (state.projects.isNotEmpty)
                    if (state.projects.length == 1)
                      Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            MyProjectCard(
                              projectName: state.projects.first.name,
                              id: state.projects.first.id,
                              projectPhoto: state.projects.first.projectPicture,
                            ),
                          ],
                        ),
                      )
                    else
                      Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            MyProjectCard(
                                projectName: state.projects.first.name,
                                id: state.projects.first.id,
                                projectPhoto:
                                    state.projects.first.projectPicture),
                            MyProjectCard(
                                projectName: state.projects[1].name,
                                id: state.projects[1].id,
                                projectPhoto: state.projects[1].projectPicture)
                          ],
                        ),
                      )
                  else
                    const Center(
                      child: Text('Choose find a project to join!'),
                    )

                  // ClipRRect(
                  //   borderRadius: BorderRadius.circular(10),
                  //   child: Container(
                  //     width: 200,
                  //     height: 200,
                  //     decoration: BoxDecoration(
                  //       image: DecorationImage(
                  //         image: AssetImage('path/to/image.png'),
                  //         fit: BoxFit.cover,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ))));

    //);
  }
}
