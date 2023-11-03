import 'package:flutter/material.dart';

class ProjectAppbarDisplay extends StatelessWidget {
  final String value;
  final String subject;

  const ProjectAppbarDisplay({
    super.key,
    required this.value,
    required this.subject,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Transform(
            transform: Matrix4.identity()..scale(1.0, 1.1),
            child: Text(value,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ))),
        Container(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              subject,
              style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ))
      ],
    );
  }
}
