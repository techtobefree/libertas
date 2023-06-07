import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:serve_to_be_free/data/users/models/user_class.dart';
import 'package:serve_to_be_free/utilities/s3_image_utility.dart';

class UserHandlers {
  //static const String _baseUrl = 'http://localhost:3000/users';
  static const String _baseUrl = 'http://44.203.120.103:3000/users';

  static Future<UserClass?> createUser(UserClass user) async {
    final _baseUrl = Uri.parse('http://44.203.120.103:3000/users');
    final headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final body = jsonEncode(user.toJson());

    try {
      // Check if an account with the provided email already exists
      final existingUser = await getUserByEmail(user.email);
      if (existingUser != null) {
        return null;
      }

      // If not, create a new account
      final response = await http.post(
        _baseUrl,
        headers: headers,
        body: body,
      );
      if (response.statusCode == 201) {
        print(response.body);

        final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        final createdUser = UserClass.fromJson(jsonResponse);
        print(createdUser.id);

        return UserClass.fromJson(jsonResponse);
      } else {
        return null;
      }

      //authenticate
    } catch (e) {
      throw Exception('Failed to create user: $e');
    }
  }

  static Future<UserClass?> updateUser(
      String id, Map<String, dynamic> updatedFields) async {
    final headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };

    // Wait for any Future values in updatedFields to complete
    final fields = await Future.wait(updatedFields.entries.map((entry) async {
      final key = entry.key;
      final value = entry.value;
      return MapEntry(key, await value);
    }));

    final body = jsonEncode(Map.fromEntries(fields));

    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/$id/updateUser'),
        headers: headers,
        body: body,
      );
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        return UserClass.fromJson(jsonResponse);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }

  static Future<UserClass?> getUserByEmail(String email) async {
    final response = await http.get(Uri.parse('$_baseUrl/email/$email'));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      return UserClass.fromJson(jsonResponse);
    } else {
      return null;
    }
  }
}
