import 'package:ui/api/model/city.dart';
import 'package:ui/api/model/food.dart';

class CityFoodPrice {
  final City city;
  final Food food;
  final String currencyName;
  final double price;

  const CityFoodPrice(
    this.city,
    this.food,
    this.currencyName,
    this.price,
  );
}
