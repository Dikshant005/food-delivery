import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_delivery/repo/menu_repo.dart';
import '../models/menu_item.dart';

/* ---------- EVENTS ---------- */
abstract class MenuEvent extends Equatable {
  const MenuEvent();
  @override
  List<Object> get props => [];
}

class LoadMenu extends MenuEvent {
  final String restaurantId;
  const LoadMenu(this.restaurantId);
}

/* ---------- STATES ---------- */
abstract class MenuState extends Equatable {
  const MenuState();
  @override
  List<Object> get props => [];
}

class MenuInitial extends MenuState {}

class MenuLoading extends MenuState {}

class MenuLoaded extends MenuState {
  final List<MenuItem> items;
  const MenuLoaded(this.items);
  @override
  List<Object> get props => [items];
}

class MenuError extends MenuState {
  final String message;
  const MenuError(this.message);
  @override
  List<Object> get props => [message];
}

/* ---------- BLOC ---------- */
class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final MenuRepo repo;
  MenuBloc(this.repo) : super(MenuInitial()) {
    on<LoadMenu>(_onLoad);
  }

  Future<void> _onLoad(LoadMenu event, Emitter<MenuState> emit) async {
    emit(MenuLoading());
    try {
      final data = await repo.fetchMenu(event.restaurantId);
      emit(MenuLoaded(data));
    } catch (_) {
      emit(const MenuError('Failed to load menu'));
    }
  }
}