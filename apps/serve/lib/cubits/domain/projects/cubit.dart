import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_to_be_free/data/projects/project_handlers.dart';
import 'package:serve_to_be_free/models/ModelProvider.dart';
import 'package:serve_to_be_free/models/UProject.dart';

part 'state.dart';

class ProjectsCubit extends Cubit<ProjectsCubitState> {
  ProjectsCubit() : super(const InitProjectsState());

  void reset() => emit(const InitProjectsState());

  void update({
    List<UProject>? projects,
    List<UProject>? mine,
    bool? busy,
  }) =>
      emit(ProjectsState(
        projects: projects ?? state.projects,
        mine: mine ?? state.mine,
        busy: busy ?? state.busy,
      ));

  Future<void> loadProjects() async {
    try {
      update(busy: true);
      update(projects: await _getProjects(), busy: false);
    } catch (e) {
      // Handle the exception
      print('Failed to load projects: $e');
    }
  }

  Future<void> loadMyProjects(String userId) async {
    try {
      update(busy: true);
      update(mine: await _getMyProjects(userId), busy: false);
    } catch (e) {
      // Handle the exception
      print('Failed to load projects: $e');
    }
  }

  Future<List<UProject>> _getProjects() async {
    try {
      return (await ProjectHandlers.getUProjects())
          .whereType<UProject>()
          .toList();
    } catch (e) {
      throw Exception('Failed to load projects $e');
    }
  }

  Future<List<UProject>> _getMyProjects(String userId) async {
    try {
      var projs = (await ProjectHandlers.getMyUProjects(userId))
          .whereType<UProject>()
          .toList();
      return projs;
    } catch (e) {
      throw Exception('Failed to load projects $e');
    }
  }
}



  /// old, seemingly unused code I found in various places having to do with projects:
  // import 'dart:convert';
  // import 'package:http/http.dart' as http;
  // Future<List<dynamic>> getMyProjects() async {
  //   var url = Uri.parse('http://44.203.120.103:3000/projects');
  //   var response = await http.get(url);
  //   if (response.statusCode == 200) {
  //     var jsonResponse = jsonDecode(response.body);
  //     var myprojs = [];
  //     for (var proj in jsonResponse) {
  //       for (var member in proj['members']) {
  //         if (member == BlocProvider.of<UserCubit>(context).state.id) {
  //           myprojs.add(proj);
  //         }
  //       }
  //     }
  //     // Sort the list based on isCompleted
  //     myprojs.sort((a, b) {
  //       // If a.isCompleted is false or null and b.isCompleted is true, a comes first
  //       if (a['isCompleted'] == false || a['isCompleted'] == null) {
  //         return -1;
  //       }
  //       // If a.isCompleted is true and b.isCompleted is false or null, b comes first
  //       if (b['isCompleted'] == false || b['isCompleted'] == null) {
  //         return 1;
  //       }
  //       // Otherwise, use default comparison (b comes before a if they have the same isCompleted value)
  //       return b['date'].compareTo(a['date']);
  //     });
  //     return myprojs;
  //   } else {
  //     throw Exception('Failed to load projects');
  //   }
  // }