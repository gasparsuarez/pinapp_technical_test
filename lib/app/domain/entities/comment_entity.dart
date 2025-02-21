class CommentEntity {
  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;

  CommentEntity({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });
}
