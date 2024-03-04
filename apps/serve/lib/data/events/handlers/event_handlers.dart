import 'dart:convert';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:serve_to_be_free/data/users/handlers/user_handlers.dart';
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

  static Future<List<UEvent>> getUUserActiveEvents(String? userId) async {
    try {
      if (userId == null) {
        return [];
      }
      final request = ModelQueries.list(UEvent.classType);
      final response = await Amplify.API.query(request: request).response;

      final uevents = response.data?.items;
      if (uevents == null) {
        safePrint('errors: ${response.errors}');
        return const [];
      }
      List<UEvent> activeEvents = [];
      for (var event in uevents) {
        if (event!.membersAttending!.contains(userId)) {
          activeEvents.add(event);
        }
      }
      DateTime currentDate = DateTime.now();

      // Filter out items with date equal to the current date
      List<UEvent> filteredEvents = activeEvents.where((event) {
        // Parse string date to DateTime
        DateTime eventDate = DateTime.parse(event.date!);
        // Check if the date matches the current date
        return eventDate.year == currentDate.year &&
            eventDate.month == currentDate.month &&
            eventDate.day == currentDate.day;
      }).toList();

      return filteredEvents;
    } on ApiException catch (e) {
      safePrint('Query failed: $e');
      return const [];
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

  static Future<UEvent?> getUEventById(String id) async {
    final queryPredicate = UEvent.ID.eq(id);

    final request = ModelQueries.list<UEvent>(
      UEvent.classType,
      where: queryPredicate,
    );
    final response = await Amplify.API.query(request: request).response;

    if (response.data!.items.isNotEmpty) {
      return response.data!.items[0];
    }

    return null;
  }

  static Future<List<String>> getAttendeesByEvent(String id) async {
    final queryPredicate = UEvent.ID.eq(id);

    final request = ModelQueries.list<UEvent>(
      UEvent.classType,
      where: queryPredicate,
    );
    final response = await Amplify.API.query(request: request).response;

    if (response.data!.items.isNotEmpty) {
      return response.data!.items[0]!.membersAttending ?? [];
    }

    return [];
  }

  static Future<List<String>> getNonAttendeesByEvent(String id) async {
    final queryPredicate = UEvent.ID.eq(id);

    final request = ModelQueries.list<UEvent>(
      UEvent.classType,
      where: queryPredicate,
    );
    final response = await Amplify.API.query(request: request).response;

    if (response.data!.items.isNotEmpty) {
      return response.data!.items[0]!.membersNotAttending ?? [];
    }

    return [];
  }

  static Future<void> addAttendee(String eventId, String userId) async {
    // UUser? user = await UserHandlers.getUUserById(userId);
    UEvent? event = await EventHandlers.getUEventById(eventId);
    List<String> attendees = await EventHandlers.getAttendeesByEvent(eventId);

    attendees.add(userId);

    if (event != null) {
      final addedAttenderUEvent = event.copyWith(membersAttending: attendees);

      try {
        final request = ModelMutations.update(addedAttenderUEvent);

        final response = await Amplify.API.mutate(request: request).response;
        safePrint('Response: ${response.data?.toString()}');
      } catch (e) {
        throw Exception('Failed to update event: $e');
      }
    } else {
      print("failed");
    }
  }

  static Future<void> addNonAttendee(String eventId, String userId) async {
    // UUser? user = await UserHandlers.getUUserById(userId);
    UEvent? event = await EventHandlers.getUEventById(eventId);
    List<String> nonattendees =
        await EventHandlers.getNonAttendeesByEvent(eventId);

    nonattendees.add(userId);

    if (event != null) {
      final addedNonAttenderUEvent =
          event.copyWith(membersNotAttending: nonattendees);

      try {
        final request = ModelMutations.update(addedNonAttenderUEvent);

        final response = await Amplify.API.mutate(request: request).response;
        safePrint('Response: ${response.data?.toString()}');
      } catch (e) {
        throw Exception('Failed to update event: $e');
      }
    } else {
      print("failed");
    }
  }

//returns: 'ATTENDING' 'NOTATTENDING' 'UNDECIDED'
  static Future<String> getMemberStatus(String eventId, String memberId) async {
    var event = await getUEventById(eventId);
    if (event != null) {
      if (event.membersAttending != null) {
        if (event.membersAttending!.contains(memberId)) {
          return 'ATTENDING';
        }
      } else if (event.membersNotAttending != null) {
        if (event.membersNotAttending!.contains(memberId)) {
          return 'NOTATTENDING';
        }
      } else {
        if (event.membersNotAttending!.contains(memberId)) {
          return 'UNDECIDED';
        }
      }
    }
    return 'UNDECIDED';
  }

  static String getMemberStatusNotAsync(UEvent event, String memberId) {
    if (event.membersAttending != null) {
      if (event.membersAttending!.contains(memberId)) {
        return 'ATTENDING';
      }
    }
    if (event.membersNotAttending != null) {
      if (event.membersNotAttending!.contains(memberId)) {
        return 'NOTATTENDING';
      }
    }
    return 'UNDECIDED';
  }
}
