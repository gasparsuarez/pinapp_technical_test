import 'package:go_router/go_router.dart';
import 'package:pinapp_test/app/presentation/pages/home_page.dart';
import 'package:pinapp_test/app/presentation/pages/post_comments_page.dart';

///    AppRouter
class AppRouter {
  /// Singleton instance of [GoRouter]
  static final GoRouter _router = GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(
        path: HomePage.routePath,
        name: HomePage.routeName,
        builder: (_, __) => HomePage(),
      ),
      GoRoute(
        path: PostCommentPage.routePath,
        name: PostCommentPage.routeName,
        builder: (context, state) {
          final postId = state.pathParameters['id']!;
          return PostCommentPage(postId: postId);
        },
      ),
    ],
  );

  /// Getter for [GoRouter]
  static GoRouter get router => _router;
}
