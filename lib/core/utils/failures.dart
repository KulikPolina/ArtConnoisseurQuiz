// lib/core/utils/failures.dart

/// Base exception class for the application.
class AppException implements Exception {
  const AppException({required this.message, this.code});
  final String message;
  final int? code;
}

/// Exception for errors originating from the server or network.
class ServerException extends AppException {
  const ServerException({required super.message, super.code});
}
