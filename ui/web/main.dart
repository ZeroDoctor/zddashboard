import 'dart:html';

import 'lib/dart_theme.dart';
import 'lib/plotly.dart';
import 'src/util/html.dart';

Future<void> main() async {
  Element child = htmlStringToElement("""
    <div id="container" class="container mx-auto flex flex-col justify-center items-center h-1/2 prose prose-lg">
      <a href="/pages">Pages</a>
    </div>
""");

  BodyElement body = querySelector('#output') as BodyElement;
  body.className = "h-screen";
  body.children.addAll([
    child,
    htmlStringToElement("""
      <div class="lg:grid"> 
        <div id="graph" class="place-self-center lg:mx-4 max-w-screen-lg"></div>
      </div>
"""),
  ]);

  Data trace = Data(
    x: [1, 2, 3, 4],
    y: [10, 15, 13, 7],
    type: 'scatter',
  );

  List<Data> data = [trace];

  Layout layout = Layout(
    title: 'Line Plot',
    template: darkTheme,
    autosize: true,
  );

  Config config = Config(
    displayModeBar: false,
    responsive: true,
  );

  newPlot('graph', data, layout, config);
}
