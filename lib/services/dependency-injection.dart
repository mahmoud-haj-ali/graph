import 'package:get_it/get_it.dart';
import 'package:graph/domain/graph-controller.dart';
import 'package:graph/domain/models/models.dart';
import 'package:graph/repo/graph-repo.dart';

final locator = GetIt.instance;

void setup() {
  locator.registerFactory<Graph>(() => Graph());
  locator.registerFactory<GraphController>(() => GraphController());
  locator.registerFactory<GraphRepo>(()=>GraphRepo());

}