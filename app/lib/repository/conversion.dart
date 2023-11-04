import '../database/dao/dao_result.dart';
import '../database/model/workout_entity.dart';
import '../model/result.dart';
import '../model/workout.dart';

extension WorkoutConversion on Workout {
  WorkoutEntity asEntity() => WorkoutEntity(
        workoutId: workoutId,
        createDateTime: createDateTime.millisecondsSinceEpoch,
        startDateTime: startDateTime?.millisecondsSinceEpoch,
        endDateTime: endDateTime?.millisecondsSinceEpoch,
      );
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
