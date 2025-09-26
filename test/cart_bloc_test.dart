import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_delivery/bloc/cart_bloc.dart';
import 'package:food_delivery/models/cart.dart';
import 'package:food_delivery/models/cart_items.dart';
import 'package:food_delivery/models/menu_item.dart';

void main() {
  final testItem = MenuItem(
      id: 'm1', name: 'Burger', price: 5, available: true, image: 'url');

  group('CartBloc', () {
    blocTest<CartBloc, CartState>(
      'add item increases cart count',
      build: CartBloc.new,
      act: (bloc) => bloc.add(AddItem(testItem)),
      expect: () => [
        CartUpdated(Cart([CartItem(item: testItem, quantity: 1)]))
      ],
    );

    blocTest<CartBloc, CartState>(
      'ClearCart resets cart',
      build: CartBloc.new,
      seed: () => CartUpdated(Cart([CartItem(item: testItem)])),
      act: (bloc) => bloc.add(ClearCart()),
      expect: () => [CartUpdated(Cart())],
    );

    blocTest<CartBloc, CartState>(
      'PlaceOrder success',
      build: CartBloc.new,
      seed: () => CartUpdated(Cart([CartItem(item: testItem)])),
      act: (bloc) => bloc.add(PlaceOrder()),
      wait: const Duration(milliseconds: 1200),
      expect: () => [isA<OrderSuccess>()],
    );

    blocTest<CartBloc, CartState>(
      'PlaceOrder failure when item unavailable',
      build: CartBloc.new,
      seed: () => CartUpdated(Cart([
        CartItem(
            item: testItem.copyWith(available: false), quantity: 1)
      ])),
      act: (bloc) => bloc.add(PlaceOrder()),
      wait: const Duration(milliseconds: 1200),
      expect: () => [isA<OrderFailure>()],
    );
  });
}