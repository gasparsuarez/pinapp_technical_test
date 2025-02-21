/// Custom exception class to handle errors in the application
class CustomException implements Exception {
  final String message;

  CustomException({required this.message});
}
