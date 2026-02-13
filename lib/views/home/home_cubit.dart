import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  void addItem() {
    final newItems = List<String>.from(state.items)
      ..add('Item ${state.items.length}');
    emit(state.copyWith(items: newItems));
  }

  void removeItem() {
    if (state.items.isEmpty) return;
    final newItems = List<String>.from(state.items)..removeLast();
    emit(state.copyWith(items: newItems));
  }
}
