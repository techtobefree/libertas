// // dont need this because we have the classes up in the models folder.

// import 'package:bson/bson.dart';

// class UserClass {
//   String email;
//   String firstName;
//   String lastName;
//   List<ObjectId> projects;
//   String bio;
//   String profilePictureUrl;
//   String coverPictureUrl;
//   bool isLeader;
//   List<ObjectId> posts;

//   UserClass({
//     required this.email,
//     required this.firstName,
//     required this.lastName,
//     this.projects = const [],
//     this.bio = '',
//     required this.profilePictureUrl,
//     this.coverPictureUrl = '',
//     this.isLeader = false,
//     this.posts = const [],
//   });

//   factory UserClass.fromJson(Map<String, dynamic> json) {
//     List<ObjectId> projects = [];
//     for (var projectId in json['projects']) {
//       projects.add(ObjectId.parse(projectId));
//     }

//     List<ObjectId> postIds = [];
//     for (var postId in json['postIds']) {
//       postIds.add(ObjectId.parse(postId));
//     }

//     return UserClass(
//       email: json['email'],
//       firstName: json['firstName'],
//       lastName: json['lastName'],
//       projects: projects,
//       bio: json['bio'] ?? '',
//       profilePictureUrl: json['profilePictureUrl'] ?? '',
//       coverPictureUrl: json['coverPictureUrl'],
//       isLeader: json['isLeader'] ?? false,
//       posts: postIds,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'email': email,
//       'projects': projects.map((id) => id.toHexString()).toList(),
//       'bio': bio,
//       'profilePictureUrl': profilePictureUrl,
//       'coverPictureUrl': coverPictureUrl,
//       'isLeader': isLeader,
//       'postIds': posts.map((id) => id.toHexString()).toList(),
//     };
//   }
// }
