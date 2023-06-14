import 'dart:html';

import 'extern/plotly/dart_theme.dart';
import 'extern/plotly/plotly.dart';
import 'src/components/hero.dart';
import 'src/components/navbar.dart';
import 'src/data/global_food_prices.dart';

Navbar createNavbar() {
  return Navbar(
    AnchorElement()
      ..className = 'text-2xl'
      ..text = 'Dashboard',
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

Hero createHero() {
  return Hero(
    "Hello there",
    DivElement(),
    backgroundImage:
        "https://free4kwallpapers.com/uploads/originals/2020/06/28/old-stories-wallpaper.jpg",
  );
}

Future<void> buildComponents() async {
  // render elements
  List<Element> responses =
      await Future.wait([createNavbar().render(), createHero().render()]);

  DivElement navbarContainer = querySelector('#navbar') as DivElement;
  navbarContainer.children.add(responses[0]);

  DivElement heroContainer = querySelector('#hero') as DivElement;
  heroContainer.children.add(responses[1]);
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
