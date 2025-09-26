import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_delivery/repo/order_repo.dart';
import '../models/menu_item.dart';
import '../models/cart.dart';

/* ---------- EVENTS ---------- */
abstract class CartEvent extends Equatable {
  const CartEvent();
  @override
  List<Object> get props => [];
}

class AddItem extends CartEvent {
  final MenuItem item;
  const AddItem(this.item);
}

class ClearCart extends CartEvent {}

class PlaceOrder extends CartEvent {}

/* ---------- STATES ---------- */
abstract class CartState extends Equatable {
  final Cart cart;
  const CartState(this.cart);
  @override
  List<Object> get props => [cart];
}

class CartUpdated extends CartState {
  const CartUpdated(super.cart);
}

class OrderSuccess extends CartState {
  final String orderId;
  const OrderSuccess(super.cart, this.orderId);
  @override
  List<Object> get props => [cart, orderId];
}

class OrderFailure extends CartState {
  const OrderFailure(super.cart);
}

/* ---------- BLOC ---------- */
class CartBloc extends Bloc<CartEvent, CartState> {
  final OrderRepo _orderRepo = OrderRepo();

  CartBloc() : super(CartUpdated(Cart())) {
    on<AddItem>(_onAdd);
    on<ClearCart>((_, emit) => emit(CartUpdated(Cart())));
    on<PlaceOrder>(_onPlace);
  }

  void _onAdd(AddItem event, Emitter<CartState> emit) {
    emit(CartUpdated(state.cart.addItem(event.item)));
  }

  Future<void> _onPlace(PlaceOrder event, Emitter<CartState> emit) async {
    try {
      final id = await _orderRepo.placeOrder(state.cart);
      emit(OrderSuccess(state.cart, id));
    } catch (_) {
      emit(OrderFailure(state.cart));
    }
  }
}