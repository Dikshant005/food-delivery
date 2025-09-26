import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:food_delivery/models/resturant.dart';

class RestaurantRepo {
  Future<List<Restaurant>> fetchAll() async {
  try {
    final str = await rootBundle.loadString('assets/restaurants.json');
    print('[RestaurantRepo] loaded JSON length: ${str.length}');
    final list = (jsonDecode(str) as List).cast<Map<String, dynamic>>();
    return list.map((e) => Restaurant.fromJson(e)).toList();
  } catch (e) {
    print('[RestaurantRepo] asset exception: $e');  // <-- this line
    rethrow;
  }
}
}