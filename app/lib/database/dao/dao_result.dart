abstract class DaoResult<T> {}

class DaoSuccess<T> extends DaoResult<T> {
  DaoSuccess(this.data);

  final T data;
}

class DaoError<T> extends DaoResult<T> {
  DaoError(this.exception);

  final Exception exception;
}