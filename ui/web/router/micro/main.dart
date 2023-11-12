import 'dart:html';

import '../../extern/litegraph/litegraph.dart';
import '../main.dart';

Future<void> buildComponents() async {
  // render elements
  List<Element> responses = await Future.wait([createNavbar().render()]);

  DivElement navbarContainer = querySelector('#navbar') as DivElement;
  navbarContainer.children.add(responses[0]);
}

Future<void> main() async {
  await buildComponents();

  liteGraph.debug = true;

  // liteGraph.registerNodeType("micro/sum", JsObject.jsify(micro.toMap()));

  LGraph graph = LGraph();
  log(graph);

  LGraphCanvas("#canvas", graph);

  var nodeConst = liteGraph.createNode("basic/const");
  nodeConst.pos = [200, 200];
  log(nodeConst);

  graph.add(nodeConst);
  nodeConst.setValue(4.5);

  var nodeWatch = liteGraph.createNode("basic/watch");
  nodeWatch.pos = [700, 200];
  graph.add(nodeWatch);

  nodeConst.connect(0, nodeWatch, 0);

  graph.start();
}

void log(dynamic o) {
  window.console.log(o);
}
