import 'package:flutter/material.dart';
import 'package:moviedirectory/MovieDirectory.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xff121212),
        accentColor: Color(0xff3f3f3f),
        primarySwatch: Colors.blue,
      ),
      home: MovieDirectory(),
    );
  }
}
