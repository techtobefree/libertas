import 'dart:convert';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:serve_to_be_free/models/ModelProvider.dart';

class EventHandlers {
  static Future<UEvent?> createUEvent(UEvent event) async {
    try {
      final request = ModelMutations.create(event);
      final response = await Amplify.API.mutate(request: request).response;

      final createdEvent = response.data;
      if (createdEvent == null) {
        safePrint('errors: ${response.errors}');
        return null;
      } else {
        return createdEvent;
      }
    } catch (exeption) {
      throw Exception('Failed to get events: $exeption');
    }
  }

  static Future<List<UEvent?>> getUEventsByProject(String projId) async {
    final queryPredicate = UEvent.PROJECT.eq(projId);

    final request = ModelQueries.list<UEvent>(
      UEvent.classType,
      where: queryPredicate,
    );
    final response = await Amplify.API.query(request: request).response;
    if (response.data != null) {
      return response.data?.items ?? [];
    } else {
      print('get events failed');
      return [];
    }
  }

  static Future<List<UEvent?>?> getAllUEvents() async {
    try {
      final request = ModelQueries.list(UEvent.classType);
      final response = await Amplify.API.query(request: request).response;

      final uevents = response.data?.items;
      if (uevents == null) {
        safePrint('errors: ${response.errors}');
        return const [];
      }
      return uevents;
    } on ApiException catch (e) {
      safePrint('Query failed: $e');
      return const [];
    }
  }
}
