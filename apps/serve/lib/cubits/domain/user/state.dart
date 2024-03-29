part of 'cubit.dart';

/// Here we include everything that might be associated with a User.
/// we should probably model the domain such that this is an object itself.
/// but for now the cubit can express everything about a user and we can
/// convert to and from both a UserClass and a UUser with it.
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
  final List<String> friendRequests;
  final bool busy;
  final String city;
  final String state;
  final List<UProject> projects;
  final List<String> friends;
  final List<UPost> posts;
  final List<USponsor> sponsors;
  final String uUserFriendsId; // what is this?

  const UserCubitState({
    required this.id,
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.state,
    required this.city,
    required this.profilePictureUrl,
    required this.coverPictureUrl,
    required this.bio,
    required this.isLeader,
    required this.friendRequests,
    required this.friends,
    required this.projects,
    required this.posts,
    required this.sponsors,
    required this.uUserFriendsId,
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
        coverPictureUrl,
        bio,
        isLeader,
        friends,
        friendRequests,
        projects,
        posts,
        sponsors,
        uUserFriendsId,
        busy,
      ];

  UUser get uUser => UUser(
        id: id,
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        projects: projects,
        profilePictureUrl: profilePictureUrl,
        coverPictureUrl: coverPictureUrl,
        friends: friends,
        posts: posts,
        sponsors: sponsors,
      );

  UserClass get userClass => UserClass(
        id: id,
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        projects: const [],
        bio: bio,
        profilePictureUrl: profilePictureUrl,
        coverPictureUrl: coverPictureUrl,
        isLeader: isLeader,
        friends: [for (final f in friends) ObjectId.tryParse(f)]
            .whereType<ObjectId>()
            .toList(),
        friendRequests: [for (final f in friendRequests) ObjectId.tryParse(f)]
            .whereType<ObjectId>()
            .toList(),
        posts: const [],
      );

  String get name => '$firstName $lastName';
}

class UserState extends UserCubitState {
  const UserState({
    required super.id,
    required super.email,
    required super.password,
    required super.firstName,
    required super.lastName,
    required super.city,
    required super.state,
    required super.profilePictureUrl,
    required super.bio,
    required super.coverPictureUrl,
    required super.isLeader,
    required super.friends,
    required super.friendRequests,
    required super.projects,
    required super.posts,
    required super.sponsors,
    required super.uUserFriendsId,
    required super.busy,
  });
}

class InitialUserState extends UserCubitState {
  const InitialUserState()
      : super(
          id: '',
          email: '',
          password: '',
          firstName: '',
          lastName: '',
          profilePictureUrl: '',
          bio: '',
          city: '',
          state: '',
          coverPictureUrl: '',
          isLeader: false,
          friends: const [],
          friendRequests: const [],
          busy: false,
          projects: const [],
          posts: const [],
          sponsors: const [],
          uUserFriendsId: '',
        );
}
