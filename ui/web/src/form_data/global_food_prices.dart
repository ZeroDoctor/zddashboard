import 'dart:html';
import 'dart:convert';

import '../../extern/plotly/plotly.dart';

class CountryFoodPrice {
  String name;
  final String food;
  final String date;
  final num price;

  CountryFoodPrice(this.name, this.food, this.date, this.price);
}

Future<List<CountryFoodPrice>> fetchGlobalFoodPrices() async {
  HttpRequest req = await HttpRequest.request(
    'http://localhost:3000/api/globalfoodprices?after_year=2012',
    method: 'GET',
  );

  if (req.status != 200) {
    window.console.log('failed to get ok [request=$req]');
    return [];
  }

  Map<String, dynamic> resp = json.decode(req.response);
  List<Map<String, dynamic>> model = [{}];

  List<dynamic> data = resp['data'] as List<dynamic>;
  return data.map((row) {
    String month = '${row["month"]}';
    if (row["month"] < 10) {
      month = '0$month';
    }
    String date = '${row["year"]}-$month-01 00:00:00';

    return CountryFoodPrice(
      row['country_name'],
      row['food_name'],
      date,
      row['price'] ?? 0,
    );
  }).toList();
}

List<CountryFoodPrice> averageFoodPrices(List<CountryFoodPrice> target) {
  if (target.isEmpty) return target;
  String countryName = target[0].name;

  Map<String, List<num>> sumMap = {};
  for (var country in target) {
    String key = '${country.food}|${country.date}';
    if (sumMap[key] == null) sumMap[key] = [];

    num sum = (sumMap[country]?[0] ?? 0) + country.price;
    sumMap[country.food]?[0] += sum;
    sumMap[country.food]?[1] += 1;
  }

  List<CountryFoodPrice> country = [];
  sumMap.forEach((key, tuple) {
    List<String> split = key.split('|');
    String food = split[0];
    String date = split[1];
    num average = tuple[0] / tuple[1];

    country.add(CountryFoodPrice(countryName, food, date, average));
  });

  return country;
}

Map<String, List<CountryFoodPrice>> averageFoodPricesByCountry(
    List<CountryFoodPrice> countries) {
  Map<String, List<CountryFoodPrice>> bycountry = {};
  for (var country in countries) {
    String name = country.name;
    if (bycountry[name] == null) bycountry[name] = [];

    bycountry[name]?.add(country);
  }

  Map<String, List<num>> sumMap = {};
  bycountry.forEach((countryName, prices) {
    for (var data in prices) {
      String key = '${data.food}|${data.date}|${data.name}';

      if (sumMap[key] == null) sumMap[key] = [0, 0];

      num sum = (sumMap[key]?[0] ?? 0) + data.price;
      sumMap[key]?[0] = sum;
      sumMap[key]?[1] += 1;
    }
  });

  bycountry = {};
  sumMap.forEach((key, value) {
    List<String> split = key.split('|');
    String food = split[0];
    String date = split[1];
    String name = split[2];
    num average = value[0] / value[1];

    if (bycountry[name] == null) bycountry[name] = [];
    bycountry[name]?.add(CountryFoodPrice(name, food, date, average));
  });

  return bycountry;
}

List<Data> formatPricesToData(List<CountryFoodPrice> prices) {
  Map<String, List<CountryFoodPrice>> byFood = {};
  for (var price in prices) {
    if (byFood[price.food] == null) byFood[price.food] = [];
    byFood[price.food]?.add(price);
  }

  List<Data> data = [];
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
