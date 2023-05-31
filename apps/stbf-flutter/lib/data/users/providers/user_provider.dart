import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:serve_to_be_free/data/users/models/user_class.dart';

class UserProvider extends ChangeNotifier {
  final String _baseUrl = 'http://44.203.120.103:3000/users';

  late String id;
  late String email;
  late String password;
  late String firstName;
  late String lastName;
  late String profilePictureUrl = "";
  late String bio;
  late String coverPictureUrl;
  late bool isLeader;
  late List<String> friends;
  late List<String> friendRequests;

  // void updateUser({
  //   required String id,
  //   required String email,
  //   required String password,
  //   required String firstName,
  //   required String lastName,
  //   required String profilePictureUrl,
  //   required String bio,
  //   required String coverPictureUrl,
  //   required bool isLeader,
  //   required List<String> friends,
  //   required List<String> friendRequests,
  // }) {
  //   this.id = id;
  //   this.email = email;
  //   this.password = password;
  //   this.firstName = firstName;
  //   this.lastName = lastName;
  //   this.profilePictureUrl = profilePictureUrl;
  //   this.bio = bio;
  //   this.coverPictureUrl = coverPictureUrl;
  //   this.isLeader = isLeader;
  //   this.friends = friends;
  //   this.friendRequests = friendRequests;

  notifyListeners();
}

  // Future<UserClass?> getUserByEmail(String email) async {
  //   final response = await http.get(Uri.parse('$_baseUrl?email=$email'));

  //   if (response.statusCode == 200) {
  //     final List<dynamic> usersJson = jsonDecode(response.body);
  //     for (final userJson in usersJson) {
  //       if (userJson['email'] == email) {
  //         return UserClass.fromJson(userJson);
  //       }
  //     }
  //   } else {
  //     throw Exception('Failed to get User');
  //   }
  //   return null; // no matching user found
  // }

  // add additional methods as needed
  // Future<void> updateUser(UserClass User) async {
  // var url = Uri.parse('https://example.com/api/Users/${User.id}');
  // var response = await http.put(url, body: User.toJson());
  // if (response.statusCode != 200) {
  //   throw Exception('Failed to update User');
  // }
  //   notifyListeners();
  // }

