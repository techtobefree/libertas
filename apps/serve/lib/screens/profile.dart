import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_to_be_free/cubits/domain/projects/cubit.dart';
import 'package:serve_to_be_free/cubits/domain/user/cubit.dart';
import 'package:serve_to_be_free/data/points/points_handlers.dart';
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
  bool _isLoading = false;

  UUser currUser = UUser(password: "", email: "", firstName: "", lastName: "");
  List<UProject> projs = [];
  bool isConnected = false;
  bool isButtonDisabled = false;
  num totalPoints = 0;

  @override
  void initState() {
    _tabController = TabController(length: 1, vsync: this);
    final userId = widget.id ?? BlocProvider.of<UserCubit>(context).state.id;
    UserHandlers.getUUserById(userId)
        .then((value) => setState(() => currUser = value!));
    ProjectHandlers.getMyUProjects(userId)
        .then((value) => setState(() => projs = value));
    BlocProvider.of<ProjectsCubit>(context).loadMyProjects(userId);
    PointsHandlers.getTotalUserPoints(userId)
        .then((points) => setState(() => totalPoints = points));

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Stack(
                  //crossAxisAlignment: CrossAxisAlignment.center,

                  alignment: Alignment.center,
                  children: [
                    Container(
                      // This margin is just enough to show the profile picture. Not sure if this is going to be a permanent solution.
                      margin: const EdgeInsets.only(bottom: 50),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/images/profile_background.jpeg'),
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
                              // BlocProvider.of<UserCubit>(context)
                              //         .state
                              //         .profilePictureUrl ??
                              //     "",
                              currUser.id,
                              borderRadius: 10,
                            ),
                          ),
                        ))
                  ]),
              Container(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
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
                    Text(
                      'Total Points: ${totalPoints}',
                      style: const TextStyle(
                        // fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: 'Open Sans',
                      ),
                    ),
                    SizedBox(height: 8),
                    if (currUser.bio != null && currUser.bio!.isNotEmpty)
                      Text(
                        '${currUser.bio}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Open Sans',
                        ),
                      ),
                    SizedBox(
                        height: 8), // Add some space between bio and location

                    if (currUser.city != null && currUser.city!.isNotEmpty)
                      Text(
                        '${currUser.city}, ${currUser.state}',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Open Sans',
                        ),
                      ),
                    SizedBox(
                        height: 8), // Add some space between bio and location

                    if (currUser.id ==
                        BlocProvider.of<UserCubit>(context).state.id)
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
                    if (!BlocProvider.of<UserCubit>(context)
                            .state
                            .friends
                            .contains(currUser.id) &&
                        (BlocProvider.of<UserCubit>(context).state.id !=
                            currUser.id))
                      isConnected
                          ? const Text(
                              'Connected',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Open Sans',
                                color: Colors.blue,
                              ),
                            )
                          : ElevatedButton(
                              onPressed: isButtonDisabled
                                  ? null
                                  : () async {
                                      showDialog(
                                        context: context,
                                        barrierDismissible:
                                            false, // Prevent user from dismissing dialog
                                        builder: (BuildContext context) {
                                          return Center(
                                            child:
                                                CircularProgressIndicator(), // Loading indicator
                                          );
                                        },
                                      );

                                      setState(() {
                                        isButtonDisabled = true;
                                      });

                                      await UserHandlers.addFriend(
                                        currUser.id,
                                        BlocProvider.of<UserCubit>(context)
                                            .state
                                            .id,
                                      );

                                      // Update the state to indicate that the button is now connected
                                      setState(() {
                                        isConnected = true;
                                      });
                                      Navigator.of(context, rootNavigator: true)
                                          .pop();
                                    },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  const Color.fromARGB(255, 16, 34, 65),
                                ),
                              ),
                              child: Text(
                                'Press to Connect',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                    if (BlocProvider.of<UserCubit>(context)
                        .state
                        .friends
                        .contains(currUser.id))
                      const Text(
                        'Connected',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Open Sans',
                          color: Colors.blue,
                        ),
                      ),
                    if (BlocProvider.of<UserCubit>(context).state.id ==
                        currUser.id)
                      ElevatedButton(
                        onPressed: () async {
                          // Show the confirmation dialog
                          bool? confirmDelete = await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Confirm Deletion'),
                                content: const Text(
                                    'Are you sure you want to delete your profile? This action cannot be undone.'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(
                                          false); // Dismisses the dialog and returns false
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(
                                          true); // Dismisses the dialog and returns true
                                    },
                                    child: const Text('Delete'),
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors
                                          .red, // Optional: Red text for the delete button
                                    ),
                                  ),
                                ],
                              );
                            },
                          );

                          // If the user confirmed deletion, proceed with the deletion logic
                          if (confirmDelete == true) {
                            setState(() {
                              _isLoading = true;
                            });
                            await UserHandlers.deleteUser(
                              BlocProvider.of<UserCubit>(context).state.id,
                            );
                            signOutCurrentUser();
                            setState(() {
                              _isLoading = false;
                            });

                            context.go('/login');
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 176, 12, 12),
                          ),
                        ),
                        child: const Text(
                          'Delete Profile',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Open Sans',
                            color: Colors.white,
                          ),
                        ),
                      )
                  ],
                ),
              ),
              Container(
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
            ],
          ),
          if (_isLoading) const CircularProgressIndicator()
        ],
      ),
      // )
    );
  }

  Future<void> signOutCurrentUser() async {
    final result = await Amplify.Auth.signOut();
    if (result is CognitoCompleteSignOut) {
      safePrint('Sign out completed successfully');
    } else if (result is CognitoFailedSignOut) {
      safePrint('Error signing user out: ${result.exception.message}');
    }
  }
}
