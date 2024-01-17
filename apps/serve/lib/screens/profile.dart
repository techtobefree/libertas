import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_to_be_free/cubits/domain/projects/cubit.dart';
import 'package:serve_to_be_free/cubits/domain/user/cubit.dart';
import 'package:serve_to_be_free/data/projects/project_handlers.dart';
import 'package:serve_to_be_free/data/users/handlers/user_handlers.dart';
import 'package:serve_to_be_free/models/ModelProvider.dart';
import 'package:serve_to_be_free/widgets/profile_picture.dart';
import 'package:serve_to_be_free/widgets/find_project_card.dart';

class Profile extends StatefulWidget {
  final String? id;

  const Profile({super.key, this.id});
  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  UUser currUser = UUser(password: "", email: "", firstName: "", lastName: "");
  List<UProject> projs = [];

  @override
  void initState() {
    _tabController = TabController(length: 1, vsync: this);
    final userId = widget.id ?? BlocProvider.of<UserCubit>(context).state.id;
    UserHandlers.getUUserById(userId)
        .then((value) => setState(() => currUser = value!));
    ProjectHandlers.getMyUProjects(userId)
        .then((value) => setState(() => projs = value));
    BlocProvider.of<ProjectsCubit>(context).loadMyProjects(userId);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
        // BlocBuilder<UserCubit, UserCubitState>(
        //     buildWhen: (previous, current) => previous != current,
        //     builder: (context, state) => state.busy
        //         ? const SizedBox.shrink()
        //         :
        Scaffold(
            body: Column(children: [
      Stack(
          //crossAxisAlignment: CrossAxisAlignment.center,

          alignment: Alignment.center,
          children: [
            Container(
              // This margin is just enough to show the profile picture. Not sure if this is going to be a permanent solution.
              margin: const EdgeInsets.only(bottom: 50),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/profile_background.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
              width: double.infinity,
              height: 180,
            ),
            Positioned(
                top: 110,
                right: null,
                left: null,
                child: InkWell(
                  onTap: () => print("Profilel pic tapped"),
                  child: Container(
                    //transform: Matrix4.translationValues(0.0, -70.0, 0.0),
                    //margin: EdgeInsets.only(bottom: 50),
                    child: ProfilePicture(
                      Colors.pinkAccent,
                      120,
                      currUser.profilePictureUrl ?? "",
                      currUser.id,
                      borderRadius: 10,
                    ),
                  ),
                ))
          ]),
      Container(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${currUser.firstName} ${currUser.lastName}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                fontFamily: 'Open Sans',
              ),
            ),
            SizedBox(height: 8), // Add some space between name and bio

            if (currUser.bio != null && currUser.bio!.isNotEmpty)
              Text(
                '${currUser.bio}',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Open Sans',
                ),
              ),
            SizedBox(height: 8), // Add some space between bio and location

            if (currUser.city != null && currUser.city!.isNotEmpty)
              Text(
                '${currUser.city}, ${currUser.state}',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Open Sans',
                ),
              ),
            SizedBox(height: 8), // Add some space between bio and location

            if (currUser.id == BlocProvider.of<UserCubit>(context).state.id)
              ElevatedButton(
                onPressed: () {
                  context.go('/menu/myprofile/editprofile');
                },
                child: Text(
                  'Edit Profile',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Open Sans',
                    color: Colors.white,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromARGB(255, 16, 34, 65),
                  ),
                ),
              ),
          ],
        ),
      ),

      // Container(
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Icon(Icons.location_on_outlined, size: 16, color: Colors.grey),
      //       // Not sure if this is the best way to do it but we will see.
      //       SizedBox(
      //         width: 10,
      //       ),
      //       Text("Salt Lake City, UT", style: TextStyle(color: Colors.grey))
      //     ],
      //   ),
      // ),
      Container(
        // decoration: BoxDecoration(
        //   boxShadow: [
        //     BoxShadow(
        //       //color: Colors.grey.withOpacity(0.5),
        //       spreadRadius: 2,
        //       blurRadius: 7,
        //       offset: Offset(0, 3),
        //     ),
        //   ],
        // ),
        child: TabBar(
          unselectedLabelColor: Colors.grey.withOpacity(1),
          labelColor: Colors.blue[900],
          tabs: const [
            Tab(
              text: "Projects",
            ),
            // Tab(
            //   text: "About Me",
            // )
          ],
          controller: _tabController,
          indicatorSize: TabBarIndicatorSize.tab,
        ),
      ),
      Expanded(
        child: TabBarView(
          controller: _tabController,
          children: [
            /// not sure the userCubit captures that users projects
            // BlocBuilder<ProjectsCubit, ProjectsCubitState>(
            //   buildWhen: (previous, current) => previous != current,
            //   builder: (context, state) {
            //     if (state.busy) {
            //       return const Center(
            //         child: CircularProgressIndicator(),
            //       );
            //     }
            ListView.builder(
              itemCount: projs.length,
              itemBuilder: (context, index) {
                return ProjectCard.fromUProject(projs[index]);
              },
            )

            /// on error?
            //return const Center(
            //  child: Text("Failed to load projects."),
            //);
            // },
            // ),
          ],
        ),
      ),
    ])
            // )
            );
  }
}
