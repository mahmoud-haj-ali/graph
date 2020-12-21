import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graph/domain/models/models.dart';

class ShowVertices extends StatelessWidget {
  final String title;
  final List<Vertex> vertices;
  final bool isColored;
  ShowVertices({this.vertices,this.title, this.isColored});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title,style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold)),
        SizedBox(height: 10,),
        Wrap(
          direction: Axis.horizontal,
          alignment: WrapAlignment.center,
          runSpacing: 5,
          spacing: 10,
          children: [
            for(int i =0 ; i<vertices.length;i++)
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                    border: Border.all(width: 2,color:!isColored?Colors.white:vertices[i].isRed?Colors.deepOrangeAccent:Colors.tealAccent)
                ),
                child: Text(
                  "${vertices[i].name}:${vertices[i].degree}",
                  textDirection: TextDirection.ltr,
                  style: TextStyle(color:!isColored? Colors.orangeAccent:Colors.white, fontSize: 13),
                  maxLines: 1,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
