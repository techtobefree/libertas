import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_to_be_free/cubits/domain/projects/cubit.dart';
import 'package:serve_to_be_free/cubits/domain/user/cubit.dart';
import 'package:serve_to_be_free/widgets/find_project_card.dart';

class MyProjects extends StatefulWidget {
  const MyProjects({super.key});

  @override
  State<MyProjects> createState() => _MyProjectsState();
}

class _MyProjectsState extends State<MyProjects> {
  late UserCubit userCubit;
  late ProjectsCubit projectsCubit;
  @override
  void initState() {
    super.initState();
    userCubit = BlocProvider.of<UserCubit>(context);
    projectsCubit = BlocProvider.of<ProjectsCubit>(context);
    projectsCubit.loadMyProjects(userCubit.state.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('My Projects'),
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
      body: BlocBuilder<ProjectsCubit, ProjectsCubitState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          if (state.busy) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final projects = state.mine;
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
