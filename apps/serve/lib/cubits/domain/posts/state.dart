part of 'cubit.dart';

abstract class PostsCubitState extends Equatable {
  final List<UPost> posts;
  final String selected;
  final bool busy;

  const PostsCubitState({
    required this.posts,
    required this.selected,
    required this.busy,
  });

  @override
  List<Object> get props => [
        posts,
        selected,
        busy,
      ];

  List<Map<String, dynamic>> get getConformedPosts {
    List<Map<String, dynamic>> conformedPosts = [];
    for (var post in posts) {
      Map<String, dynamic> p = post.toJson();
      p['name'] = p['user']['firstName'] + ' ' + p['user']['lastName'];
      p['text'] = p['content'];
      p['imageUrl'] = p['user']['profilePictureUrl'];
      conformedPosts.add(p);
    }
    return conformedPosts;
  }
}

class PostsState extends PostsCubitState {
  const PostsState({
    required super.posts,
    required super.selected,
    required super.busy,
  });
}

class InitPostsState extends PostsCubitState {
  const InitPostsState()
      : super(
          posts: const [],
          selected: 'All Posts',
          busy: false,
        );
}
