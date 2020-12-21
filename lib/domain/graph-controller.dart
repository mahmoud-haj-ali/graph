import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:graph/domain/models/models.dart';
import 'package:graph/services/dependency-injection.dart';

class GraphController{

  StreamController<List<Edge>> bfsPathController = StreamController<List<Edge>>.broadcast();
  StreamController<Graph> readGraphController = StreamController<Graph>.broadcast();
  StreamController<List<Edge>> elseEdgesController = StreamController<List<Edge>>.broadcast();
  StreamController<List<Vertex>> bfsColoringController = StreamController<List<Vertex>>.broadcast();


  List<Edge> edgesPath = [];
  List<Edge> elseEdges = [];
  List<Vertex> verticesTree = [];


  applyBfs(Graph graph){
    if(edgesPath.isNotEmpty)
      return;

    Queue queue = Queue<Vertex>();

    queue.addFirst(graph.vertices.first..isVisited = true..isRed=false);
    while(queue.isNotEmpty){
      verticesTree.add(queue.removeFirst());
      List<Vertex> children = getChildren(graph,verticesTree.last);
      children.forEach((e) =>
          queue.add(e..isVisited = true)
      );
    }

    verticesTree.forEach((element) {
      print("${element.name} : ${element.isRed}");
    });

    bfsPathController.add(edgesPath);
  }

  List<Vertex> getChildren(Graph graph,Vertex currentParent,){
    List<Vertex> children=[];
    List<Vertex> unVisitedVertices=graph.vertices.where((element) => !element.isVisited).toList();

    if(unVisitedVertices.isEmpty)
      return children;

    graph.edges.forEach((edge) {
      if(edge.start==currentParent.name) {
        if(unVisitedVertices.any((element) => element.name == edge.end)) {
          children.add(unVisitedVertices.singleWhere((element) => element.name == edge.end)..isRed = !currentParent.isRed);
          edgesPath.add(edge);
        }
      }
      else if(edge.end==currentParent.name){
        if(unVisitedVertices.any((element) => element.name == edge.start)) {
          children.add(unVisitedVertices.singleWhere((element) => element.name == edge.start)..isRed = !currentParent.isRed);
          edgesPath.add(edge);
        }
      }
    });


    return children;
  }

  applyColoring(){
    bfsColoringController.add(verticesTree);
  }

  getElseEdges(List<Edge> graphEdges){
    if(elseEdges.isEmpty)
    graphEdges.forEach((element) {
      if(!edgesPath.contains(element)){
        elseEdges.add(element);
      }
    });
    elseEdgesController.add(elseEdges);
  }


  dispose(){
    bfsPathController.close();
    bfsColoringController.close();
    elseEdgesController.close();
    readGraphController.close();
  }
}