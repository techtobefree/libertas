import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_to_be_free/cubits/domain/user/cubit.dart';
import 'package:serve_to_be_free/data/events/handlers/event_handlers.dart';
import 'package:serve_to_be_free/widgets/ui/authorized_event_member_card.dart';
import 'package:serve_to_be_free/widgets/ui/member_card.dart'; // Import your event handlers

class ShowMembersAttending extends StatefulWidget {
  final String? eventId;

  const ShowMembersAttending({super.key, required this.eventId});

  @override
  ShowMembersAttendingState createState() => ShowMembersAttendingState();
}

class ShowMembersAttendingState extends State<ShowMembersAttending> {
  List<String>? eventMems;
  bool authorized = false;
  bool active = false;
  List<bool> isCheckedInBools = [];

  @override
  void initState() {
    super.initState();
    EventHandlers.getUEventById(widget.eventId!).then((event) {
      EventHandlers.getOwnedEvents(BlocProvider.of<UserCubit>(context).state.id)
          .then((ownedEvents) {
        if (ownedEvents.contains(event)) {
          setState(() {
            active = EventHandlers.isEventActiveFromUEvent(event!);

            authorized = true;
          });
        }
      });
      setState(() {
        eventMems = event?.membersAttending;
        for (var member in eventMems!) {
          EventHandlers.isCheckedInEvent(member, event!.id).then((value) {
            setState(() {
              isCheckedInBools.add(value);
            });
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Members',
          style: TextStyle(color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(0, 28, 72, 1.0),
                Color.fromRGBO(35, 107, 140, 1.0),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
        elevation: 0,
        centerTitle: false,
      ),
      body: eventMems == null
          ? const Center(
              child: CircularProgressIndicator(), // Show a loading indicator
            )
          : ListView.builder(
              itemCount: eventMems!.length,
              itemBuilder: (context, index) {
                if (!(authorized && active)) {
                  return MemberCard(userId: eventMems![index]);
                } else {
                  return AuthorizedEventMemberCard(
                    userId: eventMems![index],
                    eventId: widget.eventId!,
                    isCheckedIn: isCheckedInBools[index],
                  );
                }
              },
            ),
    );
  }
}
