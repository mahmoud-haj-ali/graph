import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graph/services/dependency-injection.dart';
import 'package:graph/view/show-graph.dart';

void main() {

  setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Graph',
      home: ShowGraph(),
    );
  }
}
