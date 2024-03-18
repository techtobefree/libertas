import 'dart:convert';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:serve_to_be_free/data/events/handlers/event_handlers.dart';
import 'package:serve_to_be_free/data/users/handlers/user_handlers.dart';
import 'package:serve_to_be_free/models/ModelProvider.dart';

class EventCheckInHandlers {
  static Future<UEventCheckIn?> createCheckIn(UEventCheckIn newCheckIn) async {
    try {
      final request = ModelMutations.create(newCheckIn);
      final response = await Amplify.API.mutate(request: request).response;

      final createdCheckIn = response.data;
      if (createdCheckIn == null) {
        safePrint('errors: ${response.errors}');
        return null;
      } else {
        return createdCheckIn;
      }
    } catch (exeption) {
      throw Exception('Failed to get events: $exeption');
    }
  }

  static Future<List<UEvent>> getCheckedInActiveEvents(String userId) async {
    final user = await UserHandlers.getUUserById(userId);
    List<UEventCheckIn?> checkIns = [];
    if (user != null) {
      checkIns = await getUserCheckedIns(user);
    }
    List<UEvent> activeevents =
        await EventHandlers.getUUserActiveEvents(userId);
    List<UEvent> checkedInActiveEvents = [];
    for (var event in activeevents) {
      for (var checkIn in checkIns) {
        UEvent? checkInEvent =
            await EventHandlers.getUEventById(checkIn!.uEventCheckInEventId);
        if (checkInEvent == event) {
          checkedInActiveEvents.add(event);
        }
      }
    }
    return checkedInActiveEvents;
  }

  // static Future<List<UEventCheckIn?>> getUserCheckedIns(UUser user) async {
  //   final queryPredicate = UEventCheckIn.USER.eq(user.id);

  //   final request = ModelQueries.list<UEventCheckIn>(
  //     UEventCheckIn.classType,
  //     where: queryPredicate,
  //   );
  //   final response = await Amplify.API.query(request: request).response;
  //   final ueventcheckins = response.data?.items;
  //   if (ueventcheckins != null) {
  //     return ueventcheckins;
  //   }

  //   return [];
  // }

  static Future<List<UEventCheckIn?>> getUserCheckedIns(UUser user) async {
    final allCheckIns = await getCheckIns();
    List<UEventCheckIn> userCheckedIns = [];
    for (var checkIn in allCheckIns) {
      UUser? checkInUser =
          await UserHandlers.getUUserById(checkIn!.uEventCheckInUserId);
      if (checkInUser == user) {
        userCheckedIns.add(checkIn);
      }
    }
    return userCheckedIns;
  }

  static Future<List<UEventCheckIn?>> getCheckIns() async {
    final request = ModelQueries.list<UEventCheckIn>(
      UEventCheckIn.classType,
    );
    final response = await Amplify.API.query(request: request).response;
    final ueventcheckins = response.data?.items;
    if (ueventcheckins != null) {
      return ueventcheckins;
    }

    return [];
  }
}
