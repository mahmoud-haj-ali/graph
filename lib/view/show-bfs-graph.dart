import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graph/domain/graph-controller.dart';
import 'package:graph/domain/models/models.dart';

import 'custom-Widgets/show-edges.dart';
import 'custom-Widgets/show-vertices.dart';

class ShowBFS extends StatelessWidget {

  final GraphController graphController;
  final Graph graph;
  const ShowBFS({Key key, this.graphController, this.graph}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar:  AppBar(
        backgroundColor: Colors.orange.shade400,
        centerTitle: true,
        title: Text("BFS Algorithm"),
      ),
      body:Column(
        children: [
          ShowEdges(title:"BFS Path",edges: graphController.edgesPath),
          Divider(color: Colors.orange,height: 25,indent: 15,endIndent: 15,),
          StreamBuilder<List<Vertex>>(
              stream: graphController.bfsColoringController.stream,
              builder: (context, snapshot) {
                if(snapshot.hasData)
                  return ShowVertices(title: "BFS Coloring",vertices: snapshot.data,isColored: true,);
                else
                  return RaisedButton(
                      color: Colors.orange.shade400,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      onPressed: () {
                        graphController.applyColoring();
                      },
                      child: Center(child: Text("Apply Coloring"))
                  );
              }
          ),
          Divider(color: Colors.orange,height: 25,indent: 15,endIndent: 15,),
          StreamBuilder<List<Edge>>(
              stream: graphController.elseEdgesController.stream,
              builder: (context, snapshot) {
                if(snapshot.hasData)
                  return ShowEdges(title: "Deleted Edges",edges: snapshot.data,);
                else
                  return RaisedButton(
                      color: Colors.orange.shade400,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      onPressed: () {
                        graphController.getElseEdges(graph.edges);
                      },
                      child: Center(child: Text("Show Deleted Edges"))
                  );
              }
          ),
        ],
      ),
    );
  }
}
