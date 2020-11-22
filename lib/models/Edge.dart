// To parse this JSON data, do
//
//     final edge = edgeFromJson(jsonString);

import 'dart:convert';

List<Edge> edgeFromJson(String str) => List<Edge>.from(json.decode(str).map((x) => Edge.fromJson(x)));

String edgeToJson(List<Edge> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Edge {
  Edge({
    this.name,
    this.start,
    this.end,
    this.weight,
  });

  String name;
  String start;
  String end;
  String weight;

  factory Edge.fromJson(Map<String, dynamic> json) => Edge(
    name: json["name"] == null ? null : json["name"],
    start: json["start"] == null ? null : json["start"],
    end: json["end"] == null ? null : json["end"],
    weight: json["weight"] == null ? null : json["weight"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "start": start == null ? null : start,
    "end": end == null ? null : end,
    "weight": weight == null ? null : weight,
  };
}
