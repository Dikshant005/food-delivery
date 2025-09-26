import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_delivery/bloc/resturant_bloc.dart';
import 'package:food_delivery/models/resturant.dart';
import 'package:food_delivery/repo/resturant_repo.dart';
import 'package:mocktail/mocktail.dart';

class MockRestaurantRepo extends Mock implements RestaurantRepo {}

void main() {
  late MockRestaurantRepo repo;

  setUp(() => repo = MockRestaurantRepo());

  blocTest<RestaurantBloc, RestaurantState>(
    'emits [Loading, Loaded] when fetch succeeds',
    build: () {
      when(() => repo.fetchAll())
          .thenAnswer((_) async => [const Restaurant(id: 'r1', name: 'Test', image: 'url')]);
      return RestaurantBloc(repo);
    },
    act: (bloc) => bloc.add(LoadRestaurants()),
    expect: () => [
      RestaurantLoading(),
      RestaurantLoaded(const [Restaurant(id: 'r1', name: 'Test', image: 'url')])
    ],
  );

  blocTest<RestaurantBloc, RestaurantState>(
    'emits [Loading, Error] when fetch fails',
    build: () {
      when(() => repo.fetchAll()).thenThrow(Exception());
      return RestaurantBloc(repo);
    },
    act: (bloc) => bloc.add(LoadRestaurants()),
    expect: () => [
      RestaurantLoading(),
      const RestaurantError('Failed to load restaurants')
    ],
  );
}