import 'dart:convert';
import 'dart:io';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:serve_to_be_free/data/users/models/user_class.dart';
import 'package:serve_to_be_free/utilities/s3_image_utility.dart';
import 'package:provider/provider.dart';

import '../../../models/ModelProvider.dart';
import '../providers/user_provider.dart';

class UserHandlers {
  //static const String _baseUrl = 'http://localhost:3000/users';

  static Future<UserClass?> createUser(UserClass user) async {
    try {
      // Check if an account with the provided email already exists
      // final existingUser = await getUserByEmail(user.email);
      // if (existingUser != null) {
      //   return null;
      // }
      UUser uuser = UUser(
        password: user.password,
        email: user.email,
        firstName: user.firstName,
        lastName: user.lastName,
        profilePictureUrl: user.profilePictureUrl,
        uUserFriendsId: "724a6ce3-47ed-402e-80c0-69e75601d2dd",
        projects: const [], // Provide an empty list or add actual UProject instances
        friends: const [], // Provide an empty list or add actual UUser instances
        posts: const [], // Provide an empty list or add actual UPost instances
        sponsors: const [], // Provide an empty list or add actual USponsor instances
      );
      final request = ModelMutations.create(uuser);
      final response = await Amplify.API.mutate(request: request).response;

      // If not, create a new account
      // final response = await http.post(
      //   _baseUrl,
      //   headers: headers,
      //   body: body,
      // );
      final createdUser = response.data;
      if (createdUser == null) {
        safePrint('errors: ${response.errors}');
        return null;
      }

      return UserClass(
          id: createdUser.id,
          email: createdUser.email,
          firstName: createdUser.firstName,
          lastName: createdUser.lastName,
          password: createdUser.password,
          friendRequests: [],
          friends: [],
          posts: [],
          projects: [],
          profilePictureUrl: '');
    }

    //authenticate
    catch (e) {
      throw Exception('Failed to create user: $e');
    }
  }

  static Future<UserClass?> updateUser(
      String id, Map<String, dynamic> updatedFields) async {
    UUser? uuser = await getUUserById(id);
    final uuserWithNewProfPic =
        uuser!.copyWith(profilePictureUrl: updatedFields['profilePictureUrl']);
    // uuser.profilePictureUrl = updatedFields['profilePictureUrl'];

    // Wait for any Future values in updatedFields to complete
    // final fields = await Future.wait(updatedFields.entries.map((entry) async {
    //   final key = entry.key;
    //   final value = entry.value;
    //   return MapEntry(key, await value);
    // }));

    try {
      final request = ModelMutations.update(uuserWithNewProfPic);
      final response = await Amplify.API.mutate(request: request).response;
      safePrint('Response: $response');
      UUser? newuuser = response.data;
      if (response.data! != null) {
        return UserClass(
            id: uuser.id,
            email: newuuser!.email,
            firstName: newuuser.firstName,
            lastName: newuuser.lastName,
            password: newuuser.password,
            friendRequests: [],
            friends: [],
            posts: [],
            projects: [],
            profilePictureUrl: newuuser.profilePictureUrl ?? '');
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }

  static Future<UUser?> getUUserById(String id) async {
    final queryPredicate = UUser.ID.eq(id);

    final request = ModelQueries.list<UUser>(
      UUser.classType,
      where: queryPredicate,
    );
    final response = await Amplify.API.query(request: request).response;

    if (response.data!.items.isNotEmpty) {
      return response.data!.items[0];
    }

    return null;
  }

  static Future<List<dynamic>> getUsers() async {
    var jsonResponse = await getUUsers();
    var projects = [];
    for (var uproject in jsonResponse) {
      projects.add(uproject!.toJson());
    }
    // print(jsonResponse);
    return projects;
  }

  static Future<UUser?> getUUserByEmail(String email) async {
    final queryPredicate = UUser.EMAIL.eq(email);

    final request = ModelQueries.list<UUser>(
      UUser.classType,
      where: queryPredicate,
    );
    final response = await Amplify.API.query(request: request).response;

    if (response.data!.items.isNotEmpty) {
      return response.data!.items[0];
    }

    return null;
  }

  static Future<void> signInUser(String username, String password) async {
    try {
      final result = await Amplify.Auth.signIn(
        username: username,
        password: password,
      );
      print('signed in auth');
    } on AuthException catch (e) {
      safePrint('Error signing in: ${e.message}');
    }
  }

  static Future<List<UUser?>> getUUsers() async {
    try {
      final request = ModelQueries.list(UUser.classType);
      final response = await Amplify.API.query(request: request).response;

      final uusers = response.data?.items;
      if (uusers == null) {
        safePrint('errors: ${response.errors}');
        return const [];
      }
      return uusers;
    } on ApiException catch (e) {
      safePrint('Query failed: $e');
      return const [];
    }
  }

  static Future<UserClass?> getUserByEmail(String email) async {
    final queryPredicate = UUser.EMAIL.eq(email);

    final request = ModelQueries.list<UUser>(
      UUser.classType,
      where: queryPredicate,
    );
    final response = await Amplify.API.query(request: request).response;
    if (response.data != null) {
      final uuser = response.data?.items[0];
      final user = UserClass(
          id: uuser!.id,
          email: uuser.email,
          password: uuser.password,
          firstName: uuser.firstName,
          lastName: uuser.lastName,
          projects: [],
          profilePictureUrl: uuser.profilePictureUrl!,
          friends: [],
          friendRequests: [],
          posts: []);
      return user;
    }

    return null;

    // final response = await http.get(Uri.parse('$_baseUrl/email/$email'));

    // if (response.statusCode == 200) {
    //   final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
    //   return UserClass.fromJson(jsonResponse);
    // } else {
    //   return null;
    // }
  }
}
