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
  StreamController<bool> isBipartiteController = StreamController<bool>.broadcast();
  StreamController<List<Edge>> addableEdgesController = StreamController<List<Edge>>.broadcast();



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
      List<Vertex> children = getBFSChildren(graph,verticesTree.last);
      children.forEach((e) =>
          queue.add(e..isVisited = true)
      );
    }

    verticesTree.forEach((element) {
      print("${element.name} : ${element.isRed}");
    });

    bfsPathController.add(edgesPath);
  }

  List<Vertex> getBFSChildren(Graph graph,Vertex currentParent,){
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
  List<Vertex> getChildren(Graph graph,Vertex currentParent){
    List<Vertex> children=[];

    graph.edges.forEach((edge) {
      if(edge.start==currentParent.name) {
        if(graph.vertices.any((element) => element.name == edge.end)) {
          children.add(graph.vertices.singleWhere((element) => element.name == edge.end));
        }
      }
      else if(edge.end==currentParent.name){
        if(graph.vertices.any((element) => element.name == edge.start)) {
          children.add(graph.vertices.singleWhere((element) => element.name == edge.start));
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

  void isBipartite(Graph graph) async{
    bool isBipartite = true;
    verticesTree.forEach((v1) {
      verticesTree.forEach((v2) {
        if(v1.isRed == v2.isRed){
          if(getChildren(graph, v1).any((element) => element.name==v2.name))
          {
            isBipartite = false;
            isBipartiteController.add(isBipartite);
            return;
          }
        }
      });
    });
    isBipartiteController.add(isBipartite);
    await Future.delayed(Duration(milliseconds: 100));
    getAddableEdges(graph);
  }

  List<Edge> getAddableEdges(Graph graph){
    List<Edge> addableEdges = [];
    for(int i=0;i<verticesTree.length;i++){
      for(int j=i+1;j<verticesTree.length;j++){
        if(!getChildren(graph, verticesTree[i]).any((element) => element.name==verticesTree[j].name))
        {
          if(verticesTree[i].isRed != verticesTree[j].isRed)
            if(!graph.edges.any((element) => (element.start==verticesTree[i].name && element.end==verticesTree[j].name)||(element.end==verticesTree[i].name && element.start==verticesTree[j].name)))
              addableEdges.add(Edge(
                  name: "e${graph.edges.length+1+addableEdges.length}",
                  start: verticesTree[i].name ,
                  end: verticesTree[j].name,
                  weight:"15" ));
        }
      }
    }
    addableEdgesController.add(addableEdges);
    print(addableEdges);
    return addableEdges;
  }

  dispose(){
    bfsPathController.close();
    bfsColoringController.close();
    elseEdgesController.close();
    readGraphController.close();
    isBipartiteController.close();
    addableEdgesController.close();
  }


}