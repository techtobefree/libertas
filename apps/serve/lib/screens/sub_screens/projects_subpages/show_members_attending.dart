import 'package:flutter/material.dart';
import 'package:serve_to_be_free/data/events/handlers/event_handlers.dart';
import 'package:serve_to_be_free/widgets/ui/member_card.dart'; // Import your event handlers

class ShowMembersAttending extends StatefulWidget {
  final String? eventId;

  const ShowMembersAttending({super.key, required this.eventId});

  @override
  ShowMembersAttendingState createState() => ShowMembersAttendingState();
}

class ShowMembersAttendingState extends State<ShowMembersAttending> {
  List<String>? eventMems;

  @override
  void initState() {
    super.initState();
    EventHandlers.getUEventById(widget.eventId!).then((proj) {
      setState(() {
        eventMems = proj?.membersAttending;
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
                return MemberCard(userId: eventMems![index]);
              },
            ),
    );
  }
}
