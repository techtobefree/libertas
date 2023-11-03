import 'package:flutter/material.dart';
import 'package:serve_to_be_free/widgets/profile_picture.dart';

class DashboardUserDisplay extends StatelessWidget {
  // for now
  final String name;
  final double dimension;
  final String url;
  final String id;
  const DashboardUserDisplay({
    super.key,
    required this.dimension,
    required this.name,
    required this.url,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Column(children: [
      ProfilePicture(
        Colors.blueAccent,
        dimension,
        // '',
        url,
        id,
        borderRadius: 7,
      ),
      Container(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            name,
            style: const TextStyle(
                fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: -1),
          ))
    ]));
  }
}
