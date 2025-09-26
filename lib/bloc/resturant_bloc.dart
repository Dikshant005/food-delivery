import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_delivery/models/resturant.dart';
import 'package:food_delivery/repo/resturant_repo.dart';

/* ---------- EVENTS ---------- */
abstract class RestaurantEvent extends Equatable {
  const RestaurantEvent();
  @override
  List<Object> get props => [];
}

class LoadRestaurants extends RestaurantEvent {}

/* ---------- STATES ---------- */
abstract class RestaurantState extends Equatable {
  const RestaurantState();
  @override
  List<Object> get props => [];
}

class RestaurantInitial extends RestaurantState {}

class RestaurantLoading extends RestaurantState {}

class RestaurantLoaded extends RestaurantState {
  final List<Restaurant> restaurants;
  const RestaurantLoaded(this.restaurants);
  @override
  List<Object> get props => [restaurants];
}

class RestaurantError extends RestaurantState {
  final String message;
  const RestaurantError(this.message);
  @override
  List<Object> get props => [message];
}

/* ---------- BLOC ---------- */
class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final RestaurantRepo repo;
  RestaurantBloc(this.repo) : super(RestaurantInitial()) {
    on<LoadRestaurants>(_onLoad);
  }

  Future<void> _onLoad(LoadRestaurants event, Emitter<RestaurantState> emit) async {
    emit(RestaurantLoading());
    try {
      final data = await repo.fetchAll();
      emit(RestaurantLoaded(data));
    } catch (_) {
      emit(const RestaurantError('Failed to load restaurants'));
    }
  }
}