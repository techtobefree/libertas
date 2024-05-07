import 'package:flutter/material.dart';

class Information extends StatelessWidget {
  final String? title;
  final String? info;

  // Constructor
  const Information({super.key, required this.title, required this.info});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title ?? 'title'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            info ?? 'info',
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
