import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_to_be_free/widgets/ui/bottom_navigation_widget.dart';

class MyScaffold extends StatefulWidget {
  const MyScaffold({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  State<MyScaffold> createState() => _MyScaffoldState();
}

class _MyScaffoldState extends State<MyScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: false,
        body: widget.child,
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: BottomNavigationWidget());
  }
}
