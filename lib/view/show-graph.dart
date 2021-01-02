import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graph/domain/graph-controller.dart';
import 'package:graph/domain/models/models.dart';
import 'package:graph/services/dependency-injection.dart';
import 'package:graph/view/custom-Widgets/show-vertices.dart';

import 'custom-Widgets/show-edges.dart';
import 'show-bfs-graph.dart';

class ShowGraph extends StatelessWidget {
  final Graph graph;
  ShowGraph({this.graph});

  @override
  Widget build(BuildContext context) {
    GraphController graphController = locator<GraphController>();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.orange.shade400,
        centerTitle: true,
        title: Text("Graph"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10,),
            ShowVertices(title:"Vertices",vertices: graph.vertices,isColored: false,),
            Divider(color: Colors.orange,height: 25,indent: 15,endIndent: 15,),
            ShowEdges(title:"Edges",edges:graph.edges),
            SizedBox(height: 25,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: RaisedButton(
                color: Colors.orange.shade400,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                onPressed: () {
                  graphController.applyBfs(graph);
                  Navigator.push(context, CupertinoPageRoute(builder: (_)=> ShowBFS(graphController: graphController,graph: graph,)));
                },
                child: Center(child: Text("Apply BFS")),
              ),
            ),



          ],
        )
      ),
    );
  }
}
