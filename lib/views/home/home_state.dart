class HomeState {
  const HomeState({
    this.items = const [],
  });

  final List<String> items;

  HomeState copyWith({
    List<String>? items,
  }) {
    return HomeState(
      items: items ?? this.items,
    );
  }
}
