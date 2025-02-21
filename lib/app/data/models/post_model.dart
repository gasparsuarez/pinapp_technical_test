import 'package:pinapp_test/app/domain/entities/post_entity.dart';

class PostModel extends PostEntity {
  /// A [PostModel] constructor that receives the [userId], [id], [title], and [body].
  PostModel({
    required super.userId,
    required super.id,
    required super.title,
    required super.body,
  });

  /// A method that parses a JSON object and returns a [PostModel].
  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        userId: json['userId'],
        id: json['id'],
        title: json['title'],
        body: json['body'],
      );
}
