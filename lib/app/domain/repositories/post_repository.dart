import 'package:pinapp_test/app/core/either_handler.dart';
import 'package:pinapp_test/app/domain/entities/comment_entity.dart';
import 'package:pinapp_test/app/domain/entities/post_entity.dart';
import 'package:pinapp_test/app/domain/errors/custom_exception.dart';

/// [EitherResult] is a type alias for [Either] that uses [CustomException] as the left type and [T] as the right type.
typedef EitherResult<T> = Either<CustomException, T>;

/// [PostRepository] is an abstract class that defines the methods that must be implemented by the [PostRepositoryImpl] class.
abstract class PostRepository {
  /// [getAllPosts] is a method that returns a list of [PostEntity] objects.
  Future<EitherResult<List<PostEntity>>> getAllPosts();

  /// [getCommentsByPostId] is a method that returns a list of [CommentEntity] objects.
  Future<EitherResult<List<CommentEntity>>> getCommentsByPostId(int postId);
}
