// lib/core/use_case/use_case.dart

// We will define this custom exception class later in `core/utils/failures.dart`
// For now, you can create a placeholder class.
class AppException implements Exception {
  const AppException({required this.message});
  final String message;
}

/// Abstract class for a synchronous use case.
abstract class UseCase<I, O> {
  const UseCase();

  /// The core logic of the use case.
  /// Throws an [AppException] if an error occurs.
  O unsafeExecute(I input);

  /// Executes the use case with built-in error handling.
  O execute(I input, {O Function(AppException e)? onError}) {
    try {
      return unsafeExecute(input);
    } on AppException catch (e) {
      if (onError != null) {
        return onError.call(e);
      } else {
        rethrow;
      }
    }
  }

  /// Executes the use case and returns null if an error occurs.
  O? executeOrNull(I input) {
    try {
      return unsafeExecute(input);
    } on AppException {
      return null;
    }
  }
}

/// Abstract class for an asynchronous use case returning a Future.
abstract class FutureUseCase<I, O> {
  const FutureUseCase();

  /// The core logic of the use case.
  /// Throws an [AppException] if an error occurs.
  Future<O> unsafeExecute(I input);

  /// Executes the use case with built-in error handling.
  Future<O> execute(I input,
      {Future<O> Function(AppException e)? onError}) async {
    try {
      return await unsafeExecute(input);
    } on AppException catch (e) {
      if (onError != null) {
        return await onError.call(e);
      } else {
        rethrow;
      }
    }
  }

  /// Executes the use case and returns null if an error occurs.
  Future<O?> executeOrNull(I input) async {
    try {
      return await unsafeExecute(input);
    } on AppException {
      return null;
    }
  }
}

/// Abstract class for a use case returning a Stream.
abstract class StreamUseCase<I, O> extends UseCase<I, Stream<O>> {
  const StreamUseCase();
}
