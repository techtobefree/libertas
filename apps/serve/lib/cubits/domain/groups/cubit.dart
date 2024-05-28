import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_to_be_free/data/groups/group_handlers.dart';
import 'package:serve_to_be_free/models/ModelProvider.dart';
import 'package:serve_to_be_free/models/UGroup.dart';

part 'state.dart';

class GroupsCubit extends Cubit<GroupsCubitState> {
  GroupsCubit() : super(const InitGroupsState());

  void reset() => emit(const InitGroupsState());

  void update({
    List<UGroup>? groups,
    List<UGroup>? mine,
    bool? busy,
  }) =>
      emit(GroupsState(
        groups: groups ?? state.groups,
        mine: mine ?? state.mine,
        busy: busy ?? state.busy,
      ));

  Future<void> loadGroups() async {
    try {
      update(busy: true);
      update(groups: await _getGroups(), busy: false);
    } catch (e) {
      // Handle the exception
      print('Failed to load roups: $e');
    }
  }

  Future<void> loadMyGroups(String userId) async {
    try {
      update(busy: true);
      update(mine: await _getMyGroups(userId), busy: false);
    } catch (e) {
      // Handle the exception
      print('Failed to load roups: $e');
    }
  }

  Future<List<UGroup>> _getGroups() async {
    try {
      return (await GroupHandlers.getUGroups()).whereType<UGroup>().toList();
    } catch (e) {
      throw Exception('Failed to load roups $e');
    }
  }

  Future<List<UGroup>> _getMyGroups(String userId) async {
    try {
      var projs = (await GroupHandlers.getMyUGroups(userId))
          .whereType<UGroup>()
          .toList();
      return projs;
    } catch (e) {
      throw Exception('Failed to load roups $e');
    }
  }
}
