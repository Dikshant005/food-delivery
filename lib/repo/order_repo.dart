import '../models/cart.dart';

class OrderRepo {
  Future<String> placeOrder(Cart cart) async {
    await Future.delayed(const Duration(seconds: 1));
    if (cart.items.any((e) => !e.item.available)) {
      throw Exception('Some items are no longer available');
    }
    return 'order_${DateTime.now().millisecondsSinceEpoch}';
  }
}