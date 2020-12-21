import 'package:flutter/material.dart';

class Vertex {
  Vertex({
    this.name,
    this.degree,
    this.isVisited=false,
    this.isRed
  });

  String name;
  String degree;
  bool isVisited;
  bool isRed;

  factory Vertex.fromJson(Map<String, dynamic> json) => Vertex(
    name: json["name"],
    degree: json["degree"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "degree": degree,
  };
}