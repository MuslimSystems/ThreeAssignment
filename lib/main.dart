import 'package:assignmentthree/screen/home.dart';
import 'package:assignmentthree/screen/todolistprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(
    ChangeNotifierProvider(
    create: (_) =>  TodolistProvider(),
    child: const MainApp()
    )
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return const MaterialApp(
      home:MyHomePage(),
    );
  }
}
