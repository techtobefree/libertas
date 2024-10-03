import 'dart:convert';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:serve_to_be_free/data/projects/project_handlers.dart';
import 'package:serve_to_be_free/models/UProject.dart';
import 'package:serve_to_be_free/models/UPost.dart';

class PostHandlers {
  static const String _baseUrl = 'http://44.203.120.103:3000';

  static Future<List<UPost>> getPostsByProjectId(String projectId) async {
    final url = Uri.parse('$_baseUrl/projects/$projectId/sponsors');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = jsonDecode(response.body);
        final sponsors =
            jsonResponse.map((data) => UPost.fromJson(data)).toList();
        return sponsors;
      } else {
        throw Exception('Failed to get sponsors');
      }
    } catch (e) {
      throw Exception('Failed to get sponsors: $e');
    }
  }

  static Future<UPost?> createUPost(UPost sponsor) async {
    try {
      final request = ModelMutations.create(sponsor);
      final response = await Amplify.API.mutate(request: request).response;

      // If not, create a new account
      // final response = await http.post(
      //   _baseUrl,
      //   headers: headers,
      //   body: body,
      // );
      final createdPost = response.data;
      if (createdPost == null) {
        safePrint('errors: ${response.errors}');
        return null;
      } else {
        return createdPost;
      }
    } catch (exeption) {
      throw Exception('Failed to get sponsors: $exeption');
    }
  }

  static Future<List<UPost?>?> getUPostsByProject(String projId) async {
    // final proj = await ProjectHandlers.getUProjectById(projId);
    final queryPredicate = UPost.PROJECT.eq(projId);

    final request = ModelQueries.list<UPost>(
      UPost.classType,
      where: queryPredicate,
    );
    final response = await Amplify.API.query(request: request).response;
    if (response.data != null) {
      return response.data?.items;
    } else {
      print('get posts failed');
      return null;
    }
  }

  static Future<List<UPost?>?> getAllUPosts() async {
    try {
      final request = ModelQueries.list(UPost.classType);
      final response = await Amplify.API.query(request: request).response;

      final usponsors = response.data?.items;
      if (usponsors == null) {
        safePrint('errors: ${response.errors}');
        return const [];
      }
      return usponsors;
    } on ApiException catch (e) {
      safePrint('Query failed: $e');
      return const [];
    }
  }

  static Future<List<UPost?>> getPostsByID(String userId) async {
    try {
      // Fetching leader requests where the ownerID matches the provided ownerID
      final queryPredicate = UPost.USER.eq(userId);
      final request = ModelQueries.list<UPost>(
        UPost.classType,
        where: queryPredicate,
      );

      final response = await Amplify.API.query(request: request).response;

      if (response.data != null) {
        return response.data!.items;
      } else {
        safePrint('errors: ${response.errors}');
        return [];
      }
    } catch (e) {
      throw Exception('Failed to get leader requests by owner: $e');
    }
  }

  static Future<void> deleteUPost(UPost post) async {
    final request = ModelMutations.delete(post);
    final response = await Amplify.API.mutate(request: request).response;
    safePrint('Response: $response');
  }
}
