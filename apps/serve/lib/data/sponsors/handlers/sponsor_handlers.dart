import 'dart:convert';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:serve_to_be_free/data/projects/project_handlers.dart';
import 'package:serve_to_be_free/models/UProject.dart';
import 'package:serve_to_be_free/models/USponsor.dart';
import '../models/sponsor_model.dart';

class SponsorHandlers {
  static const String _baseUrl = 'http://44.203.120.103:3000';

  static Future<List<Sponsor>> getSponsorsByProjectId(String projectId) async {
    final url = Uri.parse('$_baseUrl/projects/$projectId/sponsors');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = jsonDecode(response.body);
        final sponsors =
            jsonResponse.map((data) => Sponsor.fromJson(data)).toList();
        return sponsors;
      } else {
        throw Exception('Failed to get sponsors');
      }
    } catch (e) {
      throw Exception('Failed to get sponsors: $e');
    }
  }

  static Future<USponsor?> createUSponsor(USponsor sponsor) async {
    try {
      final request = ModelMutations.create(sponsor);
      final response = await Amplify.API.mutate(request: request).response;

      // If not, create a new account
      // final response = await http.post(
      //   _baseUrl,
      //   headers: headers,
      //   body: body,
      // );
      final createdSponsor = response.data;
      if (createdSponsor == null) {
        safePrint('errors: ${response.errors}');
        return null;
      } else {
        return createdSponsor;
      }
    } catch (exeption) {
      throw Exception('Failed to get sponsors: $exeption');
    }
  }

  static Future<List<USponsor?>?> getUSponsorsByProject(String projId) async {
    // final proj = await ProjectHandlers.getUProjectById(projId);
    final queryPredicate = USponsor.PROJECT.eq(projId);

    final request = ModelQueries.list<USponsor>(
      USponsor.classType,
      where: queryPredicate,
    );
    final response = await Amplify.API.query(request: request).response;
    if (response.data != null) {
      return response.data?.items;
    } else {
      print('get sponsors failed');
      return null;
    }
  }

  static Future<List<USponsor?>?> getUSponsorsByUser(String userId) async {
    // final proj = await ProjectHandlers.getUProjectById(projId);
    final queryPredicate = USponsor.USER.eq(userId);

    final request = ModelQueries.list<USponsor>(
      USponsor.classType,
      where: queryPredicate,
    );
    final response = await Amplify.API.query(request: request).response;
    if (response.data != null) {
      return response.data?.items;
    } else {
      print('get sponsors failed');
      return null;
    }
  }

  static Future<void> deleteUSponsor(USponsor sponsor) async {
    final request = ModelMutations.delete(sponsor);
    final response = await Amplify.API.mutate(request: request).response;
    safePrint('Response: $response');
  }

  static Future<List<USponsor?>?> getAllUSponsors() async {
    try {
      final request = ModelQueries.list(USponsor.classType);
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

  static Future<double> getUSponsorAmountByProject(String projId) async {
    var sponsors = await getUSponsorsByProject(projId);
    // var sponsors = await getAllUSponsors();

    double amount = 0;
    if ((sponsors != null) && sponsors.isNotEmpty) {
      for (var sponsor in sponsors) {
        amount += sponsor!.amount;
      }
    }
    return amount;
  }
}
