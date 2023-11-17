import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:serve_to_be_free/data/projects/project_handlers.dart';
import 'package:serve_to_be_free/models/UPost.dart';

part 'state.dart';

class PostsCubit extends Cubit<PostsCubitState> {
  PostsCubit() : super(const InitPostsState());

  void reset() => emit(const InitPostsState());

  void update({
    List<UPost>? posts,
    String? selected,
    bool? busy,
  }) =>
      emit(PostsState(
        posts: posts ?? state.posts,
        selected: selected ?? state.selected,
        busy: busy ?? state.busy,
      ));

  Future<void> loadPosts({
    String? projId,
    String? userId,
    String? selectedValue,
  }) async {
    assert(projId != null || userId != null);
    update(busy: true);
    update(
        selected: selectedValue ?? projId ?? state.selected,
        posts: _sortPosts(await _getPosts(projId: projId, userId: userId)),
        busy: false);
  }

  Future<List<UPost>> _getPosts({String? projId, String? userId}) async {
    assert(projId != null || userId != null);
    List<UPost> posts = [];
    List projs = [];
    if (projId == "All Posts" || projId == null || projId == "") {
      projs = await ProjectHandlers.getMyProjects(userId);
    } else {
      var proj = await ProjectHandlers.getUProjectById(projId);
      projs.add(proj!.toJson());
    }
    for (var proj in projs) {
      if (proj.containsKey('posts') && proj['posts'] != null) {
        for (var post in proj['posts']) {
          final response = await Amplify.API
              .query(
                  request: ModelQueries.list<UPost>(
                UPost.classType,
                where: UPost.ID.eq(post),
              ))
              .response;
          if (response.data!.items.isNotEmpty) {
            // TODO: safe? why would it return nulls?
            posts.add(response.data!.items[0]!);
          }
        }
      }
    }
    return posts;
  }

  List<UPost> _sortPosts(List<UPost> posts) {
    List<UPost> postsWithDate = [];
    List<UPost> postsWithoutDate = [];

    // Separate posts with and without dates
    for (var post in posts) {
      if (post.date != "") {
        try {
          DateTime.parse(post.date);
          postsWithDate.add(post);
        } catch (e) {
          // Handle the case of invalid date formats
        }
      } else {
        postsWithoutDate.add(post);
      }
    }

    // Sort posts with dates
    postsWithDate.sort((a, b) {
      DateTime dateTimeA = DateTime.parse(a.date);
      DateTime dateTimeB = DateTime.parse(b.date);
      return dateTimeB.compareTo(dateTimeA);
    });

    // Concatenate the sorted posts with dates and posts without dates
    return [...postsWithDate, ...postsWithoutDate];
  }
}
