import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:serve_to_be_free/cubits/user/cubit.dart';
//import 'package:serve_to_be_free/cubits/user/cubit.dart';
import 'package:serve_to_be_free/data/projects/project_handlers.dart';
import 'package:serve_to_be_free/data/users/handlers/user_handlers.dart';
import 'package:serve_to_be_free/data/users/providers/user_provider.dart';
import 'package:serve_to_be_free/widgets/profile_picture.dart';
import 'package:serve_to_be_free/models/ModelProvider.dart';
import 'package:serve_to_be_free/widgets/find_project_card.dart';

class Profile extends StatefulWidget {
  final String? id; // Add this line

  const Profile({super.key, this.id}); // Add this constructor
  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  UUser user = UUser(email: "", password: "", firstName: "", lastName: "");
  @override
  void initState() {
    _tabController = TabController(length: 1, vsync: this);
    final userId = widget.id ?? BlocProvider.of<UserCubit>(context).state.id;

    _futureProjects = ProjectHandlers.getMyProjects(userId);
    UserHandlers.getUUserById(userId).then((data) => {
          setState(() {
            user = data!;
          })
        });

    super.initState();
  }

  // unused
  // Future<UserClass> fetchUser(String userId) async {
  //   final response =
  //       await http.get(Uri.parse('<YOUR_MONGODB_API_URL>/users/$userId'));

  //   if (response.statusCode == 200) {
  //     return UserClass.fromJson(jsonDecode(response.body));
  //   } else {
  //     throw Exception('Failed to load user data from MongoDB');
  //   }
  // }

  late TabController _tabController;
  late Future<List<dynamic>> _futureProjects = Future.value([]);

  Future<List<dynamic>> getMyProjects() async {
    return [];
    // var url = Uri.parse('http://44.203.120.103:3000/projects');
    // var response = await http.get(url);
    // if (response.statusCode == 200) {
    //   var jsonResponse = jsonDecode(response.body);
    //   var myprojs = [];
    //   for (var proj in jsonResponse) {
    //     for (var member in proj['members']) {
    //       if (member == Provider.of<UserProvider>(context, listen: false).id) {
    //         myprojs.add(proj);
    //       }
    //     }
    //   }
    //   // Sort the list based on isCompleted
    //   myprojs.sort((a, b) {
    //     // If a.isCompleted is false or null and b.isCompleted is true, a comes first
    //     if (a['isCompleted'] == false || a['isCompleted'] == null) {
    //       return -1;
    //     }
    //     // If a.isCompleted is true and b.isCompleted is false or null, b comes first
    //     if (b['isCompleted'] == false || b['isCompleted'] == null) {
    //       return 1;
    //     }
    //     // Otherwise, use default comparison (b comes before a if they have the same isCompleted value)
    //     return b['date'].compareTo(a['date']);
    //   });
    //   return myprojs;
    // } else {
    //   throw Exception('Failed to load projects');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return
        // TODO: convert to stateless widget and use Bloc:
        //BlocBuilder<UserCubit, UserCubitState>(
        //  //buildWhen: (previous, current) => previous.status != current.status,
        //  builder: (context, state) => state.busy ?const SizedBox.shrink():
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
                      user.profilePictureUrl ??
                          "", // state.user.profilePictureUrl,
                      user.id, // state.user.id,
                      borderRadius: 10,
                    ),
                  ),
                ))
          ]),
      Container(
        padding: const EdgeInsets.only(top: 10),
        child: Text(
          "${user.firstName} ${user.lastName}",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            fontFamily: 'Open Sans',
          ),
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
            FutureBuilder<List<dynamic>>(
              future: _futureProjects,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<dynamic>? projects = snapshot.data;
                  return ListView.builder(
                    itemCount: projects!.length,
                    itemBuilder: (context, index) {
                      return ProjectCard.fromJson(projects[index]);
                      // print(projects[index]['members'].length.toString());
                      // return ProjectCard(
                      //   title: projects[index]['name'],
                      //   num_members: projects[index]['members'].length.toString(),
                      // );
                    },
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text("Failed to load projects."),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            // Container(
            //   color: Colors.greenAccent,
            // ),
          ],
        ),
      ),
    ]));
  }
}
