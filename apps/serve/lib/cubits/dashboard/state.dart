part of 'cubit.dart';

class ProjectDropDownOption {
  final String name;
  final String pictureUrl;
  final String id;

  const ProjectDropDownOption({
    required this.name,
    required this.pictureUrl,
    required this.id,
  });

  factory ProjectDropDownOption.fromProject(Map<String, String> proj) =>
      ProjectDropDownOption(
        name: proj['name']!,
        pictureUrl: proj['projectPicture']!,
        id: proj['id']!,
      );
}

class DashboardUser {
  final String? name;
  final String? pictureUrl;
  final String? id;

  const DashboardUser({
    this.name,
    this.pictureUrl,
    this.id,
  });
}

abstract class DashboardCubitState extends Equatable {
  final List<ProjectDropDownOption> dropdownOptions;
  final List<DashboardUser> dashboardUsers;
  final bool busy;

  const DashboardCubitState({
    required this.dropdownOptions,
    required this.dashboardUsers,
    required this.busy,
  });

  @override
  List<Object> get props => [
        dropdownOptions,
        dashboardUsers,
        busy,
      ];
}

class DashboardState extends DashboardCubitState {
  const DashboardState({
    required super.dropdownOptions,
    required super.dashboardUsers,
    required super.busy,
  });
}

class InitDashboardState extends DashboardCubitState {
  const InitDashboardState()
      : super(
          dropdownOptions: const [],
          dashboardUsers: const [],
          busy: false,
        );
}
