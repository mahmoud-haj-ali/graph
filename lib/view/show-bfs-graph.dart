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
          showColoredVertices(),
          Divider(color: Colors.orange,height: 25,indent: 15,endIndent: 15,),
          showDeletedEdges(),
          Divider(color: Colors.orange,height: 25,indent: 15,endIndent: 15,),
          showBipartite()
        ],
      ),
    );
  }

  Widget showColoredVertices(){
    return StreamBuilder<List<Vertex>>(
        stream: graphController.bfsColoringController.stream,
        builder: (context, snapshot) {
          if(snapshot.hasData)
            return ShowVertices(title: "BFS Coloring",vertices: snapshot.data,isColored: true,);
          else
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: RaisedButton(
                  color: Colors.orange.shade400,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  onPressed: () {
                    graphController.applyColoring();
                  },
                  child: Center(child: Text("Apply Coloring"))
              ),
            );
        }
    );
  }


  Widget showDeletedEdges(){
    return StreamBuilder<List<Edge>>(
        stream: graphController.elseEdgesController.stream,
        builder: (context, snapshot) {
          if(snapshot.hasData)
            return ShowEdges(title: "Deleted Edges",edges: snapshot.data,);
          else
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: RaisedButton(
                  color: Colors.orange.shade400,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  onPressed: () {
                    graphController.getElseEdges(graph.edges);
                  },
                  child: Center(child: Text("Show Deleted Edges"))
              ),
            );
        }
    );
  }

  Widget showBipartite(){
    return StreamBuilder<bool>(
        stream: graphController.isBipartiteController.stream,
        builder: (context, snap) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: RaisedButton(
                    color: Colors.orange.shade400,
                    disabledColor: (snap.data??false)?Colors.tealAccent:Colors.red,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    onPressed: snap.data!=null?null:() {
                      graphController.isBipartite(graph);
                    },
                    child: Center(child: Text(snap.data==null?"Is Bipartite?":snap.data?"The graph is bipartite":"The graph isn't bipartite"))
                ),
              ),
              SizedBox(height: 15,),
              if(snap.data??false)
                StreamBuilder<List<Edge>>(
                    stream: graphController.addableEdgesController.stream,
                    builder: (context, addableEdges) {
                      if(!addableEdges.hasData)
                        return SizedBox();
                      else if(addableEdges.data.isEmpty)
                        return Center(child: Text("Can't add anymore edges"));
                      return ShowEdges(title: "Addable Edges",edges: addableEdges.data,);
                    }
                )
            ],
          );
        }
    );
  }
}
