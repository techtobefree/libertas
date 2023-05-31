import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_to_be_free/config/routes/app_routes.dart';

class BottomNavigationWidget extends StatefulWidget {
  const BottomNavigationWidget({Key? key}) : super(key: key);
  @override
  _BottomNavigationWidgetState createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  static const tabs = [
    ScaffoldWithNavBarTabItem(
      initialLocation: '/dashboard',
      icon: Icon(Icons.home),
      label: 'DASHBOARD',
    ),
    ScaffoldWithNavBarTabItem(
      initialLocation: '/projects',
      icon: Icon(Icons.business),
      label: 'PROJECTS',
    ),
    // ScaffoldWithNavBarTabItem(
    //   initialLocation: '/groups',
    //   icon: Icon(Icons.groups_2_outlined),
    //   label: 'Groups',
    // ),
    // ScaffoldWithNavBarTabItem(
    //   initialLocation: '/mytasks',
    //   icon: Icon(Icons.task_outlined),
    //   label: 'MY TASKS',
    // ),
    // ScaffoldWithNavBarTabItem(
    //   initialLocation: '/mymessages',
    //   icon: Icon(Icons.email_outlined),
    //   label: 'Messages',
    // ),
    ScaffoldWithNavBarTabItem(
      initialLocation: '/menu',
      icon: Icon(Icons.menu),
      label: 'MENU',
    ),
  ];

  // getter that computes the current index from the current location,
  // using the helper method below
  int get _currentIndex => _locationToTabIndex(GoRouter.of(context).location);

  int _locationToTabIndex(String location) {
    final index =
        tabs.indexWhere((t) => location.startsWith(t.initialLocation));
    // if index not found (-1), return 0
    return index < 0 ? 0 : index;
  }

  // callback used to navigate to the desired tab
  void _onItemTapped(BuildContext context, int tabIndex) {
    //if (tabIndex != _currentIndex) {
    // go to the initial location of the selected tab (by index)
    context.go(tabs[tabIndex].initialLocation);
    //}
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        selectedFontSize: 10,
        unselectedFontSize: 10,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blue[900],
        onTap: (index) => _onItemTapped(context, index),
        items: tabs);
  }
}

class ScaffoldWithNavBarTabItem extends BottomNavigationBarItem {
  const ScaffoldWithNavBarTabItem(
      {required this.initialLocation, required Widget icon, String? label})
      : super(icon: icon, label: label);

  /// The initial location/path
  final String initialLocation;
}
