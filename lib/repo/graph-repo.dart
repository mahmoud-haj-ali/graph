import 'package:flutter/services.dart';
import 'package:graph/domain/models/models.dart';

class GraphRepo{


  Future<Graph> getGraph() async {
    return graphFromJson(await rootBundle.loadString('assets/graph.json'));
  }

  Future<Graph> getBipartiteGraph() async {
    return graphFromJson(await rootBundle.loadString('assets/graph-bipartite.json'));
  }

}