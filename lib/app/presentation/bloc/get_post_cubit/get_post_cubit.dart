import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinapp_test/app/core/either_handler.dart';
import 'package:pinapp_test/app/domain/entities/comment_entity.dart';
import 'package:pinapp_test/app/domain/repositories/post_repository.dart';
import 'package:pinapp_test/app/presentation/bloc/fetch_state.dart';

class GetPostCubit extends Cubit<FetchState> {
  final PostRepository repository;
  GetPostCubit(this.repository) : super(FetchInitialState());

  void getPost(int id) async {
    emit(FetchLoadingState());

    final result = await repository.getCommentsByPostId(id);

    switch (result) {
      case Right():
        emit(FetchLoadedState<List<CommentEntity>>(data: result.right));
      case Left():
        emit(FetchErrorState(message: result.left.message));
    }
  }
}
