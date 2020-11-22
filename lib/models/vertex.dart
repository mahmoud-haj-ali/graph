// To parse this JSON data, do
//
//     final vertex = vertexFromJson(jsonString);

import 'dart:convert';

List<Vertex> vertexFromJson(String str) => List<Vertex>.from(json.decode(str).map((x) => Vertex.fromJson(x)));

String vertexToJson(List<Vertex> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Vertex {
  Vertex({
    this.name,
    this.degree,
  });

  String name;
  String degree;

  factory Vertex.fromJson(Map<String, dynamic> json) => Vertex(
    name: json["name"] == null ? null : json["name"],
    degree: json["degree"] == null ? null : json["degree"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "degree": degree == null ? null : degree,
  };
}
