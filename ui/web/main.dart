import 'dart:html';

import 'extern/plotly/dart_theme.dart';
import 'extern/plotly/plotly.dart';
import 'src/components/navbar.dart';
import 'src/form_data/global_food_prices.dart';

Navbar createNavbar() {
  return Navbar(
    AnchorElement()..text = 'Dashboard',
    [
      Menu(
        AnchorElement()
          ..href = '/pages'
          ..text = 'Pages',
        [],
      ),
    ],
    DivElement(),
  );
}

Future<List<Data>> fetchFoodPricesData() async {
  List<CountryFoodPrice> countries = await fetchGlobalFoodPrices();

  // Map<String, List<CountryFoodPrice>> byCountry =
  //     averageGlobalFoodPricesByCountry(countries);

  // List<CountryFoodPrice> chad = byCountry['Chad']!;

  countries.first.name = 'Global';
  List<CountryFoodPrice> global = averageFoodPrices(countries);

  return formatPricesToData(global);
}

Future<void> main() async {
  // render elements
  List<Element> responses = await Future.wait([createNavbar().render()]);

  DivElement navbarContainer = querySelector('#navbar') as DivElement;
  navbarContainer.children.add(responses[0]);

  List<Data> data = await fetchFoodPricesData();

  Layout layout = Layout(
    title: 'Chad',
    template: darkTheme,
    autosize: true,
  );

  Config config = Config(
    displayModeBar: false,
    responsive: true,
  );

  DivElement globalPricesContainer =
      querySelector('#globalPrices') as DivElement;
  while (globalPricesContainer.children.isNotEmpty) {
    globalPricesContainer.children.remove(globalPricesContainer.children.last);
  }

  newPlot('globalPrices', data, layout, config);
}
