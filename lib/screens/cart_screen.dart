import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/cart_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: BlocConsumer<CartBloc, CartState>(
        listener: (_, state) {
          if (state is OrderSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Order placed: ${state.orderId}')),
            );
            Navigator.pop(context); // back to menu
            context.read<CartBloc>().add(ClearCart());
          }
          if (state is OrderFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Order failed – try again')),
            );
          }
        },
        builder: (_, state) {
          if (state.cart.items.isEmpty) {
            return const Center(child: Text('No items'));
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: state.cart.items.length,
                  itemBuilder: (_, i) {
                    final ci = state.cart.items[i];
                    return ListTile(
                      leading: Image.network(ci.item.image,
                        width: 48, height: 48, fit: BoxFit.cover),
                      title: Text(ci.item.name),
                      subtitle: Text(
                          '${ci.quantity} × \$${ci.item.price.toStringAsFixed(2)}'),
                      trailing: Text('\$${ci.total.toStringAsFixed(2)}'),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total: \$${state.cart.grandTotal.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 18)),
                    ElevatedButton(
                      onPressed: () => context.read<CartBloc>().add(PlaceOrder()),
                      child: const Text('Place Order'),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}