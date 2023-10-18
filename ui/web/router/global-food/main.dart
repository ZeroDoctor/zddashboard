import 'dart:html';

import '../../extern/plotly/dart_theme.dart';
import '../../extern/plotly/plotly.dart';
import '../main.dart';
import '../../src/data/global_food_prices.dart';

Future<void> buildComponents() async {
  // render elements
  List<Element> responses = await Future.wait([createNavbar().render()]);

  DivElement navbarContainer = querySelector('#navbar') as DivElement;
  navbarContainer.children.add(responses[0]);
}

Future<void> buildFoodPricesChart() async {
  List<CountryFoodPrice> countries = await fetchGlobalFoodPrices();

  countries.first.name = 'Global';
  List<CountryFoodPrice> global = averageFoodPrices(countries);

  List<Data> data = formatPricesToData(global);

  Layout layout = Layout(
    title: 'Global Food Prices',
    template: darkTheme,
    autosize: true,
  );

  Config config = Config(
    displayModeBar: false,
    responsive: true,
  );

  DivElement globalPricesContainer =
      querySelector('#globalPrices') as DivElement;

  // remove loading place holder...
  while (globalPricesContainer.children.isNotEmpty) {
    globalPricesContainer.children.remove(globalPricesContainer.children.last);
  }

  newPlot('globalPrices', data, layout, config);
}

Future<void> main() async {
  await buildComponents();
  await buildFoodPricesChart();
}
