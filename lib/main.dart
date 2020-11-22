import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graph/models/vertex.dart';

import 'models/Edge.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Graph',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Graph'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ScrollController _edgesListController = ScrollController();
  ScrollController _verticesListController = ScrollController();

  Future<List<Vertex>> getVertices() async {
    return vertexFromJson(await rootBundle.loadString('assets/vertices.json'));
  }

  Future<List<Edge>> getEdges() async {
    return edgeFromJson(await rootBundle.loadString('assets/edges.json'));
  }
  @override
  void initState() {
    getEdges();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.orange.shade400,
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            edgesList(),
            SizedBox(
              height: 10,
            ),
            verticesList(),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: RaisedButton(
                    color: Colors.orange.shade400,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    onPressed: () {},
                    child: Text("Read Graph"),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 1,
                  child: RaisedButton(
                    color: Colors.orange.shade400,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    onPressed: () {},
                    child: Text("Apply Algorithm"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }


  Widget edgesList(){
    return FutureBuilder(
        future: getEdges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Edge> edges = snapshot.data;
            return Container(
              height: 200,
              child: ListView.builder(
                  controller: _edgesListController,
                  itemExtent: 60.0,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return  Column(
                      children: <Widget>[
                        ListTile(
                          onTap: () {},
                          contentPadding: EdgeInsets.only(left: 20, right: 16),
                          title: Text(
                            "${edges[index].name}",
                            textDirection: TextDirection.ltr,
                            style: TextStyle(color: Colors.black, fontSize: 10),
                            maxLines: 1,
                          ),
                          trailing: Row(
                            children: [
                              Text(
                                "start:${edges[index].start}",
                                textDirection: TextDirection.rtl,
                                style: TextStyle(color: Colors.black, fontSize: 10),
                              ),
                              SizedBox(width: 5),
                              Text(
                                "end:${edges[index].end}",
                                textDirection: TextDirection.rtl,
                                style: TextStyle(color: Colors.black, fontSize: 10),
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.black.withOpacity(0.1),
                          thickness: 4.0,
                          height: 0,
                          indent: 70,
                        )
                      ],
                    );
                  }),
            );
          } else
            return Container(child: Center(child: CircularProgressIndicator()));
        });
  }
  Widget verticesList(){
    return FutureBuilder(
        future: getVertices(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Vertex> vertices = snapshot.data;
            return Container(
              height: 200,
              child: ListView.builder(
                  controller: _edgesListController,
                  itemExtent: 60.0,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return Column(
                      children: <Widget>[
                        ListTile(
                          onTap: () {},
                          contentPadding: EdgeInsets.only(left: 20, right: 16),
                          title: Text(
                            "${vertices[index].name}",
                            textDirection: TextDirection.ltr,
                            style: TextStyle(color: Colors.black, fontSize: 10),
                            maxLines: 1,
                          ),
                          trailing: Text(
                            "start:${vertices[index].degree}",
                            textDirection: TextDirection.rtl,
                            style: TextStyle(color: Colors.black, fontSize: 10),
                          ),
                        ),
                        Divider(
                          color: Colors.black.withOpacity(0.1),
                          thickness: 4.0,
                          height: 0,
                          indent: 70,
                        )
                      ],
                    );
                  }),
            );
          } else
            return Container(child: Center(child: CircularProgressIndicator()));
        });
  }
}
