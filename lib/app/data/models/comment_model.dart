import 'package:pinapp_test/app/domain/entities/comment_entity.dart';

class CommentModel extends CommentEntity {
  /// A [CommentModel] constructor that receives the [postId], [id], [name], [email], and [body].
  CommentModel({
    required super.postId,
    required super.id,
    required super.name,
    required super.email,
    required super.body,
  });

  /// A method that parses a JSON object and returns a [CommentModel].
  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        postId: json['postId'],
        id: json['id'],
        name: json['name'],
        email: json['email'],
        body: json['body'],
      );
}
