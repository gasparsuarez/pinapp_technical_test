import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinapp_test/app/core/DI/service_locator.dart';
import 'package:pinapp_test/app/domain/entities/comment_entity.dart';
import 'package:pinapp_test/app/presentation/bloc/fetch_state.dart';
import 'package:pinapp_test/app/presentation/bloc/get_post_cubit/get_post_cubit.dart';
import 'package:pinapp_test/app/presentation/widgets/comment_card.dart';
import 'package:pinapp_test/app/presentation/widgets/custom_loader.dart';
import 'package:pinapp_test/app/presentation/widgets/error_widget.dart';

class PostCommentPage extends StatelessWidget {
  const PostCommentPage({super.key, required this.postId});

  final String postId;

  static final routePath = '/post_comment_view/:id';
  static final routeName = 'post_comment_view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => GetPostCubit(sl())..getPost(int.tryParse(postId)!),
        child: BlocBuilder<GetPostCubit, FetchState>(
          builder: (context, state) => switch (state) {
            FetchInitialState() => const SizedBox.shrink(),
            FetchLoadingState() => CustomLoader(),
            FetchLoadedState(:final data as List<CommentEntity>) => _CommentListView(comments: data),
            FetchErrorState(:final message) => CustomErrorWidget(
                message: message,
                retryCallback: () => context.read<GetPostCubit>().getPost(int.tryParse(postId)!),
              ),
          },
        ),
      ),
    );
  }
}

class _CommentListView extends StatelessWidget {
  const _CommentListView({required this.comments});

  final List<CommentEntity> comments;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text('COMENTARIOS'),
          ),
          SliverList.builder(
            itemBuilder: (context, index) {
              final comment = comments[index];
              return CommentCard(comment: comment);
            },
            itemCount: comments.length,
          ),
        ],
      ),
    );
  }
}
