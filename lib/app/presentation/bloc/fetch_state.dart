sealed class FetchState<T> {}

final class FetchInitialState extends FetchState {}

final class FetchLoadingState extends FetchState {}

final class FetchLoadedState<T> extends FetchState<T> {
  final T data;

  FetchLoadedState({required this.data});
}

final class FetchErrorState extends FetchState {
  final String message;

  FetchErrorState({required this.message});
}
