import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graph/domain/models/models.dart';

class ShowEdges extends StatelessWidget {
  final String title;
  final List<Edge> edges;
  ShowEdges({this.edges,this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 10,),
        Text(title,style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold)),
        SizedBox(height: 10,),
        Wrap(
          direction: Axis.horizontal,
          alignment: WrapAlignment.center,
          runSpacing: 10,
          children: [
            for(int index =0 ; index<edges.length;index++)
              Container(
                width: 120,
                margin: EdgeInsets.symmetric(horizontal: 5),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(width: 2,color: Colors.white)
                ),
                child: Center(
                  child: RichText(
                    strutStyle: StrutStyle(fontSize:13,),
                    text: TextSpan(
                        text: "${edges[index].start}",
                        style: TextStyle(color: Colors.white),
                        children: [
                          TextSpan(text: " -- ", style: TextStyle(color: Colors.orangeAccent,fontWeight: FontWeight.bold),),
                          TextSpan(text: "${edges[index].name}", style: TextStyle(color: Colors.white),),
                          TextSpan(text: " -- ", style: TextStyle(color: Colors.orangeAccent,fontWeight: FontWeight.bold),),
                          TextSpan(text: "${edges[index].end}", style: TextStyle(color: Colors.white),),
                        ]
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
