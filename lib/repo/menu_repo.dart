import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/menu_item.dart';

class MenuRepo {
  Future<List<MenuItem>> fetchMenu(String restaurantId) async {
    final str =
        await rootBundle.loadString('assets/menu_$restaurantId.json');
    final list = (jsonDecode(str) as List).cast<Map<String, dynamic>>();
    return list.map((e) => MenuItem.fromJson(e)).toList();
  }
}