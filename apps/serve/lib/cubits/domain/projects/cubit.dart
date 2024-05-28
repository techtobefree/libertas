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
