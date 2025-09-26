import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/bloc/cart_bloc.dart';
import 'package:food_delivery/bloc/resturant_bloc.dart';
import 'package:food_delivery/repo/resturant_repo.dart';
import 'package:food_delivery/screens/resturant_list_screen.dart';

void main() {
  final repo = RestaurantRepo();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => RestaurantBloc(repo)..add(LoadRestaurants())),
        BlocProvider(create: (_) => CartBloc()),
      ],
      child: MaterialApp(
        home: const RestaurantListScreen(),
      ),
    ),
  );
}