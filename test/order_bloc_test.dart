import 'package:flutter_test/flutter_test.dart';
import 'package:food_delivery/models/cart.dart';
import 'package:food_delivery/models/cart_items.dart';
import 'package:food_delivery/models/menu_item.dart';
import 'package:food_delivery/repo/order_repo.dart';

void main() {
  final availableItem = MenuItem(
      id: '1', name: 'Burger', price: 5, available: true, image: 'url');
  final unavailableItem = MenuItem(
      id: '2', name: 'Fries', price: 2, available: false, image: 'url');

  final repo = OrderRepo();

  test('returns orderId when all items available', () async {
    final cart = Cart([CartItem(item: availableItem)]);
    final id = await repo.placeOrder(cart);
    expect(id.startsWith('order_'), true);
  });

  test('throws when any item unavailable', () async {
    final cart = Cart([CartItem(item: unavailableItem)]);
    expect(() => repo.placeOrder(cart), throwsException);
  });
}