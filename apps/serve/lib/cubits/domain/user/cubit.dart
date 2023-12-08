import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:bson/bson.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:serve_to_be_free/data/users/models/user_class.dart';
import 'package:serve_to_be_free/models/UPost.dart';
import 'package:serve_to_be_free/models/UProject.dart';
import 'package:serve_to_be_free/models/USponsor.dart';
import 'package:serve_to_be_free/models/UUser.dart';

part 'state.dart';

class UserCubit extends Cubit<UserCubitState> {
  UserCubit() : super(const InitialUserState());

  void reset() => emit(const InitialUserState());

  void update({
    String? id,
    String? email,
    String? password,
    String? firstName,
    String? lastName,
    String? profilePictureUrl,
    String? bio,
    String? coverPictureUrl,
    bool? isLeader,
    List<String>? friendRequests,
    SignUpResult? signUpResult,
    List<UProject>? projects,
    List<UUser>? friends,
    List<UPost>? posts,
    List<USponsor>? sponsors,
    String? uUserFriendsId,
    bool? busy,
  }) =>
      emit(UserState(
        id: id ?? state.id,
        email: email ?? state.email,
        password: password ?? state.password,
        firstName: firstName ?? state.firstName,
        lastName: lastName ?? state.lastName,
        profilePictureUrl: profilePictureUrl ?? state.profilePictureUrl,
        bio: bio ?? state.bio,
        coverPictureUrl: coverPictureUrl ?? state.coverPictureUrl,
        isLeader: isLeader ?? state.isLeader,
        friends: friends ?? state.friends,
        friendRequests: friendRequests ?? state.friendRequests,
        projects: projects ?? state.projects,
        posts: posts ?? state.posts,
        sponsors: sponsors ?? state.sponsors,
        uUserFriendsId: uUserFriendsId ?? state.uUserFriendsId,
        busy: busy ?? state.busy,
      ));

  void fromUUser({
    required UUser uUser,
    String? bio,
    bool? isLeader,
    List<String>? friendRequests,
    SignUpResult? signUpResult,
    bool? busy,
  }) =>
      update(
        id: uUser.id,
        email: uUser.email,
        password: uUser.password,
        firstName: uUser.firstName,
        lastName: uUser.lastName,
        profilePictureUrl: uUser.profilePictureUrl,
        coverPictureUrl: uUser.coverPictureUrl,
        friends: uUser.friends,
        bio: bio ?? state.bio,
        isLeader: isLeader ?? state.isLeader,
        friendRequests: friendRequests ?? state.friendRequests,
        projects: uUser.projects,
        posts: uUser.posts,
        sponsors: uUser.sponsors,
        uUserFriendsId: uUser.uUserFriendsId,
        busy: busy ?? state.busy,
      );

  void fromUserClass({
    required UserClass userClass,
    List<String>? friendRequests,
    SignUpResult? signUpResult,
    List<UProject>? projects,
    List<UUser>? friends,
    List<UPost>? posts,
    List<USponsor>? sponsors,
    String? uUserFriendsId,
    bool? busy,
  }) =>
      update(
        id: userClass.id,
        email: userClass.email,
        password: userClass.password,
        firstName: userClass.firstName,
        lastName: userClass.lastName,
        profilePictureUrl: userClass.profilePictureUrl,
        bio: userClass.bio,
        coverPictureUrl: userClass.coverPictureUrl,
        isLeader: userClass.isLeader,
        friends: friends ?? state.friends,
        friendRequests: friendRequests ?? state.friendRequests,
        projects: projects ?? state.projects,
        posts: posts ?? state.posts,
        sponsors: sponsors ?? state.sponsors,
        uUserFriendsId: uUserFriendsId ?? state.uUserFriendsId,
        busy: busy ?? state.busy,
      );

  /// TODO: to make more secure we shouldn't save password in cubits.

  Future<void> signInUser(String? username, String? password) async {
    try {
      final _ = await Amplify.Auth.signIn(
        username: username ?? state.email,
        password: password ?? state.password,
      );
      print('signed in auth');
    } on AuthException catch (e) {
      safePrint('Error signing in: ${e.message}');
    }
  }

  Future<bool> isUserSignedIn() async {
    final result = await Amplify.Auth.fetchAuthSession();
    if (result.isSignedIn) {
      var authUser = await Amplify.Auth.getCurrentUser();
      if (authUser.signInDetails is CognitoSignInDetailsApiBased) {
        //unused
        //var apiBasedSignInDetails =
        //    authUser.signInDetails as CognitoSignInDetailsApiBased;
      }
    }
    return result.isSignedIn;
  }
}
