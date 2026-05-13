import 'package:flutter/material.dart';
import 'package:flutter_application_2/home_page.dart';

class TaskApp extends StatelessWidget {
  const TaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),

      home: const HomePage(),
    );
  }
}