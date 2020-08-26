import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app_demo/screens/index.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new RootApp());
  });
}

class RootApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/category',
      routes: <String, WidgetBuilder>{
        '/category': (_) => CategoriesScreens(),
      },
      title: 'App Root',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
