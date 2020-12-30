import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graph/services/dependency-injection.dart';
import 'package:graph/view/read-graph.dart';

void main() {

  setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Graph',
      home: ReadGraph(),
    );
  }
}
