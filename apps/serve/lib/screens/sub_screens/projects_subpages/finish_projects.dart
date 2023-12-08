import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_to_be_free/cubits/domain/projects/cubit.dart';
import 'package:serve_to_be_free/cubits/domain/user/cubit.dart';
import 'package:serve_to_be_free/data/projects/project_handlers.dart';
import 'package:serve_to_be_free/widgets/finish_project_card.dart';

class FinishProject extends StatelessWidget {
  const FinishProject({super.key});

  @override
  Widget build(BuildContext context) {
    final userCubit = BlocProvider.of<UserCubit>(context);
    final projectsCubit = BlocProvider.of<ProjectsCubit>(context);
    projectsCubit.loadMyProjects(userCubit.state.id);
    return Scaffold(
      appBar: AppBar(
          title: const Text('Finish a Project'),
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
          final myActiveProjects =
              state.activeLeadProjects(userCubit.state.id).toList();
          if (myActiveProjects.isEmpty) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: const Text(
                "Create a project to get started",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }
          return ListView.builder(
            itemCount: myActiveProjects.length,
            itemBuilder: (context, index) {
              return FinishProjectCard.fromUProject(
                myActiveProjects[index],
                onFinishFun: () =>
                    ProjectHandlers.finishProject(myActiveProjects[index].id),
                resState: () =>
                    projectsCubit.loadMyProjects(userCubit.state.id),
              );
            },
          );
        },
      ),
    );
  }
}
