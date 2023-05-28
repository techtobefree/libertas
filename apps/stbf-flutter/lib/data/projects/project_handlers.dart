import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:serve_to_be_free/data/users/models/user_class.dart';
import 'package:serve_to_be_free/utilities/s3_image_utility.dart';
import 'package:provider/provider.dart';

import 'package:serve_to_be_free/data/users/providers/user_provider.dart';

class ProjectHandlers {
  //static const String _baseUrl = 'http://localhost:3000/projects';
  static const String _baseUrl = 'http://44.203.120.103:3000/projects';

  static Future<List<dynamic>> getProjects() async {
    var url = Uri.parse('http://44.203.120.103:3000/projects');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      // print(jsonResponse);
      return jsonResponse;
    } else {
      throw Exception('Failed to load projects');
    }
  }

  static Future<Map<String, dynamic>> getProjectById(projectId) async {
    var url = Uri.parse('http://44.203.120.103:3000/projects/${projectId}');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      throw Exception('Failed to load projects');
    }
  }

  static Future<List<dynamic>> getProjectsIncomplete() async {
    var url = Uri.parse('$_baseUrl/incomplete'); // Use the new endpoint
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      throw Exception('Failed to load projects');
    }
  }

  // Future<void> addMember(projId) async {
  //   final url =
  //       Uri.parse('http://44.203.120.103:3000/projects/${projId}/member');
  //   final Map<String, dynamic> data = {
  //     'memberId': Provider.of<UserProvider>(context, listen: false).id
  //   };
  //   final response = await http.put(
  //     url,
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(data),
  //   );

  //   if (response.statusCode == 200) {
  //     // API call successful\
  //   } else {
  //     // API call unsuccessful
  //     print('Failed to fetch data');
  //   }
  // }

  static Future<void> addSponsor(projId, sponsorData) async {
    print(sponsorData);
    final url =
        Uri.parse('http://44.203.120.103:3000/projects/$projId/sponsors');
    //final Map<String, dynamic> data = {'amount': '', 'user': userId};
    final response = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(sponsorData),
    );

    if (response.statusCode == 201) {
      // Sponsor created successfully
      final sponsorId = jsonDecode(response.body)['_id'];
      print('Sponsor created successfully with ID: $sponsorId');
    } else {
      // Failed to create sponsor
      print('Failed to create sponsor');
    }
  }
}
