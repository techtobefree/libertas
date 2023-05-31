import 'package:bson/bson.dart';

class UserClass {
  String id;
  String email;
  String password;
  String firstName;
  String lastName;
  List<ObjectId> projects;
  String bio;
  String profilePictureUrl;
  String coverPictureUrl;
  bool isLeader;
  List<ObjectId> friends;
  List<ObjectId> friendRequests;
  List<ObjectId> posts;

  UserClass({
    this.id = '',
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.projects,
    this.bio = '',
    required this.profilePictureUrl,
    this.coverPictureUrl = '',
    this.isLeader = false,
    required this.friends,
    required this.friendRequests,
    required this.posts,
  });

  factory UserClass.fromJson(Map<String, dynamic> json) {
    List<ObjectId> projects = [];
    for (var projectId in json['projects']) {
      projects.add(ObjectId.parse(projectId));
    }

    List<ObjectId> postIds = [];
    for (var postId in json['posts']) {
      postIds.add(ObjectId.parse(postId));
    }

    return UserClass(
      id: json['_id'],
      email: json['email'],
      password: json['password'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      projects: projects,
      bio: json['bio'] ?? '',
      profilePictureUrl: json['profilePictureUrl'] ?? '',
      coverPictureUrl: '',
      isLeader: json['isLeader'] ?? false,
      friends: [],
      friendRequests: [],
      posts: postIds,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'firstName': firstName,
      'lastName': lastName,
      'projects': projects.map((id) => id.toHexString()).toList(),
      'bio': bio,
      'profilePictureUrl': profilePictureUrl,
      'coverPictureUrl': coverPictureUrl,
      'isLeader': isLeader,
      'friends': friends,
      'posts': posts.map((id) => id.toHexString()).toList(),
    };
  }
}
