sealed class Result<T> {
  const Result();
}

class SuccessResult<T> extends Result<T> {
  final T data;

  const SuccessResult({required this.data});
}

class ErrorResult<T> extends Result<T> {
  final Exception exception;

  const ErrorResult({required this.exception});
}