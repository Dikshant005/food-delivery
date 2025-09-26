import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/menu_bloc.dart';
import '../bloc/cart_bloc.dart';
import 'cart_screen.dart'; 

class MenuScreen extends StatelessWidget {
  final String restaurantId;
  const MenuScreen({super.key, required this.restaurantId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Menu')),
      body: BlocBuilder<MenuBloc, MenuState>(
        builder: (_, state) {
          if (state is MenuLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is MenuError) {
            return Center(child: Text(state.message));
          }
          if (state is MenuLoaded) {
            return ListView.builder(
              itemCount: state.items.length,
              itemBuilder: (_, i) {
                final item = state.items[i];
                return ListTile(
                  leading: Image.network(item.image,
                        width: 64, height: 64, fit: BoxFit.cover),
                  title: Text(item.name),
                  subtitle: Text('\$${item.price.toStringAsFixed(2)}'),
                  trailing: item.available
                      ? IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            context.read<CartBloc>().add(AddItem(item));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${item.name} added'),
                                duration: const Duration(milliseconds: 300),
                              ),
                            );
                          },
                        )
                      : const Text('Unavailable'),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.shopping_cart),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const CartScreen()),
        ),
      ),
    );
  }
}