part of 'cubit.dart';

abstract class ProjectsCubitState extends Equatable {
  final List<UProject> projects;
  final bool busy;

  const ProjectsCubitState({
    required this.projects,
    required this.busy,
  });

  @override
  List<Object> get props => [
        projects,
        busy,
      ];
}

class ProjectsState extends ProjectsCubitState {
  const ProjectsState({
    required super.projects,
    required super.busy,
  });
}

class InitProjectsState extends ProjectsCubitState {
  const InitProjectsState()
      : super(
          projects: const [],
          busy: false,
        );
}
