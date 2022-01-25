import 'package:flutter/material.dart';
import 'package:notes/routes.dart';
import 'package:notes/utils/shared_prefs.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await sharedPrefs.init();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.indigo,
    ),
    onGenerateRoute: RouteGenerator.generateRoute,
  ));
}
