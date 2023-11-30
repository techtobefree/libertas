part of 'cubit.dart';

/// Here we include everything that might be associated with a User.
/// we should probably model the domain such that this is an object itself.
/// but for now the cubit can express everything about a user and we can
/// convert to and from both a UserClass and a UUser with it.
abstract class UsersCubitState extends Equatable {
  final List<UUser> users;
  final bool busy;

  const UsersCubitState({
    required this.users,
    required this.busy,
  });

  @override
  List<Object> get props => [
        users,
        busy,
      ];

  int get count => users.length;
}

class UsersState extends UsersCubitState {
  const UsersState({
    required super.users,
    required super.busy,
  });
}

class InitialUsersState extends UsersCubitState {
  const InitialUsersState()
      : super(
          users: const [],
          busy: false,
        );
}
