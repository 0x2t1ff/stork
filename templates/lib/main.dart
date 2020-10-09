import 'package:flutter/material.dart';

import 'app/router.dart';
import 'ui/views/startup/startup_view.dart';
import './app/locator.dart';
import 'services/navigation_service.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Project',
        navigatorKey: locator<NavigationService>().navigationKey,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        onGenerateRoute: generateRoute,
        home: StartupView());
  }
}
