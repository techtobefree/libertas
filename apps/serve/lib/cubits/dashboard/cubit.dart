import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:serve_to_be_free/data/projects/project_handlers.dart';
import 'package:serve_to_be_free/models/uuser.dart';

part 'state.dart';

class DashboardCubit extends Cubit<DashboardCubitState> {
  DashboardCubit() : super(const InitDashboardState());

  void reset() => emit(const InitDashboardState());

  void update({
    List<ProjectDropDownOption>? dropdownOptions,
    List<DashboardUser>? dashboardUsers,
    bool? busy,
  }) =>
      emit(DashboardState(
        dropdownOptions: dropdownOptions ?? state.dropdownOptions,
        dashboardUsers: dashboardUsers ?? state.dashboardUsers,
        busy: busy ?? state.busy,
      ));

  Future<void> loadDropdownOptions(String userId) async {
    try {
      update(busy: true);
      update(dropdownOptions: await _getOptions(userId), busy: true);
    } catch (exp) {
      // Handle the exception
      print('Failed to load options: $exp');
    }
  }

  Future<List<ProjectDropDownOption>> _getOptions(String userId) async {
    try {
      return [
            const ProjectDropDownOption(
                name: 'All Posts', pictureUrl: '', id: '')
          ] +
          [
            for (var proj in await ProjectHandlers.getMyProjects(userId))
              ProjectDropDownOption.fromProject(proj)
          ];
    } catch (exp) {
      throw Exception('Failed to load projects $exp');
    }
  }

  Future<void> loadUsers() async {
    update(busy: true);
    update(
        busy: false,
        dashboardUsers: await _getUsers().then((data) {
          final idsAndPics = _getProfPics(data);
          final names = _setNames(data);
          return [
            for (int i = 0; i < names.length; i++)
              DashboardUser(
                name: names[i],
                pictureUrl: idsAndPics['profPics']![i],
                id: idsAndPics['ids']![i],
              )
          ];
        }));
  }

  Future<List<dynamic>> _getUsers() async {
    try {
      final request = ModelQueries.list(UUser.classType);
      final response = await Amplify.API.query(request: request).response;
      final uusers = response.data?.items;
      if (uusers == null) {
        safePrint('errors: ${response.errors}');
        return const [];
      }
      uusers.shuffle();
      return uusers;
    } on ApiException catch (e) {
      safePrint('Query failed: $e');
      return const [];
    }
  }

  Map<String, List<dynamic>> _getProfPics(users) {
    var profPicsAndIds = {"profPics": [], "ids": []};
    var profPicsUrls = [];
    var ids = [];

    for (var user in users) {
      var url = user.profilePictureUrl;
      if (url != null && url != "") {
        profPicsAndIds['profPics']?.add(url);
        profPicsAndIds['ids']?.add(user.id);
        profPicsUrls.add(url);
        ids.add(user.id);
      }
      if (profPicsUrls.length == 5) {
        return profPicsAndIds;
      }
    }
    for (var i = profPicsUrls.length; i < 5; i++) {
      profPicsAndIds['ids']?.add("");
      profPicsAndIds['profPics']?.add("");

      profPicsUrls.add("");
      ids.add("");
    }

    return profPicsAndIds;
  }

  List<dynamic> _setNames(users) {
    var namesStr = [];
    for (var user in users) {
      var url = user.profilePictureUrl;
      if (url != null && url != "") {
        namesStr.add(user.firstName);
      }
      if (namesStr.length == 5) {
        return namesStr;
      }
    }
    for (var i = namesStr.length; i < 5; i++) {
      namesStr.add("");
    }
    return namesStr;
  }
}
