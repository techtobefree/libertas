part of 'cubit.dart';

abstract class UserCubitState extends Equatable {
  final String id;
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String profilePictureUrl;
  final String bio;
  final String coverPictureUrl;
  final bool isLeader;
  final List<String> friends;
  final List<String> friendRequests;
  //final SignUpResult signUpResult; // import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
  final bool signUpResult;
  final bool busy;

  const UserCubitState({
    required this.id,
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.profilePictureUrl,
    required this.bio,
    required this.coverPictureUrl,
    required this.isLeader,
    required this.friends,
    required this.friendRequests,
    required this.signUpResult,
    required this.busy,
  });

  @override
  List<Object> get props => [
        id,
        email,
        password,
        firstName,
        lastName,
        profilePictureUrl,
        bio,
        coverPictureUrl,
        isLeader,
        friends,
        friendRequests,
        signUpResult,
        busy,
      ];
}

class UserState extends UserCubitState {
  const UserState({
    required super.id,
    required super.email,
    required super.password,
    required super.firstName,
    required super.lastName,
    required super.profilePictureUrl,
    required super.bio,
    required super.coverPictureUrl,
    required super.isLeader,
    required super.friends,
    required super.friendRequests,
    required super.signUpResult,
    required super.busy,
  });
}
