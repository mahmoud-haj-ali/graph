import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graph/models/graph.dart';
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

  Future<Graph> getGraph() async {
    return graphFromJson(await rootBundle.loadString('assets/graph.json'));
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
            Expanded(child: showGraph()),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: RaisedButton(
                    color: Colors.orange.shade400,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    onPressed: () {
                      getGraph();
                    },
                    child: Text("Read Graph"),
                  ),
                ),
                // SizedBox(
                //   width: 10,
                // ),
                // Expanded(
                //   flex: 1,
                //   child: RaisedButton(
                //     color: Colors.orange.shade400,
                //     textColor: Colors.white,
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(12.0),
                //     ),
                //     onPressed: () {},
                //     child: Text("Apply Algorithm"),
                //   ),
                // ),
              ],
            )
          ],
        ),
      ),
    );
  }


  Widget showGraph(){
    return FutureBuilder<Graph>(
        future: getGraph(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Graph graph = snapshot.data;
            return ListView.builder(
                controller: _edgesListController,
                physics: BouncingScrollPhysics(),
                itemCount: graph.edges.length,
                itemBuilder: (context, index) {
                  return  Row(
                    children: <Widget>[
                      Text(
                        "${graph.edges[index].name}  ",
                        textDirection: TextDirection.ltr,
                        style: TextStyle(color: Colors.white, fontSize: 13),
                        maxLines: 1,
                      ),
                      Text(
                        "start:${graph.edges[index].start}  ",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                      SizedBox(width: 5),
                      Text(
                        "end:${graph.edges[index].end}  ",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(color: Colors.white, fontSize: 13),
                        maxLines: 1,
                      )
                    ],
                  );
                });
          } else
            return Center(child: CircularProgressIndicator());
        });
  }
}
