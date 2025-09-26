import 'package:equatable/equatable.dart';
import 'package:food_delivery/models/cart_items.dart';
import 'package:food_delivery/models/menu_item.dart';

class Cart extends Equatable {
  final List<CartItem> items;
  const Cart([this.items = const []]);

  Cart addItem(MenuItem newItem) {
    final index = items.indexWhere((e) => e.item.id == newItem.id);
    if (index == -1) {
      return Cart([...items, CartItem(item: newItem)]);
    }
    final updated = items[index].copyWith(quantity: items[index].quantity + 1);
    return Cart([...items]..[index] = updated);
  }

  double get grandTotal =>
      items.fold(0, (sum, e) => sum + (e.item.price * e.quantity));

  int get itemCount => items.fold(0, (c, e) => c + e.quantity);

  @override
  List<Object> get props => items;
}