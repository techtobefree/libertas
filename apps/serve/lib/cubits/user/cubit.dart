import 'dart:io';

import 'package:bson/bson.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:serve_to_be_free/data/users/models/user_class.dart';
import 'package:serve_to_be_free/models/UPost.dart';
import 'package:serve_to_be_free/models/UProject.dart';
import 'package:serve_to_be_free/models/USponsor.dart';
import 'package:serve_to_be_free/utilities/s3_image_utility.dart';
import 'package:serve_to_be_free/models/uuser.dart';

part 'state.dart';

const initialUser = UserState(
  id: '',
  email: '',
  password: '',
  firstName: '',
  lastName: '',
  profilePictureUrl: '',
  bio: '',
  coverPictureUrl: '',
  isLeader: false,
  friends: [],
  friendRequests: [],
  signUpResult: false,
  busy: false,
  projects: [],
  posts: [],
  sponsors: [],
  uUserFriendsId: '',
);

class UserCubit extends Cubit<UserCubitState> {
  UserCubit() : super(initialUser);

  void reset() => emit(initialUser);

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
    bool? signUpResult,
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
        signUpResult: signUpResult ?? state.signUpResult,
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
    bool? signUpResult,
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
        signUpResult: signUpResult ?? state.signUpResult,
        projects: uUser.projects,
        posts: uUser.posts,
        sponsors: uUser.sponsors,
        uUserFriendsId: uUser.uUserFriendsId,
        busy: busy ?? state.busy,
      );

  void fromUserClass({
    required UserClass userClass,
    List<String>? friendRequests,
    bool? signUpResult,
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
        signUpResult: signUpResult ?? state.signUpResult,
        projects: projects ?? state.projects,
        posts: posts ?? state.posts,
        sponsors: sponsors ?? state.sponsors,
        uUserFriendsId: uUserFriendsId ?? state.uUserFriendsId,
        busy: busy ?? state.busy,
      );

  // todo implmenet signup() login() getUser()?
  Future<void> tryCreateAccount(UserClass user, File? image) async {
    update(busy: true);
    final result = await _signUp(password: user.password, email: user.email);
    final s3url = await uploadProfileImageToS3(
        image!, DateTime.now().millisecondsSinceEpoch.toString());
    update(
      password: user.password,
      email: user.email,
      id: user.id,
      firstName: user.firstName,
      lastName: user.lastName,
      profilePictureUrl: s3url,
      signUpResult: result,
      busy: false,
    );
  }

  Future<bool> _signUp({
    required String password,
    required String email,
  }) async {
    final result = await Amplify.Auth.signUp(
      username: email,
      password: password,
    );
    return await _handleSignUpResult(result);
  }

  Future<bool> _handleSignUpResult(SignUpResult result) async {
    if (result.userId == null) {
      return false;
    }
    switch (result.nextStep.signUpStep) {
      case AuthSignUpStep.confirmSignUp:
        final codeDeliveryDetails = result.nextStep.codeDeliveryDetails!;
        _handleCodeDelivery(codeDeliveryDetails);
        return true;
      case AuthSignUpStep.done:
        safePrint('Sign up is complete');
        return true;
    }
  }

  void _handleCodeDelivery(AuthCodeDeliveryDetails codeDeliveryDetails) {
    safePrint(
      'A confirmation code has been sent to ${codeDeliveryDetails.destination}. '
      'Please check your ${codeDeliveryDetails.deliveryMedium.name} for the code.',
    );
  }
}


/* User use:
import 'package:flutter_bloc/flutter_bloc.dart';

// using the bloc pattern allows you to favor StatelessWidgets
class User extends StatelessWidget {
  const User({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<UserCubit, UserCubitState>(
        
        // you don't have to re-build on every state change
        buildWhen: (previous, current) => previous.status != current.status,

        // build according to current state
        builder: (context, state) => state.status == ActiveStatus.full
              ? Body(name: state.object.name)
              : const SizedBox.shrink()); // could be button to change state
}
*/