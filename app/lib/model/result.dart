abstract class Result<T> {}

class Success<T> extends Result<T> {
  Success(this.data);

  T data;
}

class Error<T> extends Result<T> {
  Error(this.exception);

  final Exception exception;
}