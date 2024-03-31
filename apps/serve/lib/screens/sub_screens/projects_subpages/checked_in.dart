import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_to_be_free/data/events/handlers/event_handlers.dart';
import 'package:serve_to_be_free/models/UEvent.dart';

class CheckedIn extends StatefulWidget {
  final String eventId;

  const CheckedIn({Key? key, required this.eventId}) : super(key: key);

  @override
  CheckedInState createState() => CheckedInState();
}

class CheckedInState extends State<CheckedIn> {
  UEvent? event;

  @override
  void initState() {
    super.initState();
    EventHandlers.getUEventById(widget.eventId).then((value) => setState(
          () => event = value,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Event',
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
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
          )),
      body: Center(
        child: Column(
          children: [
            RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 20, color: Colors.black),
                children: <TextSpan>[
                  const TextSpan(text: 'Successfully checked in to '),
                  TextSpan(
                    text: event?.name ?? 'test',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  context.pushNamed("eventdetails", queryParameters: {
                    'id': widget.eventId,
                  }, pathParameters: {
                    'id': widget.eventId,
                  });
                },
                child: Text("Event Details"))
          ],
        ),
      ),
    );
  }
}
