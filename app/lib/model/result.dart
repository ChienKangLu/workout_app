import '../database/dao/dao_result.dart';

abstract class Result<T> {}

class Success<T> extends Result<T> {
  Success(this.data);

  T data;
}

class Error<T> extends Result<T> {
  Error(this.exception);

  final Exception exception;
}

extension ResultExtension<T> on DaoResult<T> {
  Result<R> asResult<R>({R Function(T data)? convert}) {
    final it = this;
    if (it is DaoSuccess<T>) {
      final R convertedData;

      if (convert != null) {
        convertedData = convert(it.data);
      } else {
        convertedData = it.data as R;
      }

      return Success<R>(convertedData);
    }
    return Error((it as DaoError<T>).exception);
  }
}