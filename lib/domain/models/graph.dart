// To parse this JSON data, do
//
//     final graph = graphFromJson(jsonString);

import 'dart:convert';

import 'package:graph/domain/models/vertex.dart';

import 'Edge.dart';

Graph graphFromJson(String str) => Graph.fromJson(json.decode(str));

String graphToJson(Graph data) => json.encode(data.toJson());

class Graph {
  Graph({
    this.graphName,
    this.vertices,
    this.edges,
  });

  String graphName;
  List<Vertex> vertices;
  List<Edge> edges;

  factory Graph.fromJson(Map<String, dynamic> json) => Graph(
    graphName: json["graph_name"],
    vertices: List<Vertex>.from(json["vertices"].map((x) => Vertex.fromJson(x))),
    edges: List<Edge>.from(json["edges"].map((x) => Edge.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "graph_name": graphName,
    "vertices": List<dynamic>.from(vertices.map((x) => x.toJson())),
    "edges": List<dynamic>.from(edges.map((x) => x.toJson())),
  };
}



