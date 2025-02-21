/// Either class to handle two types of data
sealed class Either<L, R> {}

/// Left class to handle the left side of the data
final class Left<L, R> extends Either<L, R> {
  final L left;

  Left(this.left);
}

/// Right class to handle the right side of the data
final class Right<L, R> extends Either<L, R> {
  final R right;

  Right(this.right);
}
