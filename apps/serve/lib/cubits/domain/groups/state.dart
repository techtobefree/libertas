part of 'cubit.dart';

abstract class GroupsCubitState extends Equatable {
  /// all groups
  final List<UGroup> groups;

  /// my groups - member of or leader of.
  final List<UGroup> mine;
  final List<UGroup> findgroups;

  /// result of a search query
  //final List<UGroup> search;

  final bool busy;

  const GroupsCubitState({
    required this.groups,
    required this.mine,
    required this.findgroups,
    required this.busy,
  });

  @override
  List<Object> get props => [
        groups,
        mine,
        busy,
      ];

  int get count => groups.length;

  // double get hoursSpent =>
  //     groups.map((p) => p.hoursSpent ?? 0).reduce((a, b) => a + b);

  // Iterable<UGroup> withMember(String userId) =>
  //     groups.where((p) => p.members?.contains(userId) ?? false);
}

class GroupsState extends GroupsCubitState {
  const GroupsState({
    required super.groups,
    required super.mine,
    required super.findgroups,
    required super.busy,
  });
}

class InitGroupsState extends GroupsCubitState {
  const InitGroupsState()
      : super(
          groups: const [],
          mine: const [],
          findgroups: const [],
          busy: false,
        );
}
