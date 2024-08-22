import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_to_be_free/cubits/domain/projects/cubit.dart';
import 'package:serve_to_be_free/widgets/sponsor_project_list_card.dart';

class SponsorAProject extends StatelessWidget {
  const SponsorAProject({super.key});

  //incompleteProjects();

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProjectsCubit>(context).loadProjects();
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: const Color.fromARGB(255, 16, 34, 65),
        title: const Text('Sponsor A Project',
            style: TextStyle(color: Colors.white)),
      ),
      body: BlocBuilder<ProjectsCubit, ProjectsCubitState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          final incompleteProjects = state.incompleteProjects.toList();
          if (state.busy) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: incompleteProjects.length,
            itemBuilder: (context, index) {
              return SponsorProjectListCard.fromUProject(
                  incompleteProjects[index]);
              //print(ProjectCard.fromJson(projects[index]));
              // print(projects[index]['members'].length.toString());
              // return ProjectCard(
              //   title: projects[index]['name'],
              //   numMembers: projects[index]['members'].length.toString(),
              // );
            },
          );
        },
      ),
    );
  }

  // Future<List<dynamic>> getProjects() async {
  //   var url = Uri.parse('http://44.203.120.103:3000/projects');
  //   var response = await http.get(url);
  //   if (response.statusCode == 200) {
  //     var jsonResponse = jsonDecode(response.body);
  //     // print(jsonResponse);
  //     return jsonResponse;
  //   } else {
  //     throw Exception('Failed to load projects');
  //   }
  // }
}
