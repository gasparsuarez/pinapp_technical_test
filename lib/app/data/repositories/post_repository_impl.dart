import 'dart:convert';
import 'dart:developer';

import 'package:pinapp_test/app/core/either_handler.dart';
import 'package:pinapp_test/app/data/datasource/post_datasource.dart';
import 'package:pinapp_test/app/data/models/comment_model.dart';
import 'package:pinapp_test/app/data/models/post_model.dart';
import 'package:pinapp_test/app/domain/entities/comment_entity.dart';
import 'package:pinapp_test/app/domain/entities/post_entity.dart';
import 'package:pinapp_test/app/domain/errors/custom_exception.dart';
import 'package:pinapp_test/app/domain/repositories/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final PostDatasource datasource;

  // Dependency Injection
  PostRepositoryImpl(this.datasource);

  @override
  Future<EitherResult<List<PostEntity>>> getAllPosts() async {
    try {
      final response = await datasource.getAllPosts();
      final rawJson = jsonDecode(response);
      final posts = (rawJson as List).map((e) => PostModel.fromJson(e)).toList();
      return Right(posts);
    } on Exception catch (e) {
      log(e.toString());
      return Left(CustomException(message: 'Ocurrió un error al obtener el listado de posts'));
    }
  }

  @override
  Future<EitherResult<List<CommentEntity>>> getCommentsByPostId(int postId) async {
    try {
      final response = await datasource.getCommentsByPostId(postId);
      final rawJson = jsonDecode(response);
      final comments = (rawJson as List).map((e) => CommentModel.fromJson(e)).toList();
      return Right(comments);
    } on Exception catch (e) {
      log(e.toString());
      return Left(CustomException(message: 'Ocurrió un error al obtener los comentarios'));
    }
  }
}
