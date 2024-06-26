part of 'cubit.dart';

class ProjectData {
  final int hours;

  const ProjectData({
    required this.hours,
  });
}

class ProjectOption extends Equatable {
  final String name;
  final String? url;
  final String id;
  const ProjectOption({
    required this.name,
    required this.url,
    required this.id,
  });
  @override
  List<Object?> get props => [name, url, id];

  factory ProjectOption.empty({String name = 'Projects'}) => ProjectOption(
        name: name,
        url: null,
        id: "",
      );
}

abstract class ProjectsCubitState extends Equatable {
  /// all projects
  final List<UProject> projects;

  /// my projects - member of or leader of.
  final List<UProject> mine;
  final List<UProject> group;

  /// result of a search query
  //final List<UProject> search;

  final bool busy;

  const ProjectsCubitState({
    required this.projects,
    required this.mine,
    required this.group,
    required this.busy,
  });

  @override
  List<Object> get props => [
        projects,
        mine,
        group,
        busy,
      ];

  int get count => projects.length;

  double get hoursSpent =>
      projects.map((p) => p.hoursSpent ?? 0).reduce((a, b) => a + b);

  Iterable<UProject> withMember(String userId) =>
      projects.where((p) => p.members?.contains(userId) ?? false);

  Iterable<UProject> get projectsWithLeader => projects.where((project) =>
      !project.isCompleted &&
      project.leader != null &&
      project.leader!.isNotEmpty);

  Iterable<UProject> activeLeadProjects(String userId) =>
      mine.where((project) =>
          !project.isCompleted &&
          (project.leader == userId ||
              ((project.members?.length ?? 0) > 0 &&
                  (project.members?.first ?? '') == userId)));

  Iterable<UProject> get incompleteProjects =>
      projects.where((project) => !project.isCompleted);

  Iterable<UProject> incompleteProjectsNotMember(String userId) =>
      projects.where((project) =>
          (!project.isCompleted && !project.members!.contains(userId)));

  Iterable<UProject> get projectsWithoutLeader => projects.where((project) =>
      !project.isCompleted &&
      (project.leader == null || project.leader!.isEmpty));

  Iterable<ProjectOption> get options => projects.map((proj) => ProjectOption(
        name: proj.name,
        url: proj.projectPicture,
        id: proj.id,
      ));

  Iterable<ProjectOption> get myOptions => mine.map((proj) => ProjectOption(
        name: proj.name,
        url: proj.projectPicture,
        id: proj.id,
      ));
}

class ProjectsState extends ProjectsCubitState {
  const ProjectsState({
    required super.projects,
    required super.mine,
    required super.group,
    required super.busy,
  });
}

class InitProjectsState extends ProjectsCubitState {
  const InitProjectsState()
      : super(
          projects: const [],
          mine: const [],
          group: const [],
          busy: false,
        );
}
