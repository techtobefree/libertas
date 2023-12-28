import 'package:flutter/material.dart';
import 'package:serve_to_be_free/services/dimensions.dart';

class ResizeResponsiveWidget extends StatefulWidget {
  final Widget child;
  const ResizeResponsiveWidget({super.key, required this.child});

  @override
  ResizeResponsiveWidgetState createState() => ResizeResponsiveWidgetState();
}

class ResizeResponsiveWidgetState extends State<ResizeResponsiveWidget>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      dimensions.resize(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        statusBarHeight: MediaQuery.of(context).padding.top,
      );
      setState(() {}); // This will trigger a rebuild with the new dimensions
    });
  }

  @override
  Widget build(BuildContext context) => SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: widget.child);
}
