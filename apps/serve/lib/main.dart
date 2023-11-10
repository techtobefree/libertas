import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:go_router/go_router.dart';
//import 'package:device_preview/device_preview.dart';
import 'package:provider/provider.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
//import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:serve_to_be_free/config/routes/app_routes.dart';
import 'package:serve_to_be_free/cubits/cubits.dart';
import 'package:serve_to_be_free/data/users/providers/user_provider.dart';
//import 'package:serve_to_be_free/screens/login.dart';
import 'package:serve_to_be_free/amplifyconfiguration.dart';
import 'package:serve_to_be_free/models/ModelProvider.dart';
//import 'package:serve_to_be_free/utilities/user_model.dart';

void main() async {
  //GoRouter.setUrlPathStrategy(UrlPathStrategy.path);

  WidgetsFlutterBinding.ensureInitialized();

  await _configureAmplify();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<UserCubit>(create: (context) => UserCubit()),
        BlocProvider<PostsCubit>(create: (context) => PostsCubit()),
      ],
      child: ChangeNotifierProvider(
        create: (context) => UserProvider(),
        child: const MyApp(),
      ),
    ),
  );
  // runApp(DevicePreview(
  //   enabled: !kReleaseMode,
  //   builder: (context) => MyApp(),
  // ));
}

Future<void> fillUserData() async {
  try {
    final result = await Amplify.Auth.fetchUserAttributes();
    for (final element in result) {
      final key = element.userAttributeKey.toString();
      final value = element.value;

      if (key == "CognitoUserAttributeKey \"email\"") {
        print(value);
      }

      safePrint('key: ${element.userAttributeKey}; value: ${element.value}');
    }
    return;
  } on AuthException catch (e) {
    safePrint('Error retrieving auth session: ${e.message}');
    return;
  }
}

Future<void> _configureAmplify() async {
  // To be filled in
  try {
    // Create the API plugin.
    //
    // If `ModelProvider.instance` is not available, try running
    // `amplify codegen models` from the root of your project.
    final api = AmplifyAPI(modelProvider: ModelProvider.instance);

    // Create the Auth plugin.
    final auth = AmplifyAuthCognito();
//
    // Add the plugins and configure Amplify for your app.
    await Amplify.addPlugins([api, auth]);
    await Amplify.configure(amplifyconfig);

    // _signUp(
    //     username: "bob",
    //     password: "bob",
    //     email: "bob@gmail.com",
    //     customValue: "bob");

    Amplify.Hub.listen(HubChannel.Auth, (AuthHubEvent event) async {
      switch (event.type) {
        case AuthHubEventType.signedIn:
          safePrint('User is signed in.');
          await fillUserData();
          break;
        case AuthHubEventType.signedOut:
          safePrint('User is signed out.');
          break;
        case AuthHubEventType.sessionExpired:
          safePrint('The session has expired.');
          break;
        case AuthHubEventType.userDeleted:
          safePrint('The user has been deleted.');
          break;
      }
    });

    safePrint('Successfully configured');
  } on Exception catch (e) {
    safePrint('Error configuring Amplify: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      //////////////////////////
      // useInheritedMediaQuery: true,
      // locale: DevicePreview.locale(context),
      // builder: DevicePreview.appBuilder,
      //////////////////////////
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: goRouter,
    );
  }
}
