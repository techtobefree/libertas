import 'dart:convert';
import 'package:http/http.dart' as http;
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

  // static Future<Sponsor?> createSponsorForProject(
  //     String projectId, Sponsor sponsor, double amount) async {
  //   final url = Uri.parse('$_baseUrl/projects/$projectId/sponsors');
  //   final headers = <String, String>{
  //     'Content-Type': 'application/json; charset=UTF-8',
  //   };

  //   // Include the amount in the sponsor object
  //   sponsor.amount = amount;

  //   final body = jsonEncode(sponsor.toJson());

  //   try {
  //     final response = await http.post(
  //       url,
  //       headers: headers,
  //       body: body,
  //     );

  //     if (response.statusCode == 201) {
  //       final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
  //       return Sponsor.fromJson(jsonResponse);
  //     } else {
  //       return null;
  //     }
  //   } catch (e) {
  //     throw Exception('Failed to create sponsor: $e');
  //   }
  // }
}
