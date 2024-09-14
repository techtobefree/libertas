import 'dart:convert';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:serve_to_be_free/data/eventcheckin/handlers/eventcheckin_handlers.dart';
import 'package:serve_to_be_free/data/users/handlers/user_handlers.dart';
import 'package:serve_to_be_free/models/ModelProvider.dart';
import 'dart:math';

class EventHandlers {
  static Future<UEvent?> createUEvent(UEvent event) async {
    try {
      String checkInCodeGen;
      if (event.checkInCode == null) {
        checkInCodeGen = (1000 + Random.secure().nextInt(9000)).toString();
      } else {
        checkInCodeGen = event.checkInCode!;
      }
      UEvent eventWithCode = event.copyWith(checkInCode: checkInCodeGen);
      final request = ModelMutations.create(eventWithCode);
      final response = await Amplify.API.mutate(request: request).response;

      final createdEvent = response.data;
      if (createdEvent == null) {
        safePrint('errors: ${response.errors}');

        return null;
      } else {
        final projEvents = event.project.events ?? [];
        projEvents.add(event);
        final addedEventUProj = event.project.copyWith(events: projEvents);

        try {
          final request = ModelMutations.update(addedEventUProj);
          final response = await Amplify.API.mutate(request: request).response;
          safePrint('Response: $response');
        } catch (e) {
          throw Exception('Failed to update project: $e');
        }
        return createdEvent;
      }
    } catch (exeption) {
      throw Exception('Failed to get events: $exeption');
    }
  }

  static Future<UEvent?> removeMember(String eventId, String memberId) async {
    UEvent? event = await getUEventById(eventId);
    var newMembersAttending = event!.membersAttending ?? [];
    var newMembersNotAttending = event.membersNotAttending ?? [];
    newMembersAttending.remove(memberId);

    newMembersNotAttending.remove(memberId);

    UEvent updatedEvent = event.copyWith(
        membersAttending: newMembersAttending,
        membersNotAttending: newMembersNotAttending);
    await updateUEvent(updatedEvent);
    return updatedEvent;
  }

  static Future<UEvent?> updateUEvent(UEvent event) async {
    try {
      final request = ModelMutations.update(event);
      final response = await Amplify.API.mutate(request: request).response;

      final updatedEvent = response.data;
      if (updatedEvent == null) {
        safePrint('errors: ${response.errors}');
        return null;
      } else {
        return updatedEvent;
      }
    } catch (exeption) {
      throw Exception('Failed to get events: $exeption');
    }
  }

  static Future<bool> isCheckedInEvent(String userId, String eventId) async {
    final queryPredicateEvent = UEventCheckIn.UEVENTCHECKINEVENTID.eq(eventId);
    final queryPredicateUser = UEventCheckIn.UEVENTCHECKINUSERID.eq(userId);

    final queryPredicate = queryPredicateEvent.and(queryPredicateUser);

    final request = ModelQueries.list<UEventCheckIn>(
      UEventCheckIn.classType,
      where: queryPredicate,
    );
    final response = await Amplify.API.query(request: request).response;
    if (response.data != null) {
      return (response.data?.items.isNotEmpty) ?? false;
    } else {
      print('get events failed');
      return false;
    }
  }

  static Future<List<UEvent?>> getOwnedEvents(String userId) async {
    // UUser? user = await UserHandlers.getUUserById(userId);

    final queryPredicate = UEvent.UEVENTOWNERID.eq(userId);

    final request = ModelQueries.list<UEvent>(
      UEvent.classType,
      where: queryPredicate,
    );
    final response = await Amplify.API.query(request: request).response;
    if (response.data != null) {
      return response.data?.items ?? [];
    } else {
      print('get owned events failed');
      return [];
    }
  }

  static Future<bool> isEventActive(String eventId) async {
    UEvent? event = await getUEventById(eventId);
    DateTime currentDate = DateTime.now();

    DateTime eventDate = DateTime.parse(event!.date!);
    return eventDate.year == currentDate.year &&
        eventDate.month == currentDate.month &&
        eventDate.day == currentDate.day;
  }

  static bool isEventActiveFromUEvent(UEvent event) {
    DateTime currentDate = DateTime.now();

    DateTime eventDate = DateTime.parse(event.date!);
    return eventDate.year == currentDate.year &&
        eventDate.month == currentDate.month &&
        eventDate.day == currentDate.day;
  }

  static Future<List<UEvent?>> getUUserRSVPEvents(String? userId) async {
    try {
      if (userId == null) {
        return [];
      }

      final queryPredicate = UEvent.MEMBERSATTENDING.contains(userId);

      final request =
          ModelQueries.list(UEvent.classType, where: queryPredicate);
      final response = await Amplify.API.query(request: request).response;

      return response.data?.items ?? [];
    } on ApiException catch (e) {
      safePrint('Query failed: $e');
      return const [];
    }
  }

  static Future<List<UEvent>> getUEventsIncludingUser(String id) async {
    try {
      var events = await getAllUEvents();
      var myUEvents = <UEvent>[];

      for (var event in events!) {
        if (event!.membersAttending!.contains(id) ||
            event!.membersNotAttending!.contains(id)) {
          myUEvents.add(event);
        }
      }

      return myUEvents;
    } on ApiException catch (e) {
      safePrint('Query failed: $e');
      return const [];
    }
  }

  static Future<List<UEvent?>> getUUserActiveEvents(String? userId) async {
    try {
      if (userId == null) {
        return [];
      }

      List<UEvent?> activeEvents = await getUUserRSVPEvents(userId);

      DateTime currentDate = DateTime.now();

      // Filter out items with date equal to the current date
      List<UEvent?> filteredEvents = activeEvents.where((event) {
        // Parse string date to DateTime
        DateTime eventDate = DateTime.parse(event!.date!);
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

  static Future<UEventCheckIn?> checkInUEventFromIds(
      String eventId, String userId,
      {String? details}) async {
    UUser? user = await UserHandlers.getUUserById(userId);
    UEvent? event = await getUEventById(eventId);
    if ((user != null) && (event != null)) {
      return await checkInUEvent(event, user, details);
    } else {
      return null;
    }
  }

  static Future<UEventCheckIn?> checkInUEvent(
      UEvent event, UUser user, String? details) async {
    UEventCheckIn eventCheckIn = UEventCheckIn(
        event: event,
        user: user,
        datetime: DateTime.now().toString(),
        uEventCheckInEventId: event.id,
        uEventCheckInUserId: user.id,
        details: details);

    return await EventCheckInHandlers.createCheckIn(eventCheckIn);
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

  static Future<List<UEvent?>> getPastUEventsByProject(String projId) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day).toIso8601String();

    // Extend the queryPredicate to filter by both project ID and past dates
    final queryPredicate = UEvent.PROJECT.eq(projId).and(UEvent.DATE.lt(today));

    final request = ModelQueries.list<UEvent>(
      UEvent.classType,
      where: queryPredicate,
    );

    final response = await Amplify.API.query(request: request).response;

    if (response.data != null) {
      // The server will only return past events
      return response.data!.items.where((ev) => ev != null).toList();
    } else {
      print('get events failed');
      return [];
    }
  }

  // static Future<List<UEvent?>> getPastUEventsByProject(String projId) async {
  //   final queryPredicate = UEvent.PROJECT.eq(projId);

  //   final request = ModelQueries.list<UEvent>(
  //     UEvent.classType,
  //     where: queryPredicate,
  //   );
  //   final response = await Amplify.API.query(request: request).response;
  //   if (response.data != null) {
  //     List<UEvent?> currentAndUpcoming = [];
  //     for (var ev in response.data!.items) {
  //       if (DateTime.parse(ev!.date!).isBefore(DateTime(
  //           DateTime.now().year, DateTime.now().month, DateTime.now().day))) {
  //         currentAndUpcoming.add(ev);
  //       }
  //     }
  //     return currentAndUpcoming;
  //   } else {
  //     print('get events failed');
  //     return [];
  //   }
  // }

  // static Future<List<UEvent?>> getUpcomingAndCurrentUEventsByProject(
  //     String projId) async {
  //   final queryPredicate = UEvent.PROJECT.eq(projId);

  //   final request = ModelQueries.list<UEvent>(
  //     UEvent.classType,
  //     where: queryPredicate,
  //   );
  //   final response = await Amplify.API.query(request: request).response;
  //   if (response.data != null) {
  //     List<UEvent?> currentAndUpcoming = [];
  //     for (var ev in response.data!.items) {
  //       if (!DateTime.parse(ev!.date!).isBefore(DateTime(
  //           DateTime.now().year, DateTime.now().month, DateTime.now().day))) {
  //         currentAndUpcoming.add(ev);
  //       }
  //     }
  //     return currentAndUpcoming;
  //   } else {
  //     print('get events failed');
  //     return [];
  //   }
  // }
  static Future<List<UEvent?>> getUpcomingAndCurrentUEventsByProject(
      String projId) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day).toIso8601String();

    // Extend the queryPredicate to filter by both project ID and date
    final queryPredicate = UEvent.PROJECT.eq(projId).and(UEvent.DATE.ge(today));

    final request = ModelQueries.list<UEvent>(
      UEvent.classType,
      where: queryPredicate,
    );

    final response = await Amplify.API.query(request: request).response;

    if (response.data != null) {
      // The server will only return current and upcoming events
      return response.data!.items.where((ev) => ev != null).toList();
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

  static Future<void> deleteUEvent(UEvent event) async {
    final request = ModelMutations.delete(event);
    final response = await Amplify.API.mutate(request: request).response;
    safePrint('Response: $response');
  }

  static Future<void> deleteUEventfromId(String eventId) async {
    UEvent? event = await getUEventById(eventId);
    if (event != null) {
      deleteUEvent(event);
    }
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
      }
      if (event.membersNotAttending != null) {
        if (event.membersNotAttending!.contains(memberId)) {
          return 'NOTATTENDING';
        }
      }
    }
    return 'UNDECIDED';
  }

  static Future<void> addLeader(eventId, leaderId) async {
    UEvent? uevent = await getUEventById(eventId);
    UUser? leader = await UserHandlers.getUUserById(leaderId);
    var ueventMems = uevent!.membersAttending;
    var memID = leaderId;
    if (ueventMems != null) {
      if (!ueventMems.contains(memID)) {
        ueventMems.add(memID);
      }
    }

    final addedMemUEvent = uevent.copyWith(
        membersAttending: ueventMems, leader: leader, uEventLeaderId: leaderId);

    try {
      final request = ModelMutations.update(addedMemUEvent);
      final response = await Amplify.API.mutate(request: request).response;
      safePrint('Response: $response');
    } catch (e) {
      throw Exception('Failed to update project: $e');
    }
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
