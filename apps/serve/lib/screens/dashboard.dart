import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_to_be_free/cubits/pages/dashboard/cubit.dart';
import 'package:serve_to_be_free/cubits/domain/posts/cubit.dart';
import 'package:serve_to_be_free/cubits/domain/user/cubit.dart';
import 'package:serve_to_be_free/widgets/dashboard_user_display.dart';
import 'package:serve_to_be_free/widgets/ui/project_post.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  Future<void> _getPosts(BuildContext context,
      {String? projId, String? selected}) async {
    if (projId == "All Posts" || projId == null || projId == "") {
      BlocProvider.of<PostsCubit>(context).loadPosts(
        userId: BlocProvider.of<UserCubit>(context).state.id,
        selectedValue: selected,
      );
    } else {
      BlocProvider.of<PostsCubit>(context).loadPosts(
        projId: projId,
        selectedValue: selected,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (BlocProvider.of<PostsCubit>(context).state is InitPostsState) {
      _getPosts(context, projId: "All Posts");
    }
    final dashboardCubit = BlocProvider.of<DashboardCubit>(context);
    if (dashboardCubit.state is InitDashboardState) {
      dashboardCubit.loadUsers();
      dashboardCubit.loadDropdownOptions(
        BlocProvider.of<UserCubit>(context).state.id,
      );
    }
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'My Dashboard',
            style: TextStyle(color: Colors.white),
          ),
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
      extendBody: false,
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          padding: const EdgeInsets.only(top: 20, bottom: 10),
          child: BlocBuilder<DashboardCubit, DashboardCubitState>(
              buildWhen: (previous, current) =>
                  previous.busy != current.busy ||
                  previous.dashboardUsers != current.dashboardUsers,
              builder: (context, state) => Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: state.dashboardUsers.isEmpty
                      ? []
                      : [
                          Container(
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                  width: 3.0,
                                  color: Colors.grey.withOpacity(0.5),
                                ),
                              ),
                            ),
                            child: DashboardUserDisplay(
                              dimension: 80.0,
                              name: BlocProvider.of<UserCubit>(context)
                                  .state
                                  .name,
                              url: BlocProvider.of<UserCubit>(context)
                                  .state
                                  .profilePictureUrl,
                              id: BlocProvider.of<UserCubit>(context).state.id,
                            ),
                          ),
                          // Container(
                          //   padding: EdgeInsets.all(20),
                          //   width: 2, // Set the width of the divider
                          //   height: 100, // Set the height of the divider
                          //   color: Colors.grey,
                          // ),
                          Expanded(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // LIST OF USERS
                              /// why is there always 5 users?
                              DashboardUserDisplay(
                                dimension: 60.0,
                                name: state.dashboardUsers[1].name ?? "",
                                url: state.dashboardUsers[1].pictureUrl ?? "",
                                id: state.dashboardUsers[1].id ?? "",
                              ),
                              DashboardUserDisplay(
                                dimension: 60.0,
                                name: state.dashboardUsers[2].name ?? "",
                                url: state.dashboardUsers[2].pictureUrl ?? "",
                                id: state.dashboardUsers[2].id ?? "",
                              ),
                              DashboardUserDisplay(
                                dimension: 60.0,
                                name: state.dashboardUsers[3].name ?? "",
                                url: state.dashboardUsers[3].pictureUrl ?? "",
                                id: state.dashboardUsers[3].id ?? "",
                              ),
                              DashboardUserDisplay(
                                dimension: 60.0,
                                name: state.dashboardUsers[4].name ?? "",
                                url: state.dashboardUsers[4].pictureUrl ?? "",
                                id: state.dashboardUsers[4].id ?? "",
                              ),
                            ],
                          )),
                        ])),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(0, 28, 72, 1.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 4), // changes position of shadow
              ),
            ],
          ),
          height: 50,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            //Inkwell
            Container(
                padding: const EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: () {
                    _showDropdown(context);
                    // Add your click action here
                    // For example, you can show a dialog, navigate to a new screen, etc.
                  },
                  child: Row(
                    children: [
                      const Icon(
                        Icons.sort,
                        color: Colors.white,
                        size: 24, // Adjust the size as needed
                      ),
                      const SizedBox(width: 5),
                      Container(
                        padding: const EdgeInsets.all(5),
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: BlocBuilder<PostsCubit, PostsCubitState>(
                            buildWhen: (previous, current) =>
                                previous.selected != current.selected,
                            builder: (context, state) => Text(
                                  state.selected,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    letterSpacing: -0.5,
                                  ),
                                )),
                      ),
                    ],
                  ),
                )),
            //Inkewell
            Container(
              padding: const EdgeInsets.all(12),
              color: const Color.fromRGBO(35, 107, 140, 1.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 24,
                  ),
                  Container(
                    width: 5,
                  ),
                  InkWell(
                      onTap: () {
                        context.go('/dashboard/createapost');
                      },
                      child: const Text(
                        "Create a Post",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            letterSpacing: -.5),
                      )),
                ],
              ),
            ),
          ]),
        ),
        BlocBuilder<PostsCubit, PostsCubitState>(
            buildWhen: (previous, current) =>
                previous.busy != current.busy ||
                previous.posts != current.posts,
            builder: (context, state) {
              if (state.posts.isEmpty) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  child: const Text(
                    "Join a project then view posts here",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }
              List<Map<String, dynamic>> posts = state.getConformedPosts;
              return Expanded(
                child: ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    // compute the index of the reversed list
                    //print(posts[index]['_id']);
                    return Post(
                      id: posts[index]['id'],
                      name: posts[index]['name'],
                      postText: posts[index]['text'],
                      profURL: posts[index]['imageUrl'] ?? '',
                      date: posts[index]['date'] ?? '',
                      userId: posts[index]['user']['id'],
                    );
                    // return DashboardUserDisplay(
                    //     dimension: 60.0,
                    //     name: projectData['posts']?[index]['text']);
                  },
                ),
              );
            }),
      ]),
    );
  }

  void _showDropdown(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          // Wrap the Column with SingleChildScrollView
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              for (var option in BlocProvider.of<DashboardCubit>(context)
                  .state
                  .dropdownOptions)
                ListTile(
                  title: Text(option.name),
                  onTap: () {
                    _getPosts(context,
                        projId: option.id, selected: option.name);

                    Navigator.pop(context); // Close the bottom sheet
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}
