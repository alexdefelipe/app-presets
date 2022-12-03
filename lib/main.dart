import 'package:flutter/material.dart';

import 'settings_list/routes/settings_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final theme = ThemeData(
    textTheme: const TextTheme(
      headline4: TextStyle(fontSize: 24, color: Colors.black),
      headline5: TextStyle(fontSize: 20, color: Colors.white),
      headline6: TextStyle(fontSize: 18),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'a[M]pp',
      home: const SettingsList(),
      theme: theme,
      debugShowCheckedModeBanner: false,
    );
  }
}
