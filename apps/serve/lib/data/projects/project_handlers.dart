import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:serve_to_be_free/data/events/handlers/event_handlers.dart';
import 'package:serve_to_be_free/data/sponsors/handlers/sponsor_handlers.dart';
import 'package:serve_to_be_free/data/users/handlers/user_handlers.dart';
import 'package:serve_to_be_free/models/ModelProvider.dart';

class ProjectHandlers {
  //static const String _baseUrl = 'http://localhost:3000/projects';
  //static const String _baseUrl = 'http://44.203.120.103:3000/projects';

  static Future<UProject?> getUProjectById(String id) async {
    final queryPredicate = UProject.ID.eq(id);

    final request = ModelQueries.list<UProject>(
      UProject.classType,
      where: queryPredicate,
    );
    final response = await Amplify.API.query(request: request).response;

    if (response.data!.items.isNotEmpty) {
      return response.data!.items[0];
    }

    return null;
  }

  static Future<List<UProject?>> getUProjects() async {
    try {
      final request = ModelQueries.list(UProject.classType);
      final response = await Amplify.API.query(request: request).response;

      final uprojects = response.data?.items;
      if (uprojects == null) {
        safePrint('errors: ${response.errors}');
        return const [];
      }
      return uprojects;
    } on ApiException catch (e) {
      safePrint('Query failed: $e');
      return const [];
    }
  }

  static Future<List<dynamic>> getProjects() async {
    var jsonResponse = await getUProjects();
    var projects = [];
    for (var uproject in jsonResponse) {
      projects.add(uproject!.toJson());
    }
    // print(jsonResponse);
    return projects;
  }

  static void finishProject(projectId) async {
    UProject? uproject = await getUProjectById(projectId);
    final uprojFinished = uproject!.copyWith(isCompleted: true);
    try {
      final request = ModelMutations.update(uprojFinished);
      final _ = await Amplify.API.mutate(request: request).response;
    } catch (e) {
      throw Exception('Failed to finish project: $e');
    }
  }

  static void addHours(projectId, hours) async {
    UProject? uproject = await getUProjectById(projectId);
    double doubleHours = hours.toDouble();
    final uprojFinished = uproject!.copyWith(hoursSpent: doubleHours);
    try {
      final request = ModelMutations.update(uprojFinished);
      final _ = await Amplify.API.mutate(request: request).response;
    } catch (e) {
      throw Exception('Failed to add hours project: $e');
    }
  }

  static Future<Map<String, dynamic>> getProjectById(projectId) async {
    var url = Uri.parse('http://44.203.120.103:3000/projects/$projectId');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      throw Exception('Failed to load projects');
    }
  }

  static Future<List<UProject>> getMyUProjects(String id) async {
    try {
      var projects = await ProjectHandlers.getUProjects();
      var myUProjs = <UProject>[];

      for (var project in projects) {
        if (project!.members!.contains(id)) {
          myUProjs.add(project);
        }
      }

      return myUProjs;
    } on ApiException catch (e) {
      safePrint('Query failed: $e');
      return const [];
    }
  }

  static Future<List<dynamic>> getMyProjects(id) async {
    var projects = await ProjectHandlers.getProjects();
    var myprojs = [];
    for (var project in projects) {
      for (var member in project['members']) {
        if (id == member) {
          myprojs.add(project);
        }
      }
    }
    return myprojs;
  }

  static Future<List<dynamic>> getProjectsIncomplete() async {
    var projects = await ProjectHandlers.getProjects();
    var incompleteProjs = [];
    for (var project in projects) {
      if (project["isCompleted"] == false) {
        if (project["sponsors"] == null) {
          project["sponsors"] = [];
        }
        incompleteProjs.add(project);
      }
    }
    return incompleteProjs;
  }

  static Future<List<dynamic>> getProjectsWithLeader() async {
    var projects = await ProjectHandlers.getProjects();
    var projsWithLeader = [];
    for (var project in projects) {
      if (project["isCompleted"] == false) {
        if (project["leader"] != null && project["leader"].isNotEmpty) {
          if (project["sponsors"] == null) {
            project["sponsors"] = [];
          }
          projsWithLeader.add(project);
        }
      }
    }
    return projsWithLeader;
  }

  static Future<List<dynamic>> getProjectsWithoutLeader() async {
    var projects = await ProjectHandlers.getProjects();
    var projsWithLeader = [];
    for (var project in projects) {
      if (project["isCompleted"] == false) {
        if (project["leader"] == null || project["leader"].isEmpty) {
          if (project["sponsors"] == null) {
            project["sponsors"] = [];
          }
          projsWithLeader.add(project);
        }
      }
    }
    return projsWithLeader;
  }

  static Future<void> addLeader(projId, leaderId) async {
    UProject? uproject = await ProjectHandlers.getUProjectById(projId);
    var uprojectMems = uproject!.members;
    var memID = leaderId;
    if (uprojectMems != null) {
      if (!uprojectMems.contains(memID)) {
        uprojectMems.add(memID);
      }
    }

    final addedMemUProj =
        uproject.copyWith(members: uprojectMems, leader: memID);

    try {
      final request = ModelMutations.update(addedMemUProj);
      final response = await Amplify.API.mutate(request: request).response;
      safePrint('Response: $response');
    } catch (e) {
      throw Exception('Failed to update project: $e');
    }
  }

  static Future<void> removeMember(projId, userId) async {
  UProject? uproject =
        await ProjectHandlers.getUProjectById(projId);
    var uprojectMems = uproject!.members;
    if (uprojectMems != null) {
      uprojectMems.remove(userId);
    }

    final removedMemUProj = uproject.copyWith(members: uprojectMems);

    try {
      final request = ModelMutations.update(removedMemUProj);
      final response = await Amplify.API.mutate(request: request).response;
      safePrint('Response: $response');
      
    } catch (e) {
      throw Exception('Failed to update project: $e');
    }
  }

  static Future<void> addSponsor(String projId, sponsorData, userId) async {
    UUser? user = await UserHandlers.getUUserById(userId);
    UProject? project = await ProjectHandlers.getUProjectById(projId);
    USponsor newSponsor =
        USponsor(amount: sponsorData["amount"], project: project, user: user);

    USponsor? createdSponsor = await SponsorHandlers.createUSponsor(newSponsor);
    if (createdSponsor != null) {
      var proj = await ProjectHandlers.getUProjectById(projId);
      var projSponsors = proj!.sponsors;
      if (proj != null) {
        var sponsors = proj.sponsors ?? [];
        if (projSponsors == null) {
          projSponsors = [createdSponsor];
        } else {
          projSponsors.add(createdSponsor);
        }

        sponsors.add(createdSponsor);

        final addedSponsorUProj = proj.copyWith(sponsors: sponsors);

        try {
          final request = ModelMutations.update(addedSponsorUProj);
          final response = await Amplify.API.mutate(request: request).response;
          safePrint('Response: $response');
        } catch (e) {
          throw Exception('Failed to update project: $e');
        }
      } else {
        print("failed");
      }
    }
  }

  static Future<void> addEvent(String projId, UEvent event) async {
    UProject? project = await ProjectHandlers.getUProjectById(projId);
    UEvent? createdEvent = await EventHandlers.createUEvent(event);

    if (createdEvent != null) {
      if (project != null) {
        var events = project.events ?? [];

        events.add(createdEvent);

        final addedEventUProj = project.copyWith(events: events);

        try {
          final request = ModelMutations.update(addedEventUProj);
          final response = await Amplify.API.mutate(request: request).response;
          safePrint('Response: $response');
        } catch (e) {
          throw Exception('Failed to update project: $e');
        }
      } else {
        print("project loading failed");
      }
    } else {
      print("failed");
    }
  }
}
