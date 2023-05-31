import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ProjectAppbarDisplay extends StatelessWidget {
  final value;
  final subject;

  const ProjectAppbarDisplay({super.key, this.value, this.subject});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Transform(
              transform: Matrix4.identity()..scale(1.0, 1.1),
              child: Text(value,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ))),
          Container(
              padding: EdgeInsets.only(top: 5),
              child: Text(
                subject,
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ))
        ],
      ),
    );
  }
}
