import 'dart:html';
import 'dart:convert';

import 'lib/plotly/dart_theme.dart';
import 'lib/plotly/plotly.dart';
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

Future<List<Data>> fetchGlobalFoodPricesData() async {
  List<CountryFoodPrice> countries = await fetchGlobalFoodPrices();
  Map<String, List<CountryFoodPrice>> byCountry =
      averageGlobalFoodPricesByCountry(countries);

  List<Data> data = [];
  List<CountryFoodPrice> senegal = byCountry['Chad']!;

  Map<String, List<CountryFoodPrice>> byFood = {};
  for (var d in senegal) {
    if (byFood[d.food] == null) byFood[d.food] = [];
    byFood[d.food]?.add(d);
  }
  window.console.log(byFood);

  byFood.forEach((name, value) {
    value.sort((a, b) {
      var aDate = DateTime.parse(a.date);
      var bDate = DateTime.parse(b.date);
      return aDate.compareTo(bDate);
    });

    data.add(Data(
      x: value.map((element) => element.date).toList(),
      y: value.map((element) => element.price).toList(),
      name: name,
    ));
  });

  return data;
}

Future<void> main() async {
  // render elements
  List<Element> responses = await Future.wait([createNavbar().render()]);

  DivElement navbarContainer = querySelector('#navbar') as DivElement;
  navbarContainer.children.add(responses[0]);

  List<Data> data = await fetchGlobalFoodPricesData();

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
    globalPricesContainer.children
        .removeAt(globalPricesContainer.children.length - 1);
  }

  newPlot('globalPrices', data, layout, config);
}
