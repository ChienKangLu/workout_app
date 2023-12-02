import 'package:flutter_test/flutter_test.dart';
import 'package:workout_app/model/result.dart';

T successData<T>(Result<T> result) {
  expect(result, isA<Success<T>>());
  return (result as Success<T>).data;
}

Exception errorException<T>(Result<T> result) {
  expect(result, isA<Error<T>>());
  return (result as Error<T>).exception;
}
