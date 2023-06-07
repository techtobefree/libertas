import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_to_be_free/data/users/providers/user_provider.dart';
import 'package:serve_to_be_free/screens/login.dart';
import './config/routes/app_routes.dart';
import 'package:device_preview/device_preview.dart';
import 'package:provider/provider.dart';
//import 'package:serve_to_be_free/utilities/user_model.dart';

void main() {
  //GoRouter.setUrlPathStrategy(UrlPathStrategy.path);
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: const MyApp(),
    ),
  );
  // runApp(DevicePreview(
  //   enabled: !kReleaseMode,
  //   builder: (context) => MyApp(),
  // ));
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
