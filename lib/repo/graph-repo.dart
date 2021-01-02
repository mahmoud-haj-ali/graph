import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graph/domain/models/models.dart';

class GraphRepo{


  Future<Graph> getGraph() async {
    return graphFromJson(await rootBundle.loadString('assets/graph.json'));
  }

  Future<Graph> getBipartiteGraph() async {
    return graphFromJson(await rootBundle.loadString('assets/graph-bipartite.json'));
  }

  Future<Graph> getGraphFromMemory(String path) async {
    Graph graph;
    try {
      String jsonFile = await File(path).readAsString();
      graph = graphFromJson(jsonFile);
    } catch (e) {
      Fluttertoast.showToast(
          msg: "unSupported format",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey.shade600,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
    return graph;
  }

}