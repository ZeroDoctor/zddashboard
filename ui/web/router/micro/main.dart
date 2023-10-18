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

  var graph = LGraph();
  LGraphCanvas(canvas: "#canvas", graph: graph);

  LGraphNode node = createNode("basic/const");
  node.pos = [200, 200];

  graph.add(node);
  node.setValue(4.5);

  LGraphNode nodeWatch = createNode("basic/watch");
  nodeWatch.pos = [700, 200];
  graph.add(nodeWatch);

  node.connect(0, nodeWatch, 0);

  graph.start();
}
