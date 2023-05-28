// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:serve_to_be_free/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:serve_to_be_free/data/users/providers/user_provider.dart';
import 'package:serve_to_be_free/screens/dashboard.dart';
import 'package:serve_to_be_free/screens/login.dart';
import 'package:serve_to_be_free/screens/menu.dart';
import 'package:serve_to_be_free/screens/sub_screens/projects_subpages/finish_projects.dart';
import 'package:serve_to_be_free/screens/sub_screens/projects_subpages/sponsor_a_project/sponsor_project_form.dart';
import 'package:serve_to_be_free/screens/tasks.dart';
import 'package:serve_to_be_free/widgets/dashboard_user_display.dart';
import 'package:serve_to_be_free/widgets/profile_picture.dart';
import 'package:serve_to_be_free/widgets/project_preview.dart';
import 'package:serve_to_be_free/widgets/sponsor_Card.dart';

void main() {
  testWidgets('Verify LoginScreen renders properly',
      (WidgetTester tester) async {
    // Create a mock UserProvider
    final userProvider = UserProvider();

    // Build the app and trigger a frame.
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: userProvider,
          ),
        ],
        child: MaterialApp(
          home: LoginScreen(),
        ),
      ),
    );

    // Verify that the email field is rendered
    final emailFieldFinder = find.byWidgetPredicate((widget) =>
        widget is TextField &&
        widget.decoration?.hintText == 'Enter your Email');
    expect(emailFieldFinder, findsOneWidget);

    // Verify that the password field is rendered
    final passwordFieldFinder = find.byWidgetPredicate((widget) =>
        widget is TextField &&
        widget.decoration?.hintText == 'Enter your Password');
    expect(passwordFieldFinder, findsOneWidget);

    // You can add more assertions to test other aspects of your app's UI and behavior
  });

  testWidgets('DashboardUserDisplay renders properly',
      (WidgetTester tester) async {
    const String name = 'John Doe';
    const double dimension = 80.0;
    const String url = 'https://example.com/profile_picture.jpg';

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DashboardUserDisplay(
            name: name,
            dimension: dimension,
            url: url,
          ),
        ),
      ),
    );

    // Verify that the profile picture is rendered
    expect(find.byType(ProfilePicture), findsOneWidget);

    // Verify that the name is rendered
    expect(find.text(name), findsOneWidget);
  });

  testWidgets('TasksPage renders properly', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: TasksPage()));

    // Verify that the app bar is rendered
    expect(find.byType(AppBar), findsOneWidget);

    // Verify that the app bar title is correct
    expect(find.text('Tasks Demo'), findsOneWidget);

    // Verify that the body text is rendered
    expect(find.text('I am Tasks'), findsOneWidget);
  });

  testWidgets('SponsorCard renders properly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SponsorCard(),
        ),
      ),
    );

    // Verify that the SponsorCard is rendered
    expect(find.byType(SponsorCard), findsOneWidget);
  });

  testWidgets('FinishProject renders properly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FinishProject(),
        ),
      ),
    );

    // Verify that the FinishProject widget is rendered
    expect(find.byType(FinishProject), findsOneWidget);
  });

  testWidgets('MenuPage renders properly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MenuPage(),
        ),
      ),
    );

    // Verify that the MenuPage widget is rendered
    expect(find.byType(MenuPage), findsOneWidget);
  });
}
