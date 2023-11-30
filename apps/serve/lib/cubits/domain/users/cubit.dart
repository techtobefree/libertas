import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_to_be_free/data/users/handlers/user_handlers.dart';
import 'package:serve_to_be_free/models/uuser.dart';

part 'state.dart';

class UsersCubit extends Cubit<UsersCubitState> {
  UsersCubit() : super(const InitialUsersState());

  void reset() => emit(const InitialUsersState());

  void update({
    List<UUser>? users,
    bool? busy,
  }) =>
      emit(UsersState(
        users: users ?? state.users,
        busy: busy ?? state.busy,
      ));

  Future<void> load() async {
    update(busy: true);
    update(
      users: await _getUsers(),
      busy: false,
    );
  }

  Future<List<UUser>> _getUsers() async {
    return (await UserHandlers.getUUsers()).whereType<UUser>().toList();
  }
}
