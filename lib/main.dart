import 'package:flutter/material.dart';
import 'pages/homepage.dart';

void main() {
  runApp(MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    ));
}
