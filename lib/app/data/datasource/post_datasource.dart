import 'package:flutter/services.dart';

/// [PostDatasource] is an abstract class that defines the methods that must be implemented by the [PostDatasourceImpl] class.
abstract class PostDatasource {
  /// [getAllPosts] is a method that returns a list of [PostEntity] objects.
  Future<String> getAllPosts();

  /// [getCommentsByPostId] is a method that returns a list of [CommentEntity] objects.
  Future<String> getCommentsByPostId(int postId);
}

class PostDatasourceImpl implements PostDatasource {
  /// [MethodChannel] is a class that provides a communication channel between the Dart code and the platform code.
  final _getAllPostsChannel = MethodChannel('methods/get-all-posts');
  final _getCommentsByPostIdChannel = MethodChannel('methods/get-comments-by-post-id');

  @override
  Future<String> getAllPosts() async {
    final result = await _getAllPostsChannel.invokeMethod<String>('getAllPosts');
    return result!;
  }

  @override
  Future<String> getCommentsByPostId(int postId) async {
    final result = await _getCommentsByPostIdChannel.invokeMethod<String>(
      'getCommentsByPostId',
      {
        'postId': postId,
      },
    );
    return result!;
  }
}
