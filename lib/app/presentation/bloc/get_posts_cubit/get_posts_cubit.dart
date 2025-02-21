import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinapp_test/app/core/either_handler.dart';
import 'package:pinapp_test/app/domain/entities/post_entity.dart';
import 'package:pinapp_test/app/domain/repositories/post_repository.dart';
import 'package:pinapp_test/app/presentation/bloc/fetch_state.dart';

class GetPostsCubit extends Cubit<FetchState> {
  final PostRepository repository;

  GetPostsCubit(this.repository) : super(FetchInitialState());

  void getAllPosts() async {
    emit(FetchLoadingState());

    final result = await repository.getAllPosts();

    switch (result) {
      case Right():
        emit(FetchLoadedState<List<PostEntity>>(data: result.right));
      case Left():
        emit(FetchErrorState(message: result.left.message));
    }
  }
}
