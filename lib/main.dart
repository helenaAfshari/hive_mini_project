import 'package:flutter/material.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:mini_project_hive/home.dart';
import 'package:mini_project_hive/user_info_model.dart';
void main()async {
 await Hive.initFlutter();
 Hive.registerAdapter(UserInfoAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeView());
  }
}