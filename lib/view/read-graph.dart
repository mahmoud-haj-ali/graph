
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graph/domain/graph-controller.dart';
import 'package:graph/domain/models/models.dart';
import 'package:graph/repo/graph-repo.dart';
import 'package:graph/services/dependency-injection.dart';
import 'package:graph/view/show-bfs-graph.dart';
import 'package:graph/view/show-graph.dart';

import 'custom-Widgets/show-edges.dart';
import 'custom-Widgets/show-vertices.dart';

class ReadGraph extends StatefulWidget {


  @override
  _ReadGraphState createState() => _ReadGraphState();
}

class _ReadGraphState extends State<ReadGraph> {


  GraphRepo repo;
  GraphController graphController;

  @override
  void initState() {
    super.initState();
    repo = locator<GraphRepo>();
    graphController = locator<GraphController>();
  }

  @override
  void dispose() {
    graphController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 200,
              child: RaisedButton(
                color: Colors.orange.shade400,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                onPressed: () async {
                  Graph graph= await repo.getGraph();
                  Navigator.push(context, CupertinoPageRoute(builder: (_)=>ShowGraph(graph: graph,)));
                },
                child: Text("Read Graph"),
              ),
            ),
            SizedBox(height: 15,),
            Container(
              width: 200,
              child: RaisedButton(
                color: Colors.orange.shade400,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                onPressed: () async {
                  Graph graph= await repo.getBipartiteGraph();
                  Navigator.push(context, CupertinoPageRoute(builder: (_)=>ShowGraph(graph: graph,)));
                },
                child: Text("Read Bipartite Graph"),
              ),
            ),
          ],
        ),
      ),
    );
  }


  // Widget showGraph(Graph graph){
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     children: [
  //       SizedBox(height: 10,),
  //       ShowVertices(title:"Vertices",vertices: graph.vertices,isColored: false,),
  //       Divider(color: Colors.orange,height: 25,indent: 25,endIndent: 25,),
  //       ShowEdges(title:"Edges",edges:graph.edges),
  //       SizedBox(height: 25,),
  //       RaisedButton(
  //         color: Colors.orange.shade400,
  //         textColor: Colors.white,
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(12.0),
  //         ),
  //         onPressed: () {
  //           graphController.applyBfs(graph);
  //           Navigator.push(context, CupertinoPageRoute(builder: (_)=> ShowBFS(graphController: graphController,graph: graph,)));
  //         },
  //         child: Center(child: Text("Apply BFS")),
  //       ),
  //
  //
  //
  //     ],
  //   );
  // }



}
