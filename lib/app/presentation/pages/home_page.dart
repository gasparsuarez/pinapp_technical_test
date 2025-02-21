import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pinapp_test/app/core/DI/service_locator.dart';
import 'package:pinapp_test/app/domain/entities/post_entity.dart';
import 'package:pinapp_test/app/presentation/bloc/fetch_state.dart';
import 'package:pinapp_test/app/presentation/bloc/get_posts_cubit/get_posts_cubit.dart';
import 'package:pinapp_test/app/presentation/pages/post_comments_page.dart';
import 'package:pinapp_test/app/presentation/widgets/custom_loader.dart';
import 'package:pinapp_test/app/presentation/widgets/error_widget.dart';
import 'package:pinapp_test/app/presentation/widgets/post_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static final routePath = '/home';
  static final routeName = 'home';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetPostsCubit(sl())..getAllPosts(),
      child: Scaffold(
        body: BlocBuilder<GetPostsCubit, FetchState>(
          builder: (context, state) => switch (state) {
            FetchInitialState _ => SizedBox.shrink(),
            FetchLoadingState _ => CustomLoader(),
            FetchLoadedState(:final data as List<PostEntity>) => _PostListView(posts: data),
            FetchErrorState(:final message) => CustomErrorWidget(
                message: message,
                retryCallback: () => context.read<GetPostsCubit>().getAllPosts(),
              ),
          },
        ),
      ),
    );
  }
}

class _PostListView extends StatelessWidget {
  const _PostListView({required this.posts});

  final List<PostEntity> posts;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.teal,
          title: Text(
            'ÚLTIMOS POST',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        SliverList.builder(
          itemBuilder: (context, index) {
            final post = posts[index];
            return PostCard(
              post: post,
              onTap: (id) => context.pushNamed(
                PostCommentPage.routeName,
                pathParameters: {'id': post.id.toString()},
              ),
            );
          },
          itemCount: posts.length,
        )
      ],
    );
  }
}
