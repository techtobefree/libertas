import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_to_be_free/cubits/domain/groups/cubit.dart';
import 'package:serve_to_be_free/cubits/domain/projects/cubit.dart';
import 'package:serve_to_be_free/cubits/domain/user/cubit.dart';
import 'package:serve_to_be_free/widgets/find_project_card.dart';

class GroupProjects extends StatefulWidget {
  final String? id;

  const GroupProjects({Key? key, required this.id}) : super(key: key);

  @override
  State<GroupProjects> createState() => _GroupProjectsState();
}

class _GroupProjectsState extends State<GroupProjects> {
  late UserCubit userCubit;
  late ProjectsCubit projectsCubit;
  late GroupsCubit groupsCubit;
  @override
  void initState() {
    super.initState();
    groupsCubit = BlocProvider.of<GroupsCubit>(context);

    userCubit = BlocProvider.of<UserCubit>(context);
    projectsCubit = BlocProvider.of<ProjectsCubit>(context);
    projectsCubit.loadGroupProjects(widget.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        title: const Text(
          'Group Projects',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
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
        ),
        elevation: 0,
        centerTitle: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
            child: Column(
              children: [
                const SizedBox(height: 8.0),
                ElevatedButton(
                  onPressed: () => {
                    context.pushNamed("findgroupproject", queryParameters: {
                      'id': widget.id,
                    }, pathParameters: {
                      'id': widget.id!,
                    })
                  },
                  child: const Text('Find Projects'),
                ),
              ],
            ),
          ),
        ),
      ),
      body: BlocBuilder<ProjectsCubit, ProjectsCubitState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          if (state.busy) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final projects = state.group;
          return ListView.builder(
            itemCount: projects.length,
            itemBuilder: (context, index) {
              return ProjectCard.fromUProject(projects[index]);
              // print(projects[index]['members'].length.toString());
              // return ProjectCard(
              //   title: projects[index]['name'],
              //   num_members: projects[index]['members'].length.toString(),
              // );
            },
          );
        },
      ),
    );
  }
}
